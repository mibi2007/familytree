package postgres

import (
	"context"
	"database/sql"
	"encoding/json"

	"github.com/mibi2007/familytree/familytree_go/internal/features/system/domain"
)

type LogRepository struct {
	db *sql.DB
}

func NewLogRepository(db *sql.DB) domain.LogRepository {
	return &LogRepository{db: db}
}

func (r *LogRepository) CreateAuditLog(ctx context.Context, log *domain.AuditLog) error {
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
