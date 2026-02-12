/// Data Layer Signals
///
/// Signal-based equivalents of Riverpod data providers.
/// These coexist with Riverpod during the migration (Phase 2+).
///
/// ## gRPC Clients
///
/// ```dart
/// // Initialize once at app start
/// initGrpcChannel();
///
/// // Use in your code
/// final authClient = authClientSignal.value;
/// final familyClient = familyClientSignal.value;
/// ```
///
/// ## Repository
///
/// ```dart
/// final authRepo = authRepositorySignal.value;
/// await authRepo.signInWithEmail(email, password);
/// ```
///
/// ## Disposal
///
/// ```dart
/// // Call on app dispose
/// await disposeGrpcSignals();
/// ```
library;

export 'auth_repository_signal.dart';
export 'grpc_client_signals.dart';
