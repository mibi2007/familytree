package grpc

import (
	"context"
	"errors"

	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/app"
	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	aiv1 "github.com/mibi2007/familytree/familytree_go/proto/ai/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type AIHandler struct {
	aiv1.UnimplementedAIServiceServer
	bootstrap *app.BootstrapService
	assistant *app.AssistantService
}

func NewAIHandler(bootstrap *app.BootstrapService, assistant ...*app.AssistantService) *AIHandler {
	handler := &AIHandler{bootstrap: bootstrap}
	if len(assistant) > 0 {
		handler.assistant = assistant[0]
	}
	return handler
}

func (h *AIHandler) Ready() bool {
	return h != nil && h.bootstrap != nil && h.bootstrap.Ready()
}

func (h *AIHandler) Ask(ctx context.Context, req *aiv1.AskRequest) (*aiv1.AskResponse, error) {
	user := middleware.GetUser(ctx)
	if user == nil {
		return nil, status.Error(codes.Unauthenticated, "authentication required")
	}
	if h == nil || h.assistant == nil {
		return nil, status.Error(codes.Unavailable, "ai service is unavailable")
	}

	recommendation, err := h.assistant.Ask(ctx, user.UID, mapRequest(req))
	if err != nil {
		return nil, mapError(err)
	}
	return &aiv1.AskResponse{
		Answer:   recommendation.Answer,
		Provider: recommendation.Provider,
		Final:    true,
	}, nil
}

func (h *AIHandler) AskStream(req *aiv1.AskRequest, stream aiv1.AIService_AskStreamServer) error {
	response, err := h.Ask(stream.Context(), req)
	if err != nil {
		return err
	}
	return stream.Send(response)
}

func mapRequest(req *aiv1.AskRequest) *domain.AIPrompt {
	if req == nil {
		return nil
	}
	return &domain.AIPrompt{
		FamilyID:        req.FamilyId,
		ActingMemberID:  req.ActingMemberId,
		Question:        req.Question,
		ConversationRef: req.ConversationRef,
		GroupChat:       req.GroupChat,
	}
}

func mapError(err error) error {
	switch {
	case errors.Is(err, domain.ErrSelectedFamilyRequired),
		errors.Is(err, domain.ErrActingMemberRequired),
		errors.Is(err, domain.ErrQuestionRequired):
		return status.Error(codes.InvalidArgument, err.Error())
	case errors.Is(err, domain.ErrFamilyAccessDenied):
		return status.Error(codes.PermissionDenied, err.Error())
	case errors.Is(err, domain.ErrAIUnavailable):
		return status.Error(codes.Unavailable, err.Error())
	default:
		return status.Error(codes.Internal, "ai request failed")
	}
}
