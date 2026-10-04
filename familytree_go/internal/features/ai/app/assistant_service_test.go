package app

import (
	"context"
	"testing"

	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/domain"
	"github.com/stretchr/testify/require"
)

type agentStub struct {
	prompt *domain.AIPrompt
	result *domain.AIRecommendation
	err    error
}

func (s *agentStub) Generate(_ context.Context, prompt *domain.AIPrompt) (*domain.AIRecommendation, error) {
	s.prompt = prompt
	return s.result, s.err
}

type groupReplyStub struct {
	familyID string
	answer   string
}

func (s *groupReplyStub) PublishAIReply(_ context.Context, familyID, answer string) error {
	s.familyID = familyID
	s.answer = answer
	return nil
}

type accessStub struct {
	userID   string
	familyID string
	allowed  bool
	err      error
}

func (s *accessStub) HasFamilyAccess(_ context.Context, userID, familyID string) (bool, error) {
	s.userID = userID
	s.familyID = familyID
	return s.allowed, s.err
}

func TestAssistantServiceAsk_AuthorizesBuildsContextAndGenerates(t *testing.T) {
	repository := &contextRepositoryStub{}
	builder := NewContextBuilder(repository, EmptyTitleMappingService{})
	agent := &agentStub{result: &domain.AIRecommendation{Answer: "answer", Provider: "gemini"}}
	access := &accessStub{allowed: true}
	service := NewAssistantService(builder, agent, access)
	prompt := &domain.AIPrompt{FamilyID: "family-1", ActingMemberID: "member-1", Question: "question"}

	result, err := service.Ask(context.Background(), "user-1", prompt)

	require.NoError(t, err)
	require.Equal(t, "answer", result.Answer)
	require.Equal(t, "user-1", access.userID)
	require.Equal(t, "family-1", access.familyID)
	require.Equal(t, "user-1", agent.prompt.UserID)
	require.NotNil(t, agent.prompt.Context)
}

func TestAssistantServiceAsk_GroupChatPublishesTrustedReply(t *testing.T) {
	replies := &groupReplyStub{}
	service := NewAssistantService(
		NewContextBuilder(&contextRepositoryStub{}, nil),
		&agentStub{result: &domain.AIRecommendation{Answer: "answer", Provider: "gemini"}},
		&accessStub{allowed: true},
		replies,
	)

	_, err := service.Ask(context.Background(), "user-1", &domain.AIPrompt{
		FamilyID: "family-1", ActingMemberID: "member-1", Question: "@family question", GroupChat: true,
	})

	require.NoError(t, err)
	require.Equal(t, "family-1", replies.familyID)
	require.Equal(t, "answer", replies.answer)
}

func TestAssistantServiceAsk_DeniesFamilyBeforeContextOrGeneration(t *testing.T) {
	repository := &contextRepositoryStub{}
	agent := &agentStub{}
	service := NewAssistantService(NewContextBuilder(repository, nil), agent, &accessStub{allowed: false})

	_, err := service.Ask(context.Background(), "user-1", &domain.AIPrompt{
		FamilyID: "family-1", ActingMemberID: "member-1", Question: "question",
	})

	require.ErrorIs(t, err, domain.ErrFamilyAccessDenied)
	require.Empty(t, repository.snapshotFamilyID)
	require.Nil(t, agent.prompt)
}

func TestAssistantServiceAsk_ValidatesRequest(t *testing.T) {
	service := NewAssistantService(nil, nil, nil)

	_, err := service.Ask(context.Background(), "user-1", &domain.AIPrompt{})
	require.ErrorIs(t, err, domain.ErrSelectedFamilyRequired)

	_, err = service.Ask(context.Background(), "user-1", &domain.AIPrompt{FamilyID: "family-1"})
	require.ErrorIs(t, err, domain.ErrActingMemberRequired)

	_, err = service.Ask(context.Background(), "user-1", &domain.AIPrompt{FamilyID: "family-1", ActingMemberID: "member-1"})
	require.ErrorIs(t, err, domain.ErrQuestionRequired)
}
