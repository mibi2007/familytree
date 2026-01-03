# Authentication - Requirements

## Overview
Provide a secure and flexible authentication system for family members and administrators.

## Functional Requirements
- **Authentication Methods**:
  - Google Sign-In (Primary).
  - Email/Password (Login & Registration).
  - Phone Number (using Firebase Phone Number Verification - PNV).
- **Registration Flow**:
  - **Email Registration**: Users can create an account using email and password.
  - **Verification**: Email verification is required before full access is granted to family features.
  - **Account Linking**: 
    - Support for multiple providers (Google, Email, Phone) linked to a single user identity.
    - If a user signs in with Google using an email that already exists via Email/Password, the accounts will be linked automatically (Google is a trusted provider).
    - If a user tries to create an Email/Password account with an email already used by Google, they are prompted to Sign In with Google.
- **Account Management**:
  - **Account Creation**: Automatic profiles created upon first sign-in.
  - **Account Deletion**: 
    - Users can request account deletion.
    - **Grace Period**: Accounts are not immediately deleted. They enter a "Pending Deletion" state for **30 days**.
    - **Data Persistence**: Deleting a user account **does not** delete associated member nodes in family trees or their kinship titles. The node simply returns to an "Unclaimed" (null `user_id`) state.
    - **Recovery**: Users can cancel the deletion request within the 30-day period.
- **Profile Management**:
  - **Edit Info**: Users can update their display name and avatar (image upload).
  - **Email/Phone Updates**: 
    - Requires **Re-validation** before the change is finalized in Postgres.
    - Email updates require verification of the new email address.
    - Phone updates require Firebase PNV for the new number.
- **Session Management**:
  - Persistent login across app restarts.
  - Secure token handling via Firebase.
