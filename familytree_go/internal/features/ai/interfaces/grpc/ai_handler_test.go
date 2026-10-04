package grpc

import (
	"context"
	"testing"

	firebaseauth "firebase.google.com/go/v4/auth"
	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/app"
	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/data/genkit"
	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	aiv1 "github.com/mibi2007/familytree/familytree_go/proto/ai/v1"
	"github.com/stretchr/testify/require"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

func TestAIHandlerReady_DisabledFoundationIsReady(t *testing.T) {
	bootstrap := app.NewBootstrapService(genkit.ProviderConfig{})
	require.NoError(t, bootstrap.Initialize(context.Background()))

	handler := NewAIHandler(bootstrap)

	require.True(t, handler.Ready())
}

func TestAIHandlerReady_UninitializedFoundationIsNotReady(t *testing.T) {
	handler := NewAIHandler(app.NewBootstrapService(genkit.ProviderConfig{
		Enabled:      true,
		ProviderName: genkit.GeminiProvider,
		GeminiAPIKey: "test-key",
	}))

	require.False(t, handler.Ready())
}

func TestAIHandlerReady_NilDependenciesAreNotReady(t *testing.T) {
	var nilHandler *AIHandler

	require.False(t, nilHandler.Ready())
	require.False(t, NewAIHandler(nil).Ready())
}

type handlerContextRepository struct{}

func (handlerContextRepository) GetLatestSnapshot(context.Context, string) (*domain.FamilySnapshot, error) {
	return nil, nil
}

func (handlerContextRepository) ListRelevantHistory(context.Context, string, int) ([]domain.ContextMessage, error) {
	return nil, nil
}

type handlerAgent struct{}

func (handlerAgent) Generate(context.Context, *domain.AIPrompt) (*domain.AIRecommendation, error) {
	return &domain.AIRecommendation{Answer: "answer", Provider: "gemini"}, nil
}

type handlerAccess struct{ allowed bool }

func (a handlerAccess) HasFamilyAccess(context.Context, string, string) (bool, error) {
	return a.allowed, nil
}

func TestAIHandlerAsk_RequiresAuthentication(t *testing.T) {
	handler := NewAIHandler(nil, app.NewAssistantService(nil, nil, nil))

	_, err := handler.Ask(context.Background(), &aiv1.AskRequest{})

	require.Equal(t, codes.Unauthenticated, status.Code(err))
}

func TestAIHandlerAsk_AuthenticatedRequestCallsApplicationService(t *testing.T) {
	builder := app.NewContextBuilder(handlerContextRepository{}, app.EmptyTitleMappingService{})
	assistant := app.NewAssistantService(builder, handlerAgent{}, handlerAccess{allowed: true})
	handler := NewAIHandler(nil, assistant)
	ctx := context.WithValue(context.Background(), middleware.UserContextKey, &firebaseauth.Token{UID: "user-1"})

	response, err := handler.Ask(ctx, &aiv1.AskRequest{
		FamilyId:       "family-1",
		ActingMemberId: "member-1",
		Question:       "question",
	})

	require.NoError(t, err)
	require.Equal(t, "answer", response.Answer)
	require.Equal(t, "gemini", response.Provider)
	require.True(t, response.Final)
}

func TestAIHandlerAsk_MapsFamilyAccessDenied(t *testing.T) {
	builder := app.NewContextBuilder(handlerContextRepository{}, nil)
	assistant := app.NewAssistantService(builder, handlerAgent{}, handlerAccess{allowed: false})
	handler := NewAIHandler(nil, assistant)
	ctx := context.WithValue(context.Background(), middleware.UserContextKey, &firebaseauth.Token{UID: "user-1"})

	_, err := handler.Ask(ctx, &aiv1.AskRequest{
		FamilyId:       "family-1",
		ActingMemberId: "member-1",
		Question:       "question",
	})

	require.Equal(t, codes.PermissionDenied, status.Code(err))
}
