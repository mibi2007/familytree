package services

import (
	"context"

	familyv1 "github.com/mibi2007/familytree/familytree_go/proto/family/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/emptypb"
)

type FamilyService struct {
	familyv1.UnimplementedFamilyServiceServer
}

func NewFamilyService() *FamilyService {
	return &FamilyService{}
}

func (s *FamilyService) CreateFamily(ctx context.Context, req *familyv1.CreateFamilyRequest) (*familyv1.Family, error) {
	return nil, status.Errorf(codes.Unimplemented, "method CreateFamily not implemented")
}

func (s *FamilyService) GetFamily(ctx context.Context, req *familyv1.GetFamilyRequest) (*familyv1.Family, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetFamily not implemented")
}

func (s *FamilyService) UpdateFamilyOwner(ctx context.Context, req *familyv1.UpdateFamilyOwnerRequest) (*familyv1.Family, error) {
	return nil, status.Errorf(codes.Unimplemented, "method UpdateFamilyOwner not implemented")
}

func (s *FamilyService) LeaveFamily(ctx context.Context, req *familyv1.LeaveFamilyRequest) (*emptypb.Empty, error) {
	return nil, status.Errorf(codes.Unimplemented, "method LeaveFamily not implemented")
}

func (s *FamilyService) AddMember(ctx context.Context, req *familyv1.AddMemberRequest) (*familyv1.Member, error) {
	return nil, status.Errorf(codes.Unimplemented, "method AddMember not implemented")
}

func (s *FamilyService) UpdateMember(ctx context.Context, req *familyv1.UpdateMemberRequest) (*familyv1.Member, error) {
	return nil, status.Errorf(codes.Unimplemented, "method UpdateMember not implemented")
}

func (s *FamilyService) DeleteMember(ctx context.Context, req *familyv1.DeleteMemberRequest) (*emptypb.Empty, error) {
	return nil, status.Errorf(codes.Unimplemented, "method DeleteMember not implemented")
}

func (s *FamilyService) GetFamilyTree(ctx context.Context, req *familyv1.GetFamilyTreeRequest) (*familyv1.FamilyTree, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetFamilyTree not implemented")
}
