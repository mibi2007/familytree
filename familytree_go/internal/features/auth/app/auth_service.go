package app

import (
	"context"
	"time"

	"github.com/google/uuid"
	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/domain"
	"github.com/mibi2007/familytree/familytree_go/pkg/utils"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type AuthService struct {
	tokenRepo domain.TokenRepository
	userRepo  domain.UserRepository
	adminRepo domain.SuperAdminRequestRepository
}

// NewAuthService creates an application service that orchestrates auth operations
func NewAuthService(tokenRepo domain.TokenRepository, userRepo domain.UserRepository, adminRepo domain.SuperAdminRequestRepository) *AuthService {
	return &AuthService{
		tokenRepo: tokenRepo,
		userRepo:  userRepo,
		adminRepo: adminRepo,
	}
}

// GenerateInviteToken creates a new token
func (s *AuthService) GenerateInviteToken(ctx context.Context, reqLifetimeSeconds int64, reqAssociatedID string, reqPurpose string, createdBy string) (*domain.SecureToken, error) {
	tokenStr, err := utils.GenerateSecureToken(32)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to generate token: %v", err)
	}

	var expiresAt *time.Time
	if reqLifetimeSeconds > 0 {
		exp := time.Now().Add(time.Duration(reqLifetimeSeconds) * time.Second)
		expiresAt = &exp
	}

	var associatedID *uuid.UUID
	if reqAssociatedID != "" {
		id, err := uuid.Parse(reqAssociatedID)
		if err != nil {
			return nil, status.Errorf(codes.InvalidArgument, "invalid associated_id: %v", err)
		}
		associatedID = &id
	}

	token := &domain.SecureToken{
		Token:        tokenStr,
		Purpose:      domain.TokenPurpose(reqPurpose),
		AssociatedID: associatedID,
		CreatedBy:    createdBy,
		ExpiresAt:    expiresAt,
		IsUsed:       false,
		CreatedAt:    time.Now(),
	}

	if err := s.tokenRepo.Create(ctx, token); err != nil {
		return nil, status.Errorf(codes.Internal, "failed to persist token: %v", err)
	}

	return token, nil
}

// ValidateInviteToken checks if a token is valid
func (s *AuthService) ValidateInviteToken(ctx context.Context, tokenStr string) (*domain.SecureToken, bool, error) {
	token, err := s.tokenRepo.Get(ctx, tokenStr)
	if err != nil {
		// return specific errors if needed
		return nil, false, err
	}

	if token.IsUsed {
		return token, false, nil
	}

	if token.ExpiresAt != nil && token.ExpiresAt.Before(time.Now()) {
		return token, false, nil
	}

	return token, true, nil
}

// RegisterUser handles the first-time synchronization (Sign Up)
func (s *AuthService) RegisterUser(ctx context.Context, uid string, email string, displayName string, photoURL string, emailVerified bool) (*domain.User, error) {
	// For now, registration logic mimics sync, but could enforce invite checks here
	// e.g. check if email was invited

	user := &domain.User{
		ID:            uid,
		Email:         email,
		DisplayName:   displayName,
		PhotoURL:      photoURL,
		EmailVerified: emailVerified,
	}

	if err := s.userRepo.UpsertUser(ctx, user); err != nil {
		return nil, status.Errorf(codes.Internal, "failed to register user: %v", err)
	}
	return user, nil
}

// UpdateUserProfile handles subsequent updates (Sign In / Profile Update)
func (s *AuthService) UpdateUserProfile(ctx context.Context, uid string, email string, displayName string, photoURL string, emailVerified bool) (*domain.User, error) {
	user := &domain.User{
		ID:            uid,
		Email:         email,
		DisplayName:   displayName,
		PhotoURL:      photoURL,
		EmailVerified: emailVerified,
	}
	// TODO: Maybe only update specific fields or check for changes

	if err := s.userRepo.UpsertUser(ctx, user); err != nil {
		return nil, status.Errorf(codes.Internal, "failed to update user profile: %v", err)
	}
	return user, nil
}

// RequestAccountDeletion handles the user request to delete their account
func (s *AuthService) RequestAccountDeletion(ctx context.Context, uid string) error {
	requestedAt := time.Now()
	if err := s.userRepo.MarkDeletionRequested(ctx, uid, requestedAt); err != nil {
		return status.Errorf(codes.Internal, "failed to mark deletion: %v", err)
	}
	return nil
}

// SyncUserProfile is the legacy entry point, now delegating logic
func (s *AuthService) SyncUserProfile(ctx context.Context, uid string, email string, displayName string, photoURL string, emailVerified bool) (*domain.User, error) {
	// Check if user exists to decide between Register and Update
	existing, err := s.userRepo.GetUserByID(ctx, uid)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to check user existence: %v", err)
	}

	if existing == nil {
		return s.RegisterUser(ctx, uid, email, displayName, photoURL, emailVerified)
	}

	return s.UpdateUserProfile(ctx, uid, email, displayName, photoURL, emailVerified)
}

func (s *AuthService) GetUserProfile(ctx context.Context, uid string) (*domain.User, error) {
	user, err := s.userRepo.GetUserByID(ctx, uid)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to get user: %v", err)
	}
	if user == nil {
		return nil, status.Error(codes.NotFound, "user not found")
	}
	return user, nil
}

// RequestAdminAccess handles users requesting admin privileges
func (s *AuthService) RequestAdminAccess(ctx context.Context, userID, tokenStr, requestedRole, reason string) (*domain.SuperAdminRequest, error) {
	// 1. Validate the invite token
	token, valid, err := s.ValidateInviteToken(ctx, tokenStr)
	if err != nil {
		return nil, err
	}
	if !valid {
		return nil, status.Error(codes.InvalidArgument, "invalid or expired token")
	}
	if token.Purpose != domain.PurposeSuperAdminOnboarding {
		return nil, status.Error(codes.InvalidArgument, "token is not for system admin onboarding")
	}

	// 2. Mark token as used
	if err := s.tokenRepo.MarkAsUsed(ctx, tokenStr); err != nil {
		return nil, status.Errorf(codes.Internal, "failed to mark token as used: %v", err)
	}

	// 3. Create the request
	// Validate system role
	var sysRole domain.SystemRole
	switch requestedRole {
	case string(domain.SystemRoleSuperAdmin):
		sysRole = domain.SystemRoleSuperAdmin
	case string(domain.SystemRoleSupportAgent):
		sysRole = domain.SystemRoleSupportAgent
	default:
		return nil, status.Error(codes.InvalidArgument, "invalid system role requested")
	}

	req := &domain.SuperAdminRequest{
		ID:            uuid.New().String(),
		UserID:        userID,
		RequestedRole: sysRole,
		Status:        domain.RequestStatusPending,
		Reason:        reason,
		CreatedAt:     time.Now(),
		UpdatedAt:     time.Now(),
	}

	if err := s.adminRepo.Create(ctx, req); err != nil {
		return nil, status.Errorf(codes.Internal, "failed to create admin request: %v", err)
	}

	return req, nil
}

// ListAdminRequests allows admins to view pending requests
func (s *AuthService) ListAdminRequests(ctx context.Context, statusFilter domain.RequestStatus, limit, offset int) ([]*domain.SuperAdminRequest, error) {
	return s.adminRepo.List(ctx, statusFilter, limit, offset)
}

// GetLatestAdminRequest retrieves the latest admin access request for a user
func (s *AuthService) GetLatestAdminRequest(ctx context.Context, userID string) (*domain.SuperAdminRequest, error) {
	return s.adminRepo.GetLatestByUserID(ctx, userID)
}

// ReviewAdminRequest processing (Approve/Reject)
func (s *AuthService) ReviewAdminRequest(ctx context.Context, requestID string, decision domain.RequestStatus, reviewerID string) error {
	// 1. Fetch the request to know user and role
	req, err := s.adminRepo.GetByID(ctx, requestID)
	if err != nil {
		return status.Errorf(codes.Internal, "failed to fetch request: %v", err)
	}
	if req == nil {
		return status.Error(codes.NotFound, "request not found")
	}

	// 2. Update status
	if err := s.adminRepo.UpdateStatus(ctx, requestID, decision, reviewerID); err != nil {
		return status.Errorf(codes.Internal, "failed to update status: %v", err)
	}

	// 3. If approved, update user's role
	if decision == domain.RequestStatusApproved {
		if err := s.userRepo.SetUserRole(ctx, req.UserID, req.RequestedRole); err != nil {
			return status.Errorf(codes.Internal, "failed to promote user: %v", err)
		}
	}

	return nil
}
