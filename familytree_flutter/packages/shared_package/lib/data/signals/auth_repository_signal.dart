// Signal-based Firebase Auth Repository
// Phase 2: Data Layer Migration
// Equivalent to: authRepositoryProvider

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signals/signals.dart';

import '../repositories/firebase_auth_repository.dart';

/// Firebase Auth Repository signal
///
/// Provides a singleton instance of FirebaseAuthRepository.
/// Equivalent to: `authRepositoryProvider`
final authRepositorySignal = signal<FirebaseAuthRepository?>(null);

/// Initialize the Auth Repository signal
void initAuthRepository() {
  authRepositorySignal.value = FirebaseAuthRepository(FirebaseAuth.instance, GoogleSignIn.instance);
}
