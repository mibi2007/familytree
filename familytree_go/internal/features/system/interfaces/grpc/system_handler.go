package grpc

import (
	"context"

	"github.com/mibi2007/familytree/familytree_go/internal/features/system/app"
	systemv1 "github.com/mibi2007/familytree/familytree_go/proto/system/v1"
)

type SystemHandler struct {
	systemv1.UnimplementedSystemServiceServer
	service *app.SystemService
}

func NewSystemHandler(service *app.SystemService) *SystemHandler {
	return &SystemHandler{
		service: service,
	}
}

func (h *SystemHandler) GetHealthStatus(ctx context.Context, req *systemv1.HealthCheckRequest) (*systemv1.HealthCheckResponse, error) {
	return h.service.GetHealthStatus(ctx)
}
