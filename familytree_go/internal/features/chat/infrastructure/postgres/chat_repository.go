package postgres

import (
	"context"
	"database/sql"

	"github.com/mibi2007/familytree/familytree_go/internal/features/chat/domain"
)

type ChatRepository struct {
	db *sql.DB
}

func NewChatRepository(db *sql.DB) domain.ChatRepository {
	return &ChatRepository{db: db}
}

func (r *ChatRepository) SaveMessage(ctx context.Context, msg *domain.Message) error {
	query := `
		INSERT INTO chat_messages (id, family_id, sender_id, content, type, created_at)
		VALUES ($1, $2, $3, $4, $5, $6)
	`
	_, err := r.db.ExecContext(ctx, query, msg.ID, msg.FamilyID, msg.SenderID, msg.Content, msg.Type, msg.CreatedAt)
	return err
}

func (r *ChatRepository) ListMessages(ctx context.Context, familyID string, limit int, beforeID string) ([]*domain.Message, error) {
	var query string
	var args []interface{}

	if beforeID == "" {
		query = `
			SELECT id, family_id, sender_id, content, type, created_at
			FROM chat_messages
			WHERE family_id = $1
			ORDER BY created_at DESC
			LIMIT $2
		`
		args = []interface{}{familyID, limit}
	} else {
		query = `
			SELECT id, family_id, sender_id, content, type, created_at
			FROM chat_messages
			WHERE family_id = $1 AND created_at < (SELECT created_at FROM chat_messages WHERE id = $2)
			ORDER BY created_at DESC
			LIMIT $3
		`
		args = []interface{}{familyID, beforeID, limit}
	}

	rows, err := r.db.QueryContext(ctx, query, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var messages []*domain.Message
	for rows.Next() {
		var m domain.Message
		if err := rows.Scan(&m.ID, &m.FamilyID, &m.SenderID, &m.Content, &m.Type, &m.CreatedAt); err != nil {
			return nil, err
		}
		messages = append(messages, &m)
	}
	return messages, nil
}
