package services

import (
	"context"
	"time"

	"github.com/google/uuid"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	"github.com/mibi2007/familytree/familytree_go/internal/repository"
	"github.com/mibi2007/familytree/familytree_go/pkg/utils"
	authv1 "github.com/mibi2007/familytree/familytree_go/proto/auth/v1"
	commonv1 "github.com/mibi2007/familytree/familytree_go/proto/common/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/timestamppb"
)

type AuthService struct {
	authv1.UnimplementedAuthServiceServer
	tokenRepo *repository.TokenRepository
	userRepo  *repository.UserRepository
}

func NewAuthService(tokenRepo *repository.TokenRepository, userRepo *repository.UserRepository) *AuthService {
	return &AuthService{
		tokenRepo: tokenRepo,
		userRepo:  userRepo,
	}
}

func (s *AuthService) GenerateInviteToken(ctx context.Context, req *authv1.GenerateInviteTokenRequest) (*authv1.InviteToken, error) {
	tokenStr, err := utils.GenerateSecureToken(32)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to generate token: %v", err)
	}

	var expiresAt *time.Time
	if req.LifetimeSeconds > 0 {
		exp := time.Now().Add(time.Duration(req.LifetimeSeconds) * time.Second)
		expiresAt = &exp
	}

	var associatedID *uuid.UUID
	if req.AssociatedId != "" {
		id, err := uuid.Parse(req.AssociatedId)
		if err != nil {
			return nil, status.Errorf(codes.InvalidArgument, "invalid associated_id: %v", err)
		}
		associatedID = &id
	}

	// Extract creator ID from context
	user := middleware.GetUser(ctx)
	createdBy := "system"
	if user != nil {
		createdBy = user.UID
	}

	token := &repository.SecureToken{
		Token:        tokenStr,
		Purpose:      repository.TokenPurpose(req.Purpose.String()),
		AssociatedID: associatedID,
		CreatedBy:    createdBy,
		ExpiresAt:    expiresAt,
		IsUsed:       false,
		CreatedAt:    time.Now(),
	}

	if err := s.tokenRepo.Create(ctx, token); err != nil {
		return nil, status.Errorf(codes.Internal, "failed to persist token: %v", err)
	}

	var pbExpiresAt *timestamppb.Timestamp
	if expiresAt != nil {
		pbExpiresAt = timestamppb.New(*expiresAt)
	}

	return &authv1.InviteToken{
		Token:        token.Token,
		Purpose:      req.Purpose,
		AssociatedId: req.AssociatedId,
		ExpiresAt:    pbExpiresAt,
		IsUsed:       token.IsUsed,
	}, nil
}

func (s *AuthService) ValidateInviteToken(ctx context.Context, req *authv1.ValidateInviteTokenRequest) (*authv1.ValidateInviteTokenResponse, error) {
	token, err := s.tokenRepo.Get(ctx, req.Token)
	if err != nil {
		return nil, status.Errorf(codes.NotFound, "token not found: %v", err)
	}

	if token.IsUsed {
		return &authv1.ValidateInviteTokenResponse{IsValid: false}, nil
	}

	if token.ExpiresAt != nil && token.ExpiresAt.Before(time.Now()) {
		return &authv1.ValidateInviteTokenResponse{IsValid: false}, nil
	}

	var purpose authv1.TokenPurpose
	if p, ok := authv1.TokenPurpose_value[string(token.Purpose)]; ok {
		purpose = authv1.TokenPurpose(p)
	}

	associatedID := ""
	if token.AssociatedID != nil {
		associatedID = token.AssociatedID.String()
	}

	return &authv1.ValidateInviteTokenResponse{
		IsValid:      true,
		Purpose:      purpose,
		AssociatedId: associatedID,
	}, nil
}

func (s *AuthService) SyncUserProfile(ctx context.Context, req *authv1.SyncUserProfileRequest) (*commonv1.UserProfile, error) {
	firebaseUser := middleware.GetUser(ctx)
	if firebaseUser == nil {
		return nil, status.Error(codes.Unauthenticated, "not authenticated")
	}

	// Extract email from claims if it's not in the token directly (usually it is)
	email := ""
	if e, ok := firebaseUser.Claims["email"].(string); ok {
		email = e
	}

	user := &repository.User{
		ID:          firebaseUser.UID,
		Email:       email,
		DisplayName: req.DisplayName,
		PhotoURL:    req.PhotoUrl,
	}

	if err := s.userRepo.UpsertUser(ctx, user); err != nil {
		return nil, status.Errorf(codes.Internal, "failed to sync user profile: %v", err)
	}

	return &commonv1.UserProfile{
		Id:          user.ID,
		Email:       user.Email,
		DisplayName: user.DisplayName,
		PhotoUrl:    user.PhotoURL,
	}, nil
}

func (s *AuthService) RequestAdminAccess(ctx context.Context, req *authv1.RequestAdminAccessRequest) (*authv1.AdminAccessRequest, error) {
	return nil, status.Errorf(codes.Unimplemented, "method RequestAdminAccess not implemented")
}

func (s *AuthService) ListAdminRequests(ctx context.Context, req *authv1.ListAdminRequestsRequest) (*authv1.ListAdminRequestsResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method ListAdminRequests not implemented")
}

func (s *AuthService) ReviewAdminRequest(ctx context.Context, req *authv1.ReviewAdminRequestRequest) (*authv1.AdminAccessRequest, error) {
	return nil, status.Errorf(codes.Unimplemented, "method ReviewAdminRequest not implemented")
}
