import 'dart:async';

import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart' as empty_proto;
import 'package:shared_package/data/grpc/generated/proto/auth/v1/auth.pbgrpc.dart' as auth_proto;
import 'package:shared_package/data/grpc/generated/proto/common/v1/common.pb.dart' as common_proto;
import 'package:shared_package/data/grpc/generated/proto/family/v1/family.pbgrpc.dart' as family_proto;
import 'package:shared_package/shared_package.dart';

// Helper for Fake Responses
class FakeResponseFuture<T> implements ResponseFuture<T> {
  final Future<T> _future;
  FakeResponseFuture.value(T value) : _future = Future.value(value);
  FakeResponseFuture.error(Object error) : _future = Future.error(error);

  @override
  Future<void> cancel() async {}

  @override
  Future<Map<String, String>> get headers => Future.value({});

  @override
  Future<Map<String, String>> get trailers => Future.value({});

  @override
  Stream<T> asStream() => _future.asStream();

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) =>
      _future.catchError(onError, test: test);

  @override
  Future<S> then<S>(FutureOr<S> Function(T value) onValue, {Function? onError}) =>
      _future.then(onValue, onError: onError);

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) => _future.whenComplete(action);

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) =>
      _future.timeout(timeLimit, onTimeout: onTimeout);
}

// ----------------------------------------------------------------------------
// Fake Auth Repository
// ----------------------------------------------------------------------------
class FakeAuthRepository implements FirebaseAuthRepository {
  final _userController = StreamController<User?>.broadcast();
  User? _currentUser;

  FakeAuthRepository() {
    _currentUser = null;
    _userController.add(null);
  }

  @override
  Stream<User?> get authStateChanges => _userController.stream;

  @override
  User? get currentUser => _currentUser;

  @override
  Future<Either<String, User>> signInWithEmail(String email, String password) async {
    // Fake success - but we return Unimplemented for now as per previous logic
    return throw UnimplementedError('signInWithEmail not implemented in mock');
  }

  @override
  Future<Either<String, User>> signUpWithEmail(String email, String password) async {
    return throw UnimplementedError('signUpWithEmail not implemented in mock');
  }

  @override
  Future<Either<String, User>> signInWithGoogle() async {
    return throw UnimplementedError('signInWithGoogle not implemented in mock');
  }

  @override
  Future<Either<String, User>> signInWithGoogleIdToken(String idToken) async {
    return throw UnimplementedError('signInWithGoogleIdToken not implemented in mock');
  }

  @override
  Future<Either<String, Unit>> signInWithPhone({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onVerificationFailed,
    Object? webRecaptchaVerifier,
  }) async {
    return throw UnimplementedError('signInWithPhone not implemented in mock');
  }

  @override
  Future<Either<String, User>> verifyPhoneCode(String verificationId, String smsCode) async {
    return throw UnimplementedError('verifyPhoneCode not implemented in mock');
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _userController.add(null);
  }

  @override
  Future<String?> getIdToken() async {
    return 'fake-jwt-token';
  }

  // Methods to simulate changes from outside
  void simulateLogin(User user) {
    _currentUser = user;
    _userController.add(user);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// ----------------------------------------------------------------------------
// Fake Auth Client
// ----------------------------------------------------------------------------
class FakeAuthClient extends auth_proto.AuthServiceClient {
  FakeAuthClient() : super(ClientChannel('localhost'));

  // registerUser is not in the interface anymore

  @override
  ResponseFuture<common_proto.UserProfile> syncUserProfile(
    auth_proto.SyncUserProfileRequest request, {
    CallOptions? options,
  }) {
    return FakeResponseFuture.value(
      common_proto.UserProfile(
        id: 'mock-user-id',
        email: 'mock@test.com',
        displayName: request.displayName,
        photoUrl: request.photoUrl,
      ),
    );
  }

  @override
  ResponseFuture<common_proto.UserProfile> getUserProfile(
    auth_proto.GetUserProfileRequest request, {
    CallOptions? options,
  }) {
    return FakeResponseFuture.value(
      common_proto.UserProfile(id: 'mock-user-id', email: 'mock@test.com', displayName: 'Mock User'),
    );
  }
}

// ----------------------------------------------------------------------------
// Fake Family Client
// ----------------------------------------------------------------------------
class FakeFamilyClient extends family_proto.FamilyServiceClient {
  FakeFamilyClient() : super(ClientChannel('localhost'));

  final _families = <family_proto.Family>[
    family_proto.Family(id: 'fam1', name: 'Simpson Family', ownerId: 'mock-user-id'),
  ];

  final _members = <family_proto.Member>[
    family_proto.Member(id: 'm1', familyId: 'fam1', displayName: 'Homer', level: 0),
    family_proto.Member(id: 'm2', familyId: 'fam1', displayName: 'Marge', level: 0, spouseId: 'm1'),
    family_proto.Member(id: 'm3', familyId: 'fam1', displayName: 'Bart', level: 1, parentId: 'm1'),
  ];

  @override
  ResponseFuture<family_proto.ListMyFamiliesResponse> listMyFamilies(
    empty_proto.Empty request, {
    CallOptions? options,
  }) {
    return FakeResponseFuture.value(family_proto.ListMyFamiliesResponse(families: _families));
  }

  @override
  ResponseFuture<family_proto.FamilyTree> getFamilyTree(
    family_proto.GetFamilyTreeRequest request, {
    CallOptions? options,
  }) {
    if (request.familyId == 'fam1') {
      return FakeResponseFuture.value(family_proto.FamilyTree(members: _members));
    }
    return FakeResponseFuture.value(family_proto.FamilyTree(members: []));
  }

  @override
  ResponseFuture<family_proto.Family> createFamily(family_proto.CreateFamilyRequest request, {CallOptions? options}) {
    final newFam = family_proto.Family(
      id: 'fam-${DateTime.now().millisecondsSinceEpoch}',
      name: request.name,
      ownerId: 'mock-user-id',
    );
    _families.add(newFam);
    return FakeResponseFuture.value(newFam);
  }

  @override
  ResponseFuture<family_proto.Member> addMember(family_proto.AddMemberRequest request, {CallOptions? options}) {
    final newMember = family_proto.Member(
      id: 'm-${DateTime.now().millisecondsSinceEpoch}',
      familyId: request.familyId,
      displayName: request.displayName,
      parentId: request.parentId,
      spouseId: request.spouseId,
      level: request.parentId.isNotEmpty ? 1 : 0, // Simplified level logic
    );
    _members.add(newMember);
    return FakeResponseFuture.value(newMember);
  }
}
