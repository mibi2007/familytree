package app

import (
	"context"
	"errors"
	"testing"
	"time"

	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/domain"
	"github.com/stretchr/testify/require"
)

type contextRepositoryStub struct {
	snapshot         *domain.FamilySnapshot
	history          []domain.ContextMessage
	snapshotFamilyID string
	historyFamilyID  string
	historyLimit     int
	snapshotErr      error
	historyErr       error
}

func (s *contextRepositoryStub) GetLatestSnapshot(_ context.Context, familyID string) (*domain.FamilySnapshot, error) {
	s.snapshotFamilyID = familyID
	return s.snapshot, s.snapshotErr
}

func (s *contextRepositoryStub) ListRelevantHistory(_ context.Context, familyID string, limit int) ([]domain.ContextMessage, error) {
	s.historyFamilyID = familyID
	s.historyLimit = limit
	return s.history, s.historyErr
}

type titleMappingStub struct {
	familyID       string
	actingMemberID string
	mapping        map[string]string
	err            error
}

func (s *titleMappingStub) BuildTitleMapping(_ context.Context, familyID, actingMemberID string) (map[string]string, error) {
	s.familyID = familyID
	s.actingMemberID = actingMemberID
	return s.mapping, s.err
}

func TestContextBuilderBuild_UsesSelectedFamilyRelevantHistoryAndActingMember(t *testing.T) {
	now := time.Now()
	repository := &contextRepositoryStub{
		snapshot: &domain.FamilySnapshot{
			FamilyID:    "family-1",
			VersionHash: "v1",
			TreeData:    []byte(`{"members":[{"id":"member-1"}]}`),
		},
		history: []domain.ContextMessage{{Role: domain.MessageRoleUser, Content: "hello", CreatedAt: now}},
	}
	mapping := &titleMappingStub{mapping: map[string]string{"Mẹ": "member-1"}}
	builder := NewContextBuilder(repository, mapping)

	result, err := builder.Build(context.Background(), " family-1 ", " member-2 ")

	require.NoError(t, err)
	require.Equal(t, "family-1", result.FamilyID)
	require.Equal(t, "member-2", result.ActingMemberID)
	require.Equal(t, `{"members":[{"id":"member-1"}]}`, result.SnapshotSummary)
	require.Equal(t, repository.history, result.History)
	require.Equal(t, map[string]string{"Mẹ": "member-1"}, result.TitleToMember)
	require.Equal(t, "family-1", repository.snapshotFamilyID)
	require.Equal(t, "family-1", repository.historyFamilyID)
	require.Equal(t, DefaultHistoryLimit, repository.historyLimit)
	require.Equal(t, "family-1", mapping.familyID)
	require.Equal(t, "member-2", mapping.actingMemberID)
}

func TestContextBuilderBuild_MissingSnapshotUsesSafeFallback(t *testing.T) {
	builder := NewContextBuilder(&contextRepositoryStub{}, EmptyTitleMappingService{})

	result, err := builder.Build(context.Background(), "family-1", "member-1")

	require.NoError(t, err)
	require.Nil(t, result.Snapshot)
	require.Equal(t, "No family tree snapshot is available for the selected family.", result.SnapshotSummary)
	require.Empty(t, result.TitleToMember)
}

func TestContextBuilderBuild_RequiresSelectedFamilyAndActingMember(t *testing.T) {
	builder := NewContextBuilder(&contextRepositoryStub{}, nil)

	_, err := builder.Build(context.Background(), "", "member-1")
	require.ErrorIs(t, err, domain.ErrSelectedFamilyRequired)

	_, err = builder.Build(context.Background(), "family-1", "")
	require.ErrorIs(t, err, domain.ErrActingMemberRequired)
}

func TestContextBuilderBuild_PropagatesDependencyErrors(t *testing.T) {
	repository := &contextRepositoryStub{snapshotErr: errors.New("database unavailable")}
	builder := NewContextBuilder(repository, nil)

	_, err := builder.Build(context.Background(), "family-1", "member-1")

	require.ErrorContains(t, err, "load family snapshot")
}
