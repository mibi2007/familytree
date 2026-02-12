package middleware

import (
	"context"
	"strings"

	"firebase.google.com/go/v4/auth"
	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/domain"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/status"
)

type contextKey string

const (
	UserContextKey contextKey = "user"
)

// RoutePolicy defines the authorization requirement for a route
type RoutePolicy int

const (
	PolicyPublic RoutePolicy = iota
	PolicyAuthenticated
	PolicySuperAdmin
)

// Service defines the interface needed by the middleware to check roles
type Service interface {
	GetRole(ctx context.Context, userID string) (domain.SystemRole, error)
}

type AuthInterceptor struct {
	authClient *auth.Client
	service    Service
}

func NewAuthInterceptor(authClient *auth.Client, service Service) *AuthInterceptor {
	return &AuthInterceptor{
		authClient: authClient,
		service:    service,
	}
}

func (i *AuthInterceptor) Unary() grpc.UnaryServerInterceptor {
	return func(
		ctx context.Context,
		req interface{},
		info *grpc.UnaryServerInfo,
		handler grpc.UnaryHandler,
	) (interface{}, error) {
		// 1. Check Route Policy
		policy := i.getRoutePolicy(info.FullMethod)

		// 2. Public Access
		if policy == PolicyPublic {
			return handler(ctx, req)
		}

		// 3. Authenticate (Common for Authenticated & SuperAdmin)
		newCtx, userID, err := i.authenticate(ctx)
		if err != nil {
			return nil, err
		}

		// 4. Authorize if SuperAdmin required
		if policy == PolicySuperAdmin {
			role, err := i.service.GetRole(newCtx, userID)
			if err != nil {
				// If we can't get the role, fail safe
				return nil, status.Errorf(codes.Internal, "failed to verify role: %v", err)
			}
			if role != domain.SystemRoleSuperAdmin {
				return nil, status.Error(codes.PermissionDenied, "access denied: super admin role required")
			}
		}

		return handler(newCtx, req)
	}
}

func (i *AuthInterceptor) Stream() grpc.StreamServerInterceptor {
	return func(
		srv interface{},
		ss grpc.ServerStream,
		info *grpc.StreamServerInfo,
		handler grpc.StreamHandler,
	) error {
		policy := i.getRoutePolicy(info.FullMethod)

		if policy == PolicyPublic {
			return handler(srv, ss)
		}

		newCtx, userID, err := i.authenticate(ss.Context())
		if err != nil {
			return err
		}

		if policy == PolicySuperAdmin {
			role, err := i.service.GetRole(newCtx, userID)
			if err != nil {
				return status.Errorf(codes.Internal, "failed to verify role: %v", err)
			}
			if role != domain.SystemRoleSuperAdmin {
				return status.Error(codes.PermissionDenied, "access denied: super admin role required")
			}
		}

		wrapped := &wrappedStream{ss, newCtx}
		return handler(srv, wrapped)
	}
}

type wrappedStream struct {
	grpc.ServerStream
	ctx context.Context
}

func (w *wrappedStream) Context() context.Context {
	return w.ctx
}

func (i *AuthInterceptor) authenticate(ctx context.Context) (context.Context, string, error) {
	md, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		return nil, "", status.Error(codes.Unauthenticated, "metadata is not provided")
	}

	values := md.Get("authorization")
	if len(values) == 0 {
		return nil, "", status.Error(codes.Unauthenticated, "authorization token is not provided")
	}

	tokenStr := strings.TrimPrefix(values[0], "Bearer ")
	token, err := i.authClient.VerifyIDToken(ctx, tokenStr)
	if err != nil {
		return nil, "", status.Errorf(codes.Unauthenticated, "invalid token: %v", err)
	}

	return context.WithValue(ctx, UserContextKey, token), token.UID, nil
}

func (i *AuthInterceptor) getRoutePolicy(fullMethod string) RoutePolicy {
	// Reflection and Health checks are public
	if strings.HasPrefix(fullMethod, "/grpc.reflection.v1") ||
		strings.HasPrefix(fullMethod, "/grpc.health.v1.Health") {
		return PolicyPublic
	}

	// Exact matches for Public endpoints
	publicMethods := map[string]bool{
		"/auth.v1.AuthService/ValidateInviteToken": true,
		"/system.v1.SystemService/GetHealthStatus": true,
	}
	if publicMethods[fullMethod] {
		return PolicyPublic
	}

	// Exact matches for SuperAdmin endpoints
	superAdminMethods := map[string]bool{
		"/auth.v1.AuthService/ListAdmins":             true,
		"/auth.v1.AuthService/RevokeAdminRole":        true,
		"/auth.v1.AuthService/GenerateInviteToken":    true,
		"/auth.v1.AuthService/ListAdminRequests":      true,
		"/auth.v1.AuthService/ReviewAdminRequest":     true,
		"/auth.v1.AuthService/RequestAccountDeletion": true,
	}
	if superAdminMethods[fullMethod] {
		return PolicySuperAdmin
	}

	// Default to Authenticated for everything else
	return PolicyAuthenticated
}

func GetUser(ctx context.Context) *auth.Token {
	if user, ok := ctx.Value(UserContextKey).(*auth.Token); ok {
		return user
	}
	return nil
}
