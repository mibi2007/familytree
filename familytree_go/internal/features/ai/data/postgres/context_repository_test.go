package postgres

import (
	"context"
	"database/sql"
	"testing"
	"time"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/domain"
	"github.com/stretchr/testify/require"
)

func TestContextRepositoryGetLatestSnapshot_ReturnsSnapshot(t *testing.T) {
	db, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer db.Close()

	now := time.Now()
	mock.ExpectQuery("SELECT family_id, version_hash, tree_data, updated_at").
		WithArgs("family-1").
		WillReturnRows(sqlmock.NewRows([]string{"family_id", "version_hash", "tree_data", "updated_at"}).
			AddRow("family-1", "v1", []byte(`{"members":[]}`), now))

	snapshot, err := NewContextRepository(db).GetLatestSnapshot(context.Background(), "family-1")

	require.NoError(t, err)
	require.Equal(t, "family-1", snapshot.FamilyID)
	require.Equal(t, "v1", snapshot.VersionHash)
	require.NoError(t, mock.ExpectationsWereMet())
}

func TestContextRepositoryGetLatestSnapshot_MissingReturnsNil(t *testing.T) {
	db, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer db.Close()

	mock.ExpectQuery("SELECT family_id, version_hash, tree_data, updated_at").
		WithArgs("family-1").
		WillReturnError(sql.ErrNoRows)

	snapshot, err := NewContextRepository(db).GetLatestSnapshot(context.Background(), "family-1")

	require.NoError(t, err)
	require.Nil(t, snapshot)
	require.NoError(t, mock.ExpectationsWereMet())
}

func TestContextRepositoryListRelevantHistory_MapsRolesAndReturnsChronologicalOrder(t *testing.T) {
	db, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer db.Close()

	older := time.Now().Add(-time.Minute)
	newer := time.Now()
	mock.ExpectQuery("SELECT type, content, created_at").
		WithArgs("family-1", 50).
		WillReturnRows(sqlmock.NewRows([]string{"type", "content", "created_at"}).
			AddRow("AI", "answer", newer).
			AddRow("TEXT", "question", older))

	history, err := NewContextRepository(db).ListRelevantHistory(context.Background(), "family-1", 50)

	require.NoError(t, err)
	require.Equal(t, []domain.ContextMessage{
		{Role: domain.MessageRoleUser, Content: "question", CreatedAt: older},
		{Role: domain.MessageRoleModel, Content: "answer", CreatedAt: newer},
	}, history)
	require.NoError(t, mock.ExpectationsWereMet())
}
