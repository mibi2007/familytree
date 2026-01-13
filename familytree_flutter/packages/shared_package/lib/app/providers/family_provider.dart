import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_package/data/grpc/generated/proto/family/v1/family.pbgrpc.dart' as family_proto;
import 'package:shared_package/shared_package.dart';

part 'family_provider.g.dart';

@riverpod
Future<List<family_proto.Family>> myFamilies(Ref ref) async {
  final client = ref.read(familyClientProvider);
  final response = await client.listMyFamilies(Empty());
  return response.families;
}

@riverpod
Future<List<family_proto.Member>> familyMembers(Ref ref, String familyId) async {
  final client = ref.read(familyClientProvider);
  final response = await client.getFamilyTree(family_proto.GetFamilyTreeRequest(familyId: familyId));
  return response.members;
}

@riverpod
class FamilyController extends _$FamilyController {
  @override
  FutureOr<void> build() {}

  Future<family_proto.Family> createFamily(String name) async {
    state = const AsyncLoading();
    try {
      final client = ref.read(familyClientProvider);
      final family = await client.createFamily(family_proto.CreateFamilyRequest(name: name));

      // Refresh families list
      ref.invalidate(myFamiliesProvider);

      state = const AsyncData(null);
      return family;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<family_proto.Member> addMember({
    required String familyId,
    required String displayName,
    String? parentId,
    String? spouseId,
  }) async {
    state = const AsyncLoading();
    try {
      final client = ref.read(familyClientProvider);
      final member = await client.addMember(
        family_proto.AddMemberRequest(
          familyId: familyId,
          displayName: displayName,
          parentId: parentId ?? '',
          spouseId: spouseId ?? '',
        ),
      );

      // Invalidate the members list for this family
      ref.invalidate(familyMembersProvider(familyId));

      state = const AsyncData(null);
      return member;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<family_proto.Family> joinFamily(String inviteToken) async {
    state = const AsyncLoading();
    try {
      final client = ref.read(familyClientProvider);
      final family = await client.joinFamily(family_proto.JoinFamilyRequest(inviteToken: inviteToken));

      // Refresh families list
      ref.invalidate(myFamiliesProvider);

      state = const AsyncData(null);
      return family;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
