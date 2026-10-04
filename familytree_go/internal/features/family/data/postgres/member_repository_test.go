package postgres_test

import (
	"context"
	"testing"
	"time"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/mibi2007/familytree/familytree_go/internal/features/family/data/postgres"
	"github.com/mibi2007/familytree/familytree_go/internal/features/family/domain"
	"github.com/stretchr/testify/require"
)

func TestMemberRepositoryCreateEmptyBirthDatePassesNull(t *testing.T) {
	db, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer db.Close()

	member := testMember()
	now := time.Now()
	mock.ExpectQuery("INSERT INTO family_members").
		WithArgs(
			member.ID,
			member.FamilyID,
			member.DisplayName,
			nil,
			member.Gender,
			member.Level,
			member.ParentID,
			member.SpouseID,
			member.UserID,
		).
		WillReturnRows(sqlmock.NewRows([]string{"created_at", "updated_at"}).AddRow(now, now))

	err = postgres.NewMemberRepository(db).Create(context.Background(), member)

	require.NoError(t, err)
	require.NoError(t, mock.ExpectationsWereMet())
}

func TestMemberRepositoryUpdateEmptyBirthDatePassesNull(t *testing.T) {
	db, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer db.Close()

	member := testMember()
	mock.ExpectExec("UPDATE family_members").
		WithArgs(
			member.FamilyID,
			member.DisplayName,
			nil,
			member.Gender,
			member.Level,
			member.ParentID,
			member.SpouseID,
			member.UserID,
			member.ID,
		).
		WillReturnResult(sqlmock.NewResult(0, 1))

	err = postgres.NewMemberRepository(db).Update(context.Background(), member)

	require.NoError(t, err)
	require.NoError(t, mock.ExpectationsWereMet())
}

func TestMemberRepositoryGetByIDPreservesDateFormat(t *testing.T) {
	db, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer db.Close()

	now := time.Now()
	mock.ExpectQuery("SELECT id, family_id, display_name, birth_date::text").
		WithArgs("member-1").
		WillReturnRows(sqlmock.NewRows([]string{
			"id", "family_id", "display_name", "birth_date", "gender", "level",
			"parent_id", "spouse_id", "user_id", "created_at", "updated_at",
		}).AddRow("member-1", "family-1", "Member", "2000-01-02", "unspecified", 1, nil, nil, nil, now, now))

	member, err := postgres.NewMemberRepository(db).GetByID(context.Background(), "member-1")

	require.NoError(t, err)
	require.Equal(t, "2000-01-02", member.BirthDate)
	require.NoError(t, mock.ExpectationsWereMet())
}

func testMember() *domain.Member {
	return &domain.Member{
		ID:          "member-1",
		FamilyID:    "family-1",
		DisplayName: "Member",
		Gender:      "unspecified",
		Level:       1,
		ParentID:    "parent-1",
		SpouseID:    "spouse-1",
		UserID:      "user-1",
	}
}
