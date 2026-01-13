package app

import (
	"context"
	"testing"

	"firebase.google.com/go/v4/auth"
	"github.com/mibi2007/familytree/familytree_go/internal/features/chat/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	"github.com/stretchr/testify/assert"
)

type mockChatRepo struct {
	messages []*domain.Message
}

func (m *mockChatRepo) SaveMessage(ctx context.Context, msg *domain.Message) error {
	m.messages = append(m.messages, msg)
	return nil
}

func (m *mockChatRepo) ListMessages(ctx context.Context, familyID string, limit int, beforeID string) ([]*domain.Message, error) {
	return m.messages, nil
}

type mockPublisher struct {
	published []*domain.Message
}

func (m *mockPublisher) Publish(msg *domain.Message) {
	m.published = append(m.published, msg)
}

func (m *mockPublisher) Subscribe(familyID string) (<-chan *domain.Message, func()) {
	return nil, func() {}
}

func TestSendMessage(t *testing.T) {
	repo := &mockChatRepo{}
	pub := &mockPublisher{}
	service := NewChatService(repo, pub)

	ctx := context.WithValue(context.Background(), middleware.UserContextKey, &auth.Token{UID: "user-1"})

	msg, err := service.SendMessage(ctx, "family-1", "Hello", domain.MessageTypeText)
	assert.NoError(t, err)
	assert.NotNil(t, msg)
	assert.Equal(t, "user-1", msg.SenderID)
	assert.Equal(t, "Hello", msg.Content)
	assert.Equal(t, 1, len(repo.messages))
	assert.Equal(t, 1, len(pub.published))
}
