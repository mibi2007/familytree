package app

import (
	"context"
	"database/sql"
	"time"

	"cloud.google.com/go/storage"
	systemv1 "github.com/mibi2007/familytree/familytree_go/proto/system/v1"
	"google.golang.org/protobuf/types/known/timestamppb"
)

type SystemService struct {
	db  *sql.DB
	gcs *storage.Client
}

func NewSystemService(db *sql.DB, gcs *storage.Client) *SystemService {
	return &SystemService{
		db:  db,
		gcs: gcs,
	}
}

func (s *SystemService) GetHealthStatus(ctx context.Context) (*systemv1.HealthCheckResponse, error) {
	response := &systemv1.HealthCheckResponse{
		CheckedAt: timestamppb.Now(),
	}

	// Check Server
	response.Server = &systemv1.ComponentStatus{
		Name:           "Server",
		Status:         "OK",
		Message:        "Service is running",
		ResponseTimeMs: 0,
	}

	// Check Database
	dbStatus := s.checkDatabase(ctx)
	response.Database = dbStatus

	// Check GCS Storage
	gcsStatus := s.checkGCS(ctx)
	response.Storage = gcsStatus

	// Calculate Overall Status
	response.OverallStatus = s.calculateOverallStatus(dbStatus, gcsStatus)

	return response, nil
}

func (s *SystemService) checkDatabase(ctx context.Context) *systemv1.ComponentStatus {
	start := time.Now()

	if s.db == nil {
		return &systemv1.ComponentStatus{
			Name:           "PostgreSQL",
			Status:         "UNAVAILABLE",
			Message:        "Database connection not initialized",
			ResponseTimeMs: 0,
		}
	}

	if err := s.db.PingContext(ctx); err != nil {
		return &systemv1.ComponentStatus{
			Name:           "PostgreSQL",
			Status:         "ERROR",
			Message:        err.Error(),
			ResponseTimeMs: time.Since(start).Milliseconds(),
		}
	}

	return &systemv1.ComponentStatus{
		Name:           "PostgreSQL",
		Status:         "OK",
		Message:        "Connected",
		ResponseTimeMs: time.Since(start).Milliseconds(),
	}
}

func (s *SystemService) checkGCS(ctx context.Context) *systemv1.ComponentStatus {
	start := time.Now()

	if s.gcs == nil {
		return &systemv1.ComponentStatus{
			Name:           "Google Cloud Storage",
			Status:         "UNAVAILABLE",
			Message:        "GCS client not initialized",
			ResponseTimeMs: 0,
		}
	}

	// Try to list buckets as a health check
	_, err := s.gcs.Buckets(ctx, "familytree-db-all").Next()
	if err != nil && err.Error() != "no more items in iterator" {
		return &systemv1.ComponentStatus{
			Name:           "Google Cloud Storage",
			Status:         "ERROR",
			Message:        err.Error(),
			ResponseTimeMs: time.Since(start).Milliseconds(),
		}
	}

	return &systemv1.ComponentStatus{
		Name:           "Google Cloud Storage",
		Status:         "OK",
		Message:        "Connected",
		ResponseTimeMs: time.Since(start).Milliseconds(),
	}
}

func (s *SystemService) calculateOverallStatus(dbStatus, gcsStatus *systemv1.ComponentStatus) string {
	if dbStatus.Status == "ERROR" || gcsStatus.Status == "ERROR" {
		return "UNHEALTHY"
	}
	if dbStatus.Status == "UNAVAILABLE" || gcsStatus.Status == "UNAVAILABLE" {
		return "DEGRADED"
	}
	return "HEALTHY"
}
