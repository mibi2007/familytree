package app

import (
	"context"
	"fmt"
	"strings"

	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/domain"
)

type AssistantService struct {
	contextBuilder *ContextBuilder
	agent          domain.IAIAgentService
	familyAccess   domain.FamilyAccessService
	groupReplies   domain.GroupReplyPublisher
}

func NewAssistantService(contextBuilder *ContextBuilder, agent domain.IAIAgentService, familyAccess domain.FamilyAccessService, groupReplies ...domain.GroupReplyPublisher) *AssistantService {
	service := &AssistantService{
		contextBuilder: contextBuilder,
		agent:          agent,
		familyAccess:   familyAccess,
	}
	if len(groupReplies) > 0 {
		service.groupReplies = groupReplies[0]
	}
	return service
}

func (s *AssistantService) Ask(ctx context.Context, userID string, prompt *domain.AIPrompt) (*domain.AIRecommendation, error) {
	userID = strings.TrimSpace(userID)
	if userID == "" {
		return nil, domain.ErrAIUnavailable
	}
	if prompt == nil {
		return nil, domain.ErrQuestionRequired
	}
	prompt.FamilyID = strings.TrimSpace(prompt.FamilyID)
	prompt.ActingMemberID = strings.TrimSpace(prompt.ActingMemberID)
	prompt.Question = strings.TrimSpace(prompt.Question)
	if prompt.FamilyID == "" {
		return nil, domain.ErrSelectedFamilyRequired
	}
	if prompt.ActingMemberID == "" {
		return nil, domain.ErrActingMemberRequired
	}
	if prompt.Question == "" {
		return nil, domain.ErrQuestionRequired
	}
	if s.contextBuilder == nil || s.agent == nil || s.familyAccess == nil {
		return nil, domain.ErrAIUnavailable
	}

	allowed, err := s.familyAccess.HasFamilyAccess(ctx, userID, prompt.FamilyID)
	if err != nil {
		return nil, fmt.Errorf("verify family access: %w", err)
	}
	if !allowed {
		return nil, domain.ErrFamilyAccessDenied
	}

	prompt.UserID = userID
	prompt.Context, err = s.contextBuilder.Build(ctx, prompt.FamilyID, prompt.ActingMemberID)
	if err != nil {
		return nil, err
	}
	recommendation, err := s.agent.Generate(ctx, prompt)
	if err != nil {
		return nil, err
	}
	if prompt.GroupChat {
		if s.groupReplies == nil {
			return nil, domain.ErrAIUnavailable
		}
		if err := s.groupReplies.PublishAIReply(ctx, prompt.FamilyID, recommendation.Answer); err != nil {
			return nil, fmt.Errorf("publish group ai reply: %w", err)
		}
	}
	return recommendation, nil
}
