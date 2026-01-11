package grpc

import (
	"context"

	"github.com/mibi2007/familytree/familytree_go/internal/features/chat/application"
	"github.com/mibi2007/familytree/familytree_go/internal/features/chat/domain"
	chatv1 "github.com/mibi2007/familytree/familytree_go/proto/chat/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/timestamppb"
)

type ChatHandler struct {
	chatv1.UnimplementedChatServiceServer
	appService *application.ChatService
}

func NewChatHandler(appService *application.ChatService) *ChatHandler {
	return &ChatHandler{appService: appService}
}

func (h *ChatHandler) SendMessage(ctx context.Context, req *chatv1.SendMessageRequest) (*chatv1.Message, error) {
	msg, err := h.appService.SendMessage(ctx, req.FamilyId, req.Content, mapProtoTypeToDomain(req.Type))
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to send message: %v", err)
	}
	return mapMessageToProto(msg), nil
}

func (h *ChatHandler) ListMessages(ctx context.Context, req *chatv1.ListMessagesRequest) (*chatv1.ListMessagesResponse, error) {
	msgs, err := h.appService.ListMessages(ctx, req.FamilyId, int(req.Limit), req.BeforeId)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to list messages: %v", err)
	}

	protoMsgs := make([]*chatv1.Message, len(msgs))
	for i, m := range msgs {
		protoMsgs[i] = mapMessageToProto(m)
	}

	return &chatv1.ListMessagesResponse{Messages: protoMsgs}, nil
}

func (h *ChatHandler) StreamMessages(req *chatv1.StreamMessagesRequest, stream chatv1.ChatService_StreamMessagesServer) error {
	ch, cleanup := h.appService.StreamMessages(stream.Context(), req.FamilyId)
	defer cleanup()

	for {
		select {
		case <-stream.Context().Done():
			return nil
		case msg, ok := <-ch:
			if !ok {
				return nil
			}
			if err := stream.Send(mapMessageToProto(msg)); err != nil {
				return err
			}
		}
	}
}

func mapMessageToProto(m *domain.Message) *chatv1.Message {
	return &chatv1.Message{
		Id:        m.ID,
		FamilyId:  m.FamilyID,
		SenderId:  m.SenderID,
		Content:   m.Content,
		Type:      mapDomainTypeToProto(m.Type),
		CreatedAt: timestamppb.New(m.CreatedAt),
	}
}

func mapDomainTypeToProto(t domain.MessageType) chatv1.MessageType {
	switch t {
	case domain.MessageTypeText:
		return chatv1.MessageType_MESSAGE_TYPE_TEXT
	case domain.MessageTypeSystem:
		return chatv1.MessageType_MESSAGE_TYPE_SYSTEM
	case domain.MessageTypeAI:
		return chatv1.MessageType_MESSAGE_TYPE_AI
	default:
		return chatv1.MessageType_MESSAGE_TYPE_UNSPECIFIED
	}
}

func mapProtoTypeToDomain(t chatv1.MessageType) domain.MessageType {
	switch t {
	case chatv1.MessageType_MESSAGE_TYPE_TEXT:
		return domain.MessageTypeText
	case chatv1.MessageType_MESSAGE_TYPE_SYSTEM:
		return domain.MessageTypeSystem
	case chatv1.MessageType_MESSAGE_TYPE_AI:
		return domain.MessageTypeAI
	default:
		return domain.MessageTypeText
	}
}
