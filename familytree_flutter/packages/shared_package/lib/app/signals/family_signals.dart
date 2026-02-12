// Signal-based Family State Management
// Phase 5: Family Feature Migration
// Equivalent to: lib/app/providers/family_provider.dart

import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:signals/signals.dart';

import '../../data/grpc/generated/proto/family/v1/family.pbgrpc.dart' as family_proto;
import '../../data/signals/grpc_client_signals.dart';

/// My Families signal - fetches list of families for current user
final myFamiliesSignal = futureSignal<List<family_proto.Family>>(() async {
  try {
    final client = familyClientSignal.value;
    final response = await client.listMyFamilies(Empty());
    return response.families;
  } catch (e) {
    throw e;
  }
});

/// Family Members signal factory
///
/// Creates a future signal for fetching members of a specific family.
/// We use a cache to store created signals so we don't recreate them on every call.
final _familyMembersSignals = <String, FutureSignal<List<family_proto.Member>>>{};

FutureSignal<List<family_proto.Member>> familyMembersSignal(String familyId) {
  if (_familyMembersSignals.containsKey(familyId)) {
    return _familyMembersSignals[familyId]!;
  }

  final signal = futureSignal<List<family_proto.Member>>(() async {
    try {
      final client = familyClientSignal.value;
      final response = await client.getFamilyTree(family_proto.GetFamilyTreeRequest(familyId: familyId));
      return response.members;
    } catch (e) {
      throw e;
    }
  });

  _familyMembersSignals[familyId] = signal;
  return signal;
}

/// Helper to reload family members
void reloadFamilyMembers(String familyId) {
  if (_familyMembersSignals.containsKey(familyId)) {
    _familyMembersSignals[familyId]!.reload();
  }
}

/// Family Controller class using signals
class FamilySignalsController {
  // Loading state
  final _isLoading = signal<bool>(false);
  final _error = signal<String?>(null);

  bool get isLoading => _isLoading.value;
  String? get error => _error.value;
  Signal<bool> get isLoadingSignal => _isLoading;
  Signal<String?> get errorSignal => _error;

  /// Create a new family
  Future<family_proto.Family?> createFamily(String name) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final client = familyClientSignal.value;
      final family = await client.createFamily(family_proto.CreateFamilyRequest(name: name));

      // Refresh families list
      myFamiliesSignal.reload();

      return family;
    } catch (e) {
      _error.value = e.toString();
      return null;
    } finally {
      _isLoading.value = false;
    }
  }

  /// Add a member to the family
  Future<family_proto.Member?> addMember({
    required String familyId,
    required String displayName,
    String? parentId,
    String? spouseId,
  }) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final client = familyClientSignal.value;
      final member = await client.addMember(
        family_proto.AddMemberRequest(
          familyId: familyId,
          displayName: displayName,
          parentId: parentId ?? '',
          spouseId: spouseId ?? '',
        ),
      );

      // Refresh members list
      reloadFamilyMembers(familyId);

      return member;
    } catch (e) {
      _error.value = e.toString();
      return null;
    } finally {
      _isLoading.value = false;
    }
  }

  /// Join a family with token
  Future<family_proto.Family?> joinFamily(String inviteToken) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final client = familyClientSignal.value;
      final family = await client.joinFamily(family_proto.JoinFamilyRequest(inviteToken: inviteToken));

      // Refresh families list
      myFamiliesSignal.reload();

      return family;
    } catch (e) {
      _error.value = e.toString();
      return null;
    } finally {
      _isLoading.value = false;
    }
  }

  /// Create invite token
  Future<String?> createInviteToken(String familyId) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final client = familyClientSignal.value;
      final response = await client.createInviteToken(family_proto.CreateInviteTokenRequest(familyId: familyId));
      return response.inviteToken;
    } catch (e) {
      _error.value = e.toString();
      return null;
    } finally {
      _isLoading.value = false;
    }
  }
}

/// Global family controller instance
final familySignalsController = FamilySignalsController();
