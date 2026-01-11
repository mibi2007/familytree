package middleware

import (
	"context"
	"log"
	"time"

	"github.com/google/uuid"
	"github.com/mibi2007/familytree/familytree_go/internal/features/system/domain"
	"google.golang.org/grpc"
)

func AuditInterceptor(repo domain.LogRepository) grpc.UnaryServerInterceptor {
	return func(
		ctx context.Context,
		req interface{},
		info *grpc.UnaryServerInfo,
		handler grpc.UnaryHandler,
	) (interface{}, error) {
		resp, err := handler(ctx, req)

		// Only log successful administrative actions
		if err == nil && isAuditAction(info.FullMethod) {
			user := GetUser(ctx)
			if user != nil {
				// Base audit log
				audit := &domain.AuditLog{
					AdminID:   user.UID,
					Action:    info.FullMethod,
					CreatedAt: time.Now(),
					Metadata:  map[string]interface{}{},
				}

				// Try to extract TargetID from request if possible via reflection or type switch
				// For now, use nil UUID and let implementation specify or use a generic approach
				audit.TargetID = uuid.Nil

				if err := repo.CreateAuditLog(ctx, audit); err != nil {
					log.Printf("Failed to create audit log: %v", err)
				}
			}
		}

		return resp, err
	}
}

func isAuditAction(fullMethod string) bool {
	actions := []string{
		"/auth.v1.AuthService/ReviewAdminRequest",
		"/auth.v1.AuthService/GenerateInviteToken",
		"/family.v1.FamilyService/UpdateFamilyOwner",
		"/family.v1.FamilyService/DeleteMember",
	}
	for _, a := range actions {
		if a == fullMethod {
			return true
		}
	}
	return false
}
