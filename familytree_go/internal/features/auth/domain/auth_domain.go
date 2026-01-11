package domain

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type User struct {
	ID                  string // Firebase UID
	Email               string
	EmailVerified       bool
	DisplayName         string
	PhotoURL            string
	Role                SystemRole
	DeletionRequestedAt *time.Time
	CreatedAt           time.Time
	UpdatedAt           time.Time
}

type RequestStatus string

const (
	RequestStatusPending  RequestStatus = "PENDING"
	RequestStatusApproved RequestStatus = "APPROVED"
	RequestStatusRejected RequestStatus = "REJECTED"
)

type SystemRole string

const (
	SystemRoleUser         SystemRole = "USER"
	SystemRoleSuperAdmin   SystemRole = "SUPER_ADMIN"
	SystemRoleSupportAgent SystemRole = "SUPPORT_AGENT"
)

type SuperAdminRequest struct {
	ID            string
	UserID        string
	RequestedRole SystemRole
	Status        RequestStatus
	Reason        string
	ReviewedBy    string
	CreatedAt     time.Time
	UpdatedAt     time.Time
}

type TokenPurpose string

const (
	PurposeSuperAdminOnboarding TokenPurpose = "SUPER_ADMIN_ONBOARDING"
	PurposeFamilyInvite         TokenPurpose = "FAMILY_INVITE"
	PurposeSupportGrant         TokenPurpose = "SUPPORT_GRANT"
)

type SecureToken struct {
	Token        string
	Purpose      TokenPurpose
	AssociatedID *uuid.UUID
	CreatedBy    string
	ExpiresAt    *time.Time
	IsUsed       bool
	CreatedAt    time.Time
}

type UserRepository interface {
	UpsertUser(ctx context.Context, user *User) error
	GetUserByID(ctx context.Context, id string) (*User, error)
	MarkDeletionRequested(ctx context.Context, id string, requestedAt time.Time) error
	SetUserRole(ctx context.Context, id string, role SystemRole) error
}

type TokenRepository interface {
	Create(ctx context.Context, token *SecureToken) error
	Get(ctx context.Context, tokenStr string) (*SecureToken, error)
	MarkAsUsed(ctx context.Context, tokenStr string) error
	DeleteExpired(ctx context.Context) (int64, error)
}

type SuperAdminRequestRepository interface {
	Create(ctx context.Context, req *SuperAdminRequest) error
	GetByID(ctx context.Context, id string) (*SuperAdminRequest, error)
	List(ctx context.Context, status RequestStatus, limit int, offset int) ([]*SuperAdminRequest, error)
	GetLatestByUserID(ctx context.Context, userID string) (*SuperAdminRequest, error)
	UpdateStatus(ctx context.Context, id string, status RequestStatus, reviewedBy string) error
}
