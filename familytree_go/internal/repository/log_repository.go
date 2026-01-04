package repository

import (
	"context"
	"database/sql"
	"encoding/json"
	"time"

	"github.com/google/uuid"
)

type AuditLog struct {
	ID        uuid.UUID
	AdminID   string
	TargetID  uuid.UUID
	Action    string
	Metadata  map[string]interface{}
	CreatedAt time.Time
}

type LogRepository struct {
	db *sql.DB
}

func NewLogRepository(db *sql.DB) *LogRepository {
	return &LogRepository{db: db}
}

func (r *LogRepository) CreateAuditLog(ctx context.Context, log *AuditLog) error {
	metadataJSON, err := json.Marshal(log.Metadata)
	if err != nil {
		return err
	}

	query := `
		INSERT INTO admin_activity_logs (admin_id, target_id, action, metadata, created_at)
		VALUES ($1, $2, $3, $4, $5)
	`
	_, err = r.db.ExecContext(ctx, query,
		log.AdminID, log.TargetID, log.Action, metadataJSON, log.CreatedAt,
	)
	return err
}
