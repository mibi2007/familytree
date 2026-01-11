package domain

import (
	"context"
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

type LogRepository interface {
	CreateAuditLog(ctx context.Context, log *AuditLog) error
}
