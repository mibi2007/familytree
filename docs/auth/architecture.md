# Authentication - Architecture

## DDD Layers

### 1. Domain Layer (`shared_package`)
- **Entities**: `AuthUser` (id, email, displayName, photoUrl).
- **Failures**: `AuthFailure` (union for server error, email already in use, invalid credentials, etc.).
- **Interfaces**: `IAuthRepository` (Stream<AuthUser>, signIn, signOut, deleteAccount).

### 2. Data Layer (`shared_package`)
- **Data Source**: `FirebaseAuthRemoteDataSource` (supporting Google, Email, and Firebase PNV).
- **Repository Implementation**: `FirebaseAuthRepository` (implements `IAuthRepository`).
- **External Dependencies**: `firebase_auth`, `google_sign_in`.

### 3. App Layer (`shared_package`)

## Backend Integration (Go)
- **Role**: Validates Firebase JWT and manages `deletion_requested_at` in Postgres.
- **DTOs**: `AuthUser` mapped from Firebase `IdTokenResult`.
- **State Management**: `auth_state_provider` (Riverpod).
- **States**: `Initial`, `Authenticated`, `Unauthenticated`, `PendingDeletion`.
- **Use Cases**: `SignInUseCase`, `SignUpWithEmailUseCase`, `DeleteAccountUseCase`, `UpdateProfileUseCase`, `VerifyEmailUpdateUseCase`.

### 4. View Layer (App-Specific)
- **`user_app`**: Implements `SignInPage` with Google, Email, and Phone options.
- **`admin_app`**: Implements `AdminSignInPage` with Google only.
- **Shared Widgets (`shared_package`)**: `GoogleSignInButton`, `DeletionWarningDialog`.
