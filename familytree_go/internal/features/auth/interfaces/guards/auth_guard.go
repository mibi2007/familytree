package guards

import (
	"context"

	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/app"
	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

// AuthGuard guards endpoints with Role-Based Access Control logic
type AuthGuard struct {
	authService *app.AuthService
}

// NewAuthGuard creates a new AuthGuard instance
func NewAuthGuard(authService *app.AuthService) *AuthGuard {
	return &AuthGuard{
		authService: authService,
	}
}

// RequireSuperAdmin ensures the user is authenticated AND has the SUPER_ADMIN role.
// It returns the userID if authorized, or a gRPC error (Unauthenticated or PermissionDenied).
func (g *AuthGuard) RequireSuperAdmin(ctx context.Context) (string, error) {
	// 1. Authenticated Check
	user := middleware.GetUser(ctx)
	if user == nil {
		return "", status.Error(codes.Unauthenticated, "authentication required")
	}

	// 2. Role Check
	role, err := g.authService.GetRole(ctx, user.UID)
	if err != nil {
		return "", err // Could be internal error or user not found
	}

	if role != domain.SystemRoleSuperAdmin {
		return "", status.Error(codes.PermissionDenied, "access denied: super admin role required")
	}

	return user.UID, nil
}
