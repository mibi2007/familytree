package grpc

import (
	"context"

	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/app"
	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/interfaces/guards"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	"github.com/mibi2007/familytree/familytree_go/pkg/pagination"
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
	guard      *guards.AuthGuard
}

func NewAuthHandler(appService *app.AuthService) *AuthHandler {
	return &AuthHandler{
		appService: appService,
		guard:      guards.NewAuthGuard(appService),
	}
}

func (s *AuthHandler) GetAuthStatus(ctx context.Context, _ *emptypb.Empty) (*authv1.AuthStatusResponse, error) {
	user := middleware.GetUser(ctx)
	if user == nil {
		return nil, status.Error(codes.Unauthenticated, "not authenticated")
	}

	// Lazily ensure user exists in our DB
	email, _ := user.Claims["email"].(string)
	emailVerified, _ := user.Claims["email_verified"].(bool)
	if _, err := s.appService.EnsureUserExists(ctx, user.UID, email, emailVerified); err != nil {
		return nil, err
	}

	isSuperAdmin, req, err := s.appService.GetAuthStatus(ctx, user.UID)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to get auth status: %v", err)
	}

	resp := &authv1.AuthStatusResponse{
		IsSuperAdmin:         isSuperAdmin,
		PendingRequestStatus: authv1.RequestStatus_REQUEST_STATUS_UNSPECIFIED,
	}

	if req != nil {
		// If they already have SUPER_ADMIN role, we don't necessarily need to rely on the request entry
		// but we still report the latest request status if it exists.
		if v, ok := authv1.RequestStatus_value[string(req.Status)]; ok {
			resp.PendingRequestStatus = authv1.RequestStatus(v)
		}
	}

	return resp, nil
}

func (s *AuthHandler) GenerateInviteToken(ctx context.Context, req *authv1.GenerateInviteTokenRequest) (*authv1.InviteToken, error) {
	// Extract creator ID from context and ensure guard
	createdBy, err := s.guard.RequireSuperAdmin(ctx)
	if err != nil {
		return nil, err
	}

	var purposeStr string
	switch req.Purpose {
	case authv1.TokenPurpose_TOKEN_PURPOSE_ADMIN_ONBOARDING:
		purposeStr = string(domain.PurposeSuperAdminOnboarding)
	case authv1.TokenPurpose_TOKEN_PURPOSE_FAMILY_INVITE:
		purposeStr = string(domain.PurposeFamilyInvite)
	case authv1.TokenPurpose_TOKEN_PURPOSE_SUPPORT_GRANT:
		purposeStr = string(domain.PurposeSupportGrant)
	default:
		// Fallback or handle unspecified
		if req.Purpose == authv1.TokenPurpose_TOKEN_PURPOSE_UNSPECIFIED {
			return nil, status.Error(codes.InvalidArgument, "token purpose unspecified")
		}
		purposeStr = req.Purpose.String()
	}

	token, err := s.appService.GenerateInviteToken(ctx, req.LifetimeSeconds, req.AssociatedId, purposeStr, createdBy)
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
	switch token.Purpose {
	case domain.PurposeSuperAdminOnboarding:
		purpose = authv1.TokenPurpose_TOKEN_PURPOSE_ADMIN_ONBOARDING
	case domain.PurposeFamilyInvite:
		purpose = authv1.TokenPurpose_TOKEN_PURPOSE_FAMILY_INVITE
	case domain.PurposeSupportGrant:
		purpose = authv1.TokenPurpose_TOKEN_PURPOSE_SUPPORT_GRANT
	default:
		purpose = authv1.TokenPurpose_TOKEN_PURPOSE_UNSPECIFIED
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

	// Ensure user exists before creating request
	email, _ := user.Claims["email"].(string)
	emailVerified, _ := user.Claims["email_verified"].(bool)
	if _, err := s.appService.EnsureUserExists(ctx, user.UID, email, emailVerified); err != nil {
		return nil, err
	}

	res, err := s.appService.RequestAdminAccess(ctx, user.UID, req.InvitationToken, req.RequestedRole, req.Reason)
	if err != nil {
		return nil, err
	}

	return toPbAdminReq(res), nil
}

func (s *AuthHandler) ListAdminRequests(ctx context.Context, req *authv1.ListAdminRequestsRequest) (*authv1.ListAdminRequestsResponse, error) {
	// Middleware handles auth (SuperAdmin role required)

	params := pagination.Parse(req.Pagination)

	statusFilter := domain.RequestStatus("")
	switch req.FilterStatus {
	case authv1.RequestStatus_REQUEST_STATUS_PENDING:
		statusFilter = domain.RequestStatusPending
	case authv1.RequestStatus_REQUEST_STATUS_APPROVED:
		statusFilter = domain.RequestStatusApproved
	case authv1.RequestStatus_REQUEST_STATUS_REJECTED:
		statusFilter = domain.RequestStatusRejected
	default:
		// If unspecified, we might leave it as empty (all) or handle otherwise
		if req.FilterStatus != authv1.RequestStatus_REQUEST_STATUS_UNSPECIFIED {
			statusFilter = domain.RequestStatus(req.FilterStatus.String())
		}
	}

	results, err := s.appService.ListAdminRequests(ctx, statusFilter, params.Limit, params.Offset)
	if err != nil {
		return nil, err
	}

	pbResults := make([]*authv1.AdminAccessRequest, len(results))
	for i, r := range results {
		pbResults[i] = toPbAdminReq(r)
	}

	return &authv1.ListAdminRequestsResponse{
		Requests:   pbResults,
		Pagination: pagination.BuildResponse(params.Offset, params.Limit, len(results)),
	}, nil
}

func (s *AuthHandler) ReviewAdminRequest(ctx context.Context, req *authv1.ReviewAdminRequestRequest) (*authv1.AdminAccessRequest, error) {
	adminID, err := s.guard.RequireSuperAdmin(ctx)
	if err != nil {
		return nil, err
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

	err = s.appService.ReviewAdminRequest(ctx, req.RequestId, decision, adminID)
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

	resp := &authv1.AdminAccessRequest{
		Id:            d.ID,
		UserId:        d.UserID,
		RequestedRole: string(d.RequestedRole),
		Status:        status,
		Reason:        d.Reason,
		ReviewedBy:    d.ReviewedBy,
		UpdatedAt:     timestamppb.New(d.UpdatedAt),
	}

	if d.User != nil {
		resp.UserProfile = &commonv1.UserProfile{
			Id:          d.User.ID,
			Email:       d.User.Email,
			DisplayName: d.User.DisplayName,
			PhotoUrl:    d.User.PhotoURL,
			// CreatedAt could be populated if we fetched it, usually less critical here
		}
	}

	return resp
}

func (s *AuthHandler) ListAdmins(ctx context.Context, req *authv1.ListAdminsRequest) (*authv1.ListAdminsResponse, error) {
	// Middleware handles auth

	params := pagination.Parse(req.Pagination)

	admins, err := s.appService.ListAdmins(ctx, params.Limit, params.Offset)
	if err != nil {
		return nil, err
	}

	pbAdmins := make([]*commonv1.UserProfile, len(admins))
	for i, a := range admins {
		pbAdmins[i] = &commonv1.UserProfile{
			Id:          a.ID,
			Email:       a.Email,
			DisplayName: a.DisplayName,
			PhotoUrl:    a.PhotoURL,
			CreatedAt:   timestamppb.New(a.CreatedAt),
		}
	}

	return &authv1.ListAdminsResponse{
		Admins:     pbAdmins,
		Pagination: pagination.BuildResponse(params.Offset, params.Limit, len(admins)),
	}, nil
}

func (s *AuthHandler) RevokeAdminRole(ctx context.Context, req *authv1.RevokeAdminRoleRequest) (*emptypb.Empty, error) {
	adminID, err := s.guard.RequireSuperAdmin(ctx)
	if err != nil {
		return nil, err
	}

	if err := s.appService.RevokeAdminRole(ctx, adminID, req.UserId); err != nil {
		return nil, err
	}

	return &emptypb.Empty{}, nil
}

func (s *AuthHandler) RequestAccountDeletion(ctx context.Context, req *authv1.RequestAccountDeletionRequest) (*emptypb.Empty, error) {
	user := middleware.GetUser(ctx)
	if user == nil {
		return nil, status.Error(codes.Unauthenticated, "authentication required")
	}

	// Optional: verify password if implementation supports/requires it

	if err := s.appService.RequestAccountDeletion(ctx, user.UID); err != nil {
		return nil, err
	}

	return &emptypb.Empty{}, nil
}
