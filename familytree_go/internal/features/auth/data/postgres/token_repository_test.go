package postgres_test

import (
	"context"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/data/postgres"
	"github.com/stretchr/testify/require"
)

func TestTokenRepositoryGetReturnsNilWhenMissing(t *testing.T) {
	db, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer db.Close()

	mock.ExpectQuery("SELECT token, purpose, associated_id, created_by, expires_at, is_used, created_at").
		WithArgs("missing-token").
		WillReturnRows(sqlmock.NewRows([]string{
			"token", "purpose", "associated_id", "created_by", "expires_at", "is_used", "created_at",
		}))

	token, err := postgres.NewTokenRepository(db).Get(context.Background(), "missing-token")

	require.NoError(t, err)
	require.Nil(t, token)
	require.NoError(t, mock.ExpectationsWereMet())
}
