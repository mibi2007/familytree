package grpc

import (
	"context"

	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/app"
	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	authv1 "github.com/mibi2007/familytree/familytree_go/proto/auth/v1"
	commonv1 "github.com/mibi2007/familytree/familytree_go/proto/common/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/emptypb"
	"google.golang.org/protobuf/types/known/timestamppb"
)

type AuthHandler struct {
	authv1.UnimplementedAuthServiceServer
	appService *app.AuthService
}

func NewAuthHandler(appService *app.AuthService) *AuthHandler {
	return &AuthHandler{
		appService: appService,
	}
}

func (s *AuthHandler) GetAuthStatus(ctx context.Context, _ *emptypb.Empty) (*authv1.AuthStatusResponse, error) {
	user := middleware.GetUser(ctx)
	if user == nil {
		return nil, status.Error(codes.Unauthenticated, "not authenticated")
	}

	req, err := s.appService.GetLatestAdminRequest(ctx, user.UID)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to get admin request: %v", err)
	}

	resp := &authv1.AuthStatusResponse{
		IsSuperAdmin:         false,
		PendingRequestStatus: authv1.RequestStatus_REQUEST_STATUS_UNSPECIFIED,
	}

	if req != nil {
		if req.Status == domain.RequestStatusApproved && req.RequestedRole == domain.SystemRoleSuperAdmin {
			resp.IsSuperAdmin = true
		}

		if v, ok := authv1.RequestStatus_value[string(req.Status)]; ok {
			resp.PendingRequestStatus = authv1.RequestStatus(v)
		}
	}

	return resp, nil
}

func (s *AuthHandler) GenerateInviteToken(ctx context.Context, req *authv1.GenerateInviteTokenRequest) (*authv1.InviteToken, error) {
	// Extract creator ID from context
	user := middleware.GetUser(ctx)
	createdBy := "system"
	if user != nil {
		createdBy = user.UID
	}

	token, err := s.appService.GenerateInviteToken(ctx, req.LifetimeSeconds, req.AssociatedId, req.Purpose.String(), createdBy)
	if err != nil {
		return nil, err
	}

	var pbExpiresAt *timestamppb.Timestamp
	if token.ExpiresAt != nil {
		pbExpiresAt = timestamppb.New(*token.ExpiresAt)
	}

	return &authv1.InviteToken{
		Token:        token.Token,
		Purpose:      req.Purpose,
		AssociatedId: req.AssociatedId,
		ExpiresAt:    pbExpiresAt,
		IsUsed:       token.IsUsed,
	}, nil
}

func (s *AuthHandler) ValidateInviteToken(ctx context.Context, req *authv1.ValidateInviteTokenRequest) (*authv1.ValidateInviteTokenResponse, error) {
	token, isValid, err := s.appService.ValidateInviteToken(ctx, req.Token)
	if err != nil {
		return nil, status.Errorf(codes.NotFound, "token not found: %v", err)
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
		IsValid:      isValid,
		Purpose:      purpose,
		AssociatedId: associatedID,
	}, nil
}

func (s *AuthHandler) SyncUserProfile(ctx context.Context, req *authv1.SyncUserProfileRequest) (*commonv1.UserProfile, error) {
	firebaseUser := middleware.GetUser(ctx)
	if firebaseUser == nil {
		return nil, status.Error(codes.Unauthenticated, "not authenticated")
	}

	email := ""
	if e, ok := firebaseUser.Claims["email"].(string); ok {
		email = e
	}

	emailVerified := false
	if v, ok := firebaseUser.Claims["email_verified"].(bool); ok {
		emailVerified = v
	}

	user, err := s.appService.SyncUserProfile(ctx, firebaseUser.UID, email, req.DisplayName, req.PhotoUrl, emailVerified)
	if err != nil {
		return nil, err
	}

	return &commonv1.UserProfile{
		Id:          user.ID,
		Email:       user.Email,
		DisplayName: user.DisplayName,
		PhotoUrl:    user.PhotoURL,
		CreatedAt:   timestamppb.New(user.CreatedAt),
	}, nil
}

func (s *AuthHandler) GetUserProfile(ctx context.Context, req *authv1.GetUserProfileRequest) (*commonv1.UserProfile, error) {
	user, err := s.appService.GetUserProfile(ctx, req.UserId)
	if err != nil {
		return nil, err
	}

	return &commonv1.UserProfile{
		Id:          user.ID,
		Email:       user.Email,
		DisplayName: user.DisplayName,
		PhotoUrl:    user.PhotoURL,
		CreatedAt:   timestamppb.New(user.CreatedAt),
	}, nil
}

func (s *AuthHandler) RequestAdminAccess(ctx context.Context, req *authv1.RequestAdminAccessRequest) (*authv1.AdminAccessRequest, error) {
	user := middleware.GetUser(ctx)
	if user == nil {
		return nil, status.Error(codes.Unauthenticated, "authentication required")
	}

	res, err := s.appService.RequestAdminAccess(ctx, user.UID, req.InvitationToken, req.RequestedRole, req.Reason)
	if err != nil {
		return nil, err
	}

	return toPbAdminReq(res), nil
}

func (s *AuthHandler) ListAdminRequests(ctx context.Context, req *authv1.ListAdminRequestsRequest) (*authv1.ListAdminRequestsResponse, error) {
	// TODO: Add Authorization check to ensure only admins can list
	user := middleware.GetUser(ctx)
	if user == nil {
		return nil, status.Error(codes.Unauthenticated, "authentication required")
	}

	statusFilter := domain.RequestStatus("")
	if req.FilterStatus != authv1.RequestStatus_REQUEST_STATUS_UNSPECIFIED {
		statusFilter = domain.RequestStatus(req.FilterStatus.String())
	}

	pageSize := int(req.Pagination.GetPageSize())
	if pageSize <= 0 {
		pageSize = 20
	}
	// TODO: Handle page token for offset
	offset := 0

	results, err := s.appService.ListAdminRequests(ctx, statusFilter, pageSize, offset)
	if err != nil {
		return nil, err
	}

	pbResults := make([]*authv1.AdminAccessRequest, len(results))
	for i, r := range results {
		pbResults[i] = toPbAdminReq(r)
	}

	return &authv1.ListAdminRequestsResponse{
		Requests:   pbResults,
		Pagination: &commonv1.PaginatedResponse{NextPageToken: ""}, // TODO implement pagination
	}, nil
}

func (s *AuthHandler) ReviewAdminRequest(ctx context.Context, req *authv1.ReviewAdminRequestRequest) (*authv1.AdminAccessRequest, error) {
	user := middleware.GetUser(ctx)
	if user == nil {
		return nil, status.Error(codes.Unauthenticated, "authentication required")
	}

	// Map proto enum to domain string
	var decision domain.RequestStatus
	switch req.Decision {
	case authv1.RequestStatus_REQUEST_STATUS_APPROVED:
		decision = domain.RequestStatusApproved
	case authv1.RequestStatus_REQUEST_STATUS_REJECTED:
		decision = domain.RequestStatusRejected
	default:
		return nil, status.Error(codes.InvalidArgument, "invalid decision status")
	}

	err := s.appService.ReviewAdminRequest(ctx, req.RequestId, decision, user.UID)
	if err != nil {
		return nil, err
	}

	// Fetch updated to return
	// In a real scenario we might return the updated object directly from service
	// For now returning a skeleton or refetching would be ideal
	return &authv1.AdminAccessRequest{
		Id:     req.RequestId,
		Status: req.Decision,
	}, nil
}

func toPbAdminReq(d *domain.SuperAdminRequest) *authv1.AdminAccessRequest {
	var status authv1.RequestStatus
	if v, ok := authv1.RequestStatus_value[string(d.Status)]; ok {
		status = authv1.RequestStatus(v)
	}

	return &authv1.AdminAccessRequest{
		Id:            d.ID,
		UserId:        d.UserID,
		RequestedRole: string(d.RequestedRole),
		Status:        status,
		Reason:        d.Reason,
		ReviewedBy:    d.ReviewedBy,
		UpdatedAt:     timestamppb.New(d.UpdatedAt),
		// UserProfile is not populated here, typically needs a join or separate fetch
	}
}
