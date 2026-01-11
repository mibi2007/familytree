package domain

import (
	"context"
	"time"
)

type MessageType string

const (
	MessageTypeText   MessageType = "TEXT"
	MessageTypeSystem MessageType = "SYSTEM"
	MessageTypeAI     MessageType = "AI"
)

type Message struct {
	ID        string      `json:"id"`
	FamilyID  string      `json:"family_id"`
	SenderID  string      `json:"sender_id"`
	Content   string      `json:"content"`
	Type      MessageType `json:"type"`
	CreatedAt time.Time   `json:"created_at"`
}

type ChatRepository interface {
	SaveMessage(ctx context.Context, msg *Message) error
	ListMessages(ctx context.Context, familyID string, limit int, beforeID string) ([]*Message, error)
}

type ChatPublisher interface {
	Publish(msg *Message)
	Subscribe(familyID string) (<-chan *Message, func())
}
