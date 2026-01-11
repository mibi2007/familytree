package postgres_test

import (
	"context"
	"errors"
	"testing"
	"time"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/infrastructure/postgres"
	"github.com/stretchr/testify/assert"
)

func TestUpsertUser(t *testing.T) {
	db, mock, err := sqlmock.New()
	assert.NoError(t, err)
	defer db.Close()

	repo := postgres.NewUserRepository(db)
	ctx := context.Background()

	t.Run("Success", func(t *testing.T) {
		user := &domain.User{
			ID:            "user-1",
			Email:         "test@example.com",
			EmailVerified: true,
			DisplayName:   "Test User",
			PhotoURL:      "http://example.com/photo.jpg",
			Role:          domain.SystemRoleUser,
		}

		rows := sqlmock.NewRows([]string{"created_at", "role"}).AddRow(time.Now(), string(domain.SystemRoleUser))

		mock.ExpectQuery("INSERT INTO users").
			WithArgs(user.ID, user.Email, user.DisplayName, user.PhotoURL, user.EmailVerified, user.Role).
			WillReturnRows(rows)

		err := repo.UpsertUser(ctx, user)
		assert.NoError(t, err)
		assert.Equal(t, domain.SystemRoleUser, user.Role)
	})

	t.Run("Failure", func(t *testing.T) {
		user := &domain.User{
			ID: "user-2",
		}
		mock.ExpectQuery("INSERT INTO users").
			WillReturnError(errors.New("db error"))

		err := repo.UpsertUser(ctx, user)
		assert.Error(t, err)
	})
}

func TestGetUserByID(t *testing.T) {
	db, mock, err := sqlmock.New()
	assert.NoError(t, err)
	defer db.Close()

	repo := postgres.NewUserRepository(db)
	ctx := context.Background()

	t.Run("Found", func(t *testing.T) {
		uid := "user-1"
		rows := sqlmock.NewRows([]string{"id", "email", "display_name", "photo_url", "email_verified", "role", "deletion_requested_at", "created_at", "updated_at"}).
			AddRow(uid, "test@example.com", "Name", "url", true, string(domain.SystemRoleSuperAdmin), nil, time.Now(), time.Now())

		mock.ExpectQuery("SELECT .* FROM users WHERE id =").
			WithArgs(uid).
			WillReturnRows(rows)

		user, err := repo.GetUserByID(ctx, uid)
		assert.NoError(t, err)
		assert.NotNil(t, user)
		assert.Equal(t, uid, user.ID)
		assert.Equal(t, domain.SystemRoleSuperAdmin, user.Role)
	})
}

func TestSetUserRole(t *testing.T) {
	db, mock, err := sqlmock.New()
	assert.NoError(t, err)
	defer db.Close()

	repo := postgres.NewUserRepository(db)
	ctx := context.Background()

	t.Run("Success", func(t *testing.T) {
		uid := "user-1"
		role := domain.SystemRoleSuperAdmin

		mock.ExpectExec("UPDATE users SET role =").
			WithArgs(role, uid).
			WillReturnResult(sqlmock.NewResult(0, 1))

		err := repo.SetUserRole(ctx, uid, role)
		assert.NoError(t, err)
	})
}
