package postgres

import (
	"context"
	"database/sql"

	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/domain"
)

type ContextRepository struct {
	db *sql.DB
}

func NewContextRepository(db *sql.DB) domain.ContextRepository {
	return &ContextRepository{db: db}
}

func (r *ContextRepository) GetLatestSnapshot(ctx context.Context, familyID string) (*domain.FamilySnapshot, error) {
	const query = `
		SELECT family_id, version_hash, tree_data, updated_at
		FROM family_tree_snapshots
		WHERE family_id = $1
	`

	var snapshot domain.FamilySnapshot
	if err := r.db.QueryRowContext(ctx, query, familyID).Scan(
		&snapshot.FamilyID,
		&snapshot.VersionHash,
		&snapshot.TreeData,
		&snapshot.UpdatedAt,
	); err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, err
	}
	return &snapshot, nil
}

func (r *ContextRepository) ListRelevantHistory(ctx context.Context, familyID string, limit int) ([]domain.ContextMessage, error) {
	const query = `
		SELECT type, content, created_at
		FROM chat_messages
		WHERE family_id = $1
		ORDER BY created_at DESC
		LIMIT $2
	`

	rows, err := r.db.QueryContext(ctx, query, familyID, limit)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	messages := make([]domain.ContextMessage, 0)
	for rows.Next() {
		var messageType string
		var message domain.ContextMessage
		if err := rows.Scan(&messageType, &message.Content, &message.CreatedAt); err != nil {
			return nil, err
		}
		message.Role = roleForMessageType(messageType)
		messages = append(messages, message)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}

	for left, right := 0, len(messages)-1; left < right; left, right = left+1, right-1 {
		messages[left], messages[right] = messages[right], messages[left]
	}
	return messages, nil
}

func roleForMessageType(messageType string) domain.MessageRole {
	switch messageType {
	case "AI":
		return domain.MessageRoleModel
	case "SYSTEM":
		return domain.MessageRoleSystem
	default:
		return domain.MessageRoleUser
	}
}
