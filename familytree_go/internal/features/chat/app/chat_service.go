package app

import (
	"context"
	"fmt"
	"time"

	"github.com/mibi2007/familytree/familytree_go/internal/features/chat/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
)

type ChatService struct {
	repo      domain.ChatRepository
	publisher domain.ChatPublisher
}

func NewChatService(repo domain.ChatRepository, publisher domain.ChatPublisher) *ChatService {
	return &ChatService{
		repo:      repo,
		publisher: publisher,
	}
}

func (s *ChatService) SendMessage(ctx context.Context, familyID, content string, msgType domain.MessageType) (*domain.Message, error) {
	user := middleware.GetUser(ctx)
	if user == nil {
		return nil, fmt.Errorf("unauthenticated")
	}

	msg := &domain.Message{
		ID:        fmt.Sprintf("msg_%d", time.Now().UnixNano()),
		FamilyID:  familyID,
		SenderID:  user.UID,
		Content:   content,
		Type:      msgType,
		CreatedAt: time.Now(),
	}

	if err := s.repo.SaveMessage(ctx, msg); err != nil {
		return nil, err
	}

	s.publisher.Publish(msg)

	return msg, nil
}

func (s *ChatService) ListMessages(ctx context.Context, familyID string, limit int, beforeID string) ([]*domain.Message, error) {
	return s.repo.ListMessages(ctx, familyID, limit, beforeID)
}

func (s *ChatService) StreamMessages(ctx context.Context, familyID string) (<-chan *domain.Message, func()) {
	return s.publisher.Subscribe(familyID)
}
