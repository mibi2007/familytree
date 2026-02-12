import 'package:shared_package/shared_package.dart';

import 'bootstrap.dart';
import 'core/config/firebase_options_dev.dart';
import 'mock/fake_services.dart';

void main() async {
  // Setup Mock Services directly
  final mockRepo = FakeAuthRepository();
  final mockAuthClient = FakeAuthClient();
  final mockFamilyClient = FakeFamilyClient();

  // Override Signals

  // 1. Inject Auth Repo
  authRepositorySignal.value = mockRepo;

  // 2. Inject Mock Clients
  mockAuthClientSignal.value = mockAuthClient;
  mockFamilyClientSignal.value = mockFamilyClient;

  // 3. Pre-login if desired (optional)
  // mockRepo.simulateLogin(MockUser(uid: 'mock-user-id', ...));

  await bootstrap(
    firebaseOptions: DefaultFirebaseOptionsDev.currentPlatform,
    environment: AppEnvironment.local,
    grpcHost: '127.0.0.1', // Won't be used by mocks
    grpcPort: 50051,
    useSecureGrpc: false,
    appTitle: 'Family Chat (MOCKED)',
    initFirebase: false, // Skip Firebase init
  );

  // Optional: Simulate login after delay or let user click login
}
