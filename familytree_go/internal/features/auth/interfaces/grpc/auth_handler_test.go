package grpc

import (
	"testing"

	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/domain"
	authv1 "github.com/mibi2007/familytree/familytree_go/proto/auth/v1"
	"github.com/stretchr/testify/require"
)

func TestToPbRequestStatus(t *testing.T) {
	tests := []struct {
		name string
		in   domain.RequestStatus
		want authv1.RequestStatus
	}{
		{name: "pending", in: domain.RequestStatusPending, want: authv1.RequestStatus_REQUEST_STATUS_PENDING},
		{name: "approved", in: domain.RequestStatusApproved, want: authv1.RequestStatus_REQUEST_STATUS_APPROVED},
		{name: "rejected", in: domain.RequestStatusRejected, want: authv1.RequestStatus_REQUEST_STATUS_REJECTED},
		{name: "unspecified", in: domain.RequestStatus(""), want: authv1.RequestStatus_REQUEST_STATUS_UNSPECIFIED},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			require.Equal(t, tt.want, toPbRequestStatus(tt.in))
		})
	}
}

func TestToPbAdminRequestMapsStatus(t *testing.T) {
	request := toPbAdminReq(&domain.SuperAdminRequest{Status: domain.RequestStatusRejected})
	require.Equal(t, authv1.RequestStatus_REQUEST_STATUS_REJECTED, request.Status)
}
