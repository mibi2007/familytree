package grpc

import (
	"context"

	"github.com/mibi2007/familytree/familytree_go/internal/features/family/app"
	"github.com/mibi2007/familytree/familytree_go/internal/features/family/domain"
	familyv1 "github.com/mibi2007/familytree/familytree_go/proto/family/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/emptypb"
	"google.golang.org/protobuf/types/known/timestamppb"
)

type FamilyHandler struct {
	familyv1.UnimplementedFamilyServiceServer
	appService *app.FamilyService
}

func NewFamilyHandler(appService *app.FamilyService) *FamilyHandler {
	return &FamilyHandler{
		appService: appService,
	}
}

func (s *FamilyHandler) CreateFamily(ctx context.Context, req *familyv1.CreateFamilyRequest) (*familyv1.Family, error) {
	family, err := s.appService.CreateFamily(ctx, req.Name)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to create family: %v", err)
	}

	return mapFamilyToProto(family), nil
}

func (s *FamilyHandler) GetFamily(ctx context.Context, req *familyv1.GetFamilyRequest) (*familyv1.Family, error) {
	family, err := s.appService.GetFamily(ctx, req.Id)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to get family: %v", err)
	}
	if family == nil {
		return nil, status.Error(codes.NotFound, "family not found")
	}

	return mapFamilyToProto(family), nil
}

func (s *FamilyHandler) ListMyFamilies(ctx context.Context, _ *emptypb.Empty) (*familyv1.ListMyFamiliesResponse, error) {
	families, err := s.appService.ListMyFamilies(ctx)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to list families: %v", err)
	}

	protoFamilies := make([]*familyv1.Family, len(families))
	for i, f := range families {
		protoFamilies[i] = mapFamilyToProto(f)
	}

	return &familyv1.ListMyFamiliesResponse{
		Families: protoFamilies,
	}, nil
}

func (s *FamilyHandler) AddMember(ctx context.Context, req *familyv1.AddMemberRequest) (*familyv1.Member, error) {
	member, err := s.appService.AddMember(ctx, req.FamilyId, req.DisplayName, req.ParentId, req.SpouseId)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to add member: %v", err)
	}

	return mapMemberToProto(member), nil
}

func (s *FamilyHandler) UpdateMember(ctx context.Context, req *familyv1.UpdateMemberRequest) (*familyv1.Member, error) {
	m := &domain.Member{
		ID:          req.Member.Id,
		FamilyID:    req.Member.FamilyId,
		DisplayName: req.Member.DisplayName,
		BirthDate:   req.Member.BirthDate,
		Gender:      req.Member.Gender,
		Level:       int(req.Member.Level),
		ParentID:    req.Member.ParentId,
		SpouseID:    req.Member.SpouseId,
		UserID:      req.Member.UserId,
	}

	if err := s.appService.UpdateMember(ctx, m); err != nil {
		return nil, status.Errorf(codes.Internal, "failed to update member: %v", err)
	}

	return mapMemberToProto(m), nil
}

func (s *FamilyHandler) DeleteMember(ctx context.Context, req *familyv1.DeleteMemberRequest) (*emptypb.Empty, error) {
	if err := s.appService.DeleteMember(ctx, req.MemberId); err != nil {
		return nil, status.Errorf(codes.Internal, "failed to delete member: %v", err)
	}
	return &emptypb.Empty{}, nil
}

func (s *FamilyHandler) GetFamilyTree(ctx context.Context, req *familyv1.GetFamilyTreeRequest) (*familyv1.FamilyTree, error) {
	members, err := s.appService.ListMembers(ctx, req.FamilyId)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to list members: %v", err)
	}

	protoMembers := make([]*familyv1.Member, len(members))
	for i, m := range members {
		protoMembers[i] = mapMemberToProto(m)
	}

	return &familyv1.FamilyTree{
		FamilyId: req.FamilyId,
		Members:  protoMembers,
	}, nil
}

func (s *FamilyHandler) JoinFamily(ctx context.Context, req *familyv1.JoinFamilyRequest) (*familyv1.Family, error) {
	family, err := s.appService.JoinFamily(ctx, req.InviteToken)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to join family: %v", err)
	}

	return mapFamilyToProto(family), nil
}

func mapFamilyToProto(f *domain.Family) *familyv1.Family {
	return &familyv1.Family{
		Id:                     f.ID,
		Name:                   f.Name,
		OwnerId:                f.OwnerID,
		AiBehaviorInstructions: f.AIBehaviorInstructions,
		CreatedAt:              timestamppb.New(f.CreatedAt),
	}
}

func mapMemberToProto(m *domain.Member) *familyv1.Member {
	return &familyv1.Member{
		Id:          m.ID,
		FamilyId:    m.FamilyID,
		DisplayName: m.DisplayName,
		BirthDate:   m.BirthDate,
		Gender:      m.Gender,
		Level:       int32(m.Level),
		ParentId:    m.ParentID,
		SpouseId:    m.SpouseID,
		UserId:      m.UserID,
	}
}
