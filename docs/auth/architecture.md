# Authentication - Architecture

## DDD Layers

### 1. Domain Layer
- **Entities**: `AuthUser` (id, email, displayName, photoUrl).
- **Failures**: `AuthFailure` (union for server error, email already in use, invalid credentials, etc.).
- **Interfaces**: `IAuthRepository` (Stream<AuthUser>, signIn, signOut, deleteAccount).

### 2. Infrastructure Layer
- **Data Source**: `FirebaseAuthRemoteDataSource` (supporting Google, Email, and Firebase PNV).
- **Repository Implementation**: `FirebaseAuthRepository` (implements `IAuthRepository`).
- **External Dependencies**: `firebase_auth`, `google_sign_in`.

### 2.1 Backend Integration (Go)
- **Role**: Validates Firebase JWT and manages `deletion_requested_at` in Postgres.
- **DTOs**: `AuthUser` mapped from Firebase `IdTokenResult`.

### 3. Application Layer
- **State Management**: `auth_state_provider` (Riverpod).
- **States**: `Initial`, `Authenticated`, `Unauthenticated`, `PendingDeletion`.
- **Use Cases**: `SignInUseCase`, `SignUpWithEmailUseCase`, `DeleteAccountUseCase`, `UpdateProfileUseCase`, `VerifyEmailUpdateUseCase`.

### 4. Presentation Layer
- **Widgets**: `LoginForm`, `GoogleSignInButton`, `DeletionWarningDialog`.
- **Pages**: `SignInPage`, `SplashPage`.
