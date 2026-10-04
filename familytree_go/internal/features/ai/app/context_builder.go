package app

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/domain"
)

const DefaultHistoryLimit = 50

// ContextBuilder assembles privacy-bounded context for the selected family.
type ContextBuilder struct {
	repository   domain.ContextRepository
	titleMapping domain.TitleMappingService
	historyLimit int
}

func NewContextBuilder(repository domain.ContextRepository, titleMapping domain.TitleMappingService) *ContextBuilder {
	return &ContextBuilder{
		repository:   repository,
		titleMapping: titleMapping,
		historyLimit: DefaultHistoryLimit,
	}
}

func (b *ContextBuilder) Build(ctx context.Context, selectedFamilyID, actingMemberID string) (*domain.FamilyContext, error) {
	selectedFamilyID = strings.TrimSpace(selectedFamilyID)
	actingMemberID = strings.TrimSpace(actingMemberID)
	if selectedFamilyID == "" {
		return nil, domain.ErrSelectedFamilyRequired
	}
	if actingMemberID == "" {
		return nil, domain.ErrActingMemberRequired
	}
	if b.repository == nil {
		return nil, fmt.Errorf("ai context repository is not configured")
	}

	snapshot, err := b.repository.GetLatestSnapshot(ctx, selectedFamilyID)
	if err != nil {
		return nil, fmt.Errorf("load family snapshot: %w", err)
	}
	history, err := b.repository.ListRelevantHistory(ctx, selectedFamilyID, b.historyLimit)
	if err != nil {
		return nil, fmt.Errorf("load relevant chat history: %w", err)
	}

	titleMapping := map[string]string{}
	if b.titleMapping != nil {
		titleMapping, err = b.titleMapping.BuildTitleMapping(ctx, selectedFamilyID, actingMemberID)
		if err != nil {
			return nil, fmt.Errorf("build title mapping: %w", err)
		}
		if titleMapping == nil {
			titleMapping = map[string]string{}
		}
	}

	return &domain.FamilyContext{
		FamilyID:        selectedFamilyID,
		ActingMemberID:  actingMemberID,
		Snapshot:        snapshot,
		SnapshotSummary: summarizeSnapshot(snapshot),
		History:         history,
		TitleToMember:   titleMapping,
	}, nil
}

func summarizeSnapshot(snapshot *domain.FamilySnapshot) string {
	if snapshot == nil || len(snapshot.TreeData) == 0 {
		return "No family tree snapshot is available for the selected family."
	}

	var tree any
	if err := json.Unmarshal(snapshot.TreeData, &tree); err != nil {
		return fmt.Sprintf("Family tree snapshot %s is available but could not be summarized.", snapshot.VersionHash)
	}
	compact, err := json.Marshal(tree)
	if err != nil {
		return fmt.Sprintf("Family tree snapshot %s is available but could not be summarized.", snapshot.VersionHash)
	}
	return string(compact)
}
