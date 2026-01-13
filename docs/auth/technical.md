# Authentication - Technical Solution

## User Journey Flow
```mermaid
sequenceDiagram
    participant User
    participant App
    participant Firebase
    participant Postgres

    Note over User, Postgres: Sign Up via Invitation (Admin/Family)
    User->>App: Clicks Invitation Link (includes ?token=XYZ)
    App->>Postgres: Validate Token (is active, not expired)
    Postgres-->>App: Valid/Invalid status
    
    Note over User, Postgres: Sign Up / Login / Linking Flow
    User->>App: Choose Auth Method (Google/Email)
    App->>Firebase: Authenticate User
    App->>Postgres: Check/Sync User & Consume Token (is_used=true)
    
    alt Account Conflict (auth/account-exists-with-different-credential)
        Firebase-->>App: Error: Account exists with different provider
        App->>Firebase: fetchSignInMethodsForEmail(email)
        Firebase-->>App: Return original provider (e.g., Password)
        App->>User: Prompt: "Sign in with [Original Provider] to link Google"
        User->>App: Provides Password/Original Auth
        App->>Firebase: signInWithEmailAndPassword
        App->>Firebase: linkWithCredential(googleCredential)
        Firebase-->>App: Success (Accounts Linked)
    else Success (New or Same Provider)
        Firebase-->>App: Return UserCredential & UID
    end

    App->>Postgres: Check/Sync User (id=UID, email, phone)
    alt New User
        App->>Firebase: sendEmailVerification (if Email)
        App->>User: Show Onboarding
    else Existing User
        App->>User: Navigate to Home
    end

    Note over User, Postgres: Profile Update (Email/Phone)
    User->>App: Request Email Change
    App->>Firebase: verifyBeforeUpdateEmail(newEmail)
    Firebase-->>User: Send Verification link
    User->>Firebase: Click Link
    Firebase-->>App: Verification Successful
    App->>Postgres: Sync new email to `users` table
```

## Database Schema (PostgreSQL)
```mermaid
erDiagram
    users {
        string id PK "Firebase UID"
        string email
        string phone
        string display_name
        string photo_url
        timestamp deletion_requested_at
    }
```

- **Registration**: Use `createUserWithEmailAndPassword` and `sendEmailVerification`.

## App-Specific View
- **Shared Logic Layer (`shared_package`)**:
  - `AuthRepository`: Handles the underlying Firebase/Postgres communication.
  - `AuthProvider`: Manages the global `AuthState` using Riverpod.
- **`user_app` Sign-In**:
  - **Aesthetics**: Warm, family-centric design.
  - **Features**: Social Login (Google), Legacy Login (Email), and Mobile Quick Login (Phone).
- **`admin_app` Sign-In**:
  - **Aesthetics**: Professional, high-security dashboard theme.
  - **Restriction**: Only displays the Google Sign-In interface. 
  - **Validation**: Enforces that the authenticated user possesses (or has requested) an admin role.

## Account Linking & Conflict Resolution
- **Strategy**: Unified Email Identity.
- **Provider Conflicts**:
  1. **Google first, then Email**: Firebase prevents direct creation of a password for a Google-only email without verification.
  2. **Email first, then Google**: 
     - Catch `auth/account-exists-with-different-credential`.
     - Fetch existing sign-in methods using `fetchSignInMethodsForEmail`.
     - Prompt user to sign in with original provider, then use `linkWithCredential` to merge the Google identity.
- **Automatic Merging**: In Firebase Console, "One account per email address" should be enabled. Google is treated as a "trusted" provider to allow automatic linking in many flows, but manual linking via SDK is the safest implementation for cross-platform consistency.

## Deletion Grace Period Implementation
To support the 30-day deletion requirement:
- **PostgreSQL Metadata**: When a user clicks "Delete", we update their record in the `users` table with a `deletion_requested_at` timestamp.
- **Backend Service (Go/Cloud Functions)**:
    - **Scheduled Task**: Runs daily to delete any user record and Firebase Auth account where `deletion_requested_at` > 30 days.
    - **Cleanup Task**: On user deletion, securely remove their 5GB storage assets and clean up relationships in the `family_members` table.
- **App Logic**:
    - If a user logs in and `deletion_requested_at` is non-null, show a "Reactivate Account" screen.

## Phone Auth (Firebase PNV)
- **Implementation**: Use `FirebaseAuth.instance.verifyPhoneNumber`.
- **Flow**:
  1. `codeSent`: Capture `verificationId`.
  2. `codeAutoRetrievalTimeout`: Handle SMS timeout.
  3. `verificationCompleted`: Handle automatic OTP code retrieval (Android).
  4. `verificationFailed`: Handle invalid format or blocked numbers.
- **Postgres Integration**:
  - Upon successful verification and Firebase account creation, the user's `phone_number` is synchronized/verified in the Postgres `users` table.
  - Supports linking phone number to an existing Email/Google account via `linkWithCredential`.

## Profile Re-validation Technicals
- **Email Update**:
  1. User enters new email.
  2. Call `User.verifyBeforeUpdateEmail(newEmail)`.
  3. Postgres `users` table is updated *only* after Firebase confirms successful verification.
- **Phone Update**:
  1. User triggers update.
  2. Initiate `verifyPhoneNumber` on the new number.
  3. Upon success, call `User.updatePhoneNumber(credential)`.
  4. Sync the new phone number to Postgres.
- **Avatar Storage**:
  - Upload to Firebase Storage path: `/users/{uid}/avatars/{timestamp}.jpg`.
  - Update `photo_url` in both Firebase Auth and Postgres `users` table.

## Admin Roles & Permissions (Custom Claims)
- **Claim: `system_role`**:
  - `null` (User): Standard access to their own families.
  - `SYSTEM_ADMIN`: Grants access to the **Admin App dashboard**. **Mandatory: Google Sign-In required.**
  - `SUPPORT_AGENT`: Restricted dashboard access.
- **Onboarding Status**:
  - **PENDING**: User has requested admin access via Google but not yet approved.
  - **APPROVED**: Claim is set, user gains full access to `admin_app`.
  - **REJECTED**: Request denied; user remains a standard member.
- **Enforcement**:
  - **Firebase**: Rules check for `request.auth.token.system_role`.
  - **Go Backend**: gRPC middleware validates the claim for restricted services.
  - **Flutter**: Navigation guards prevent loading admin modules if the claim is missing.
