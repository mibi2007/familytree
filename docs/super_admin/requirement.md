# Super Admin - Requirements

## Overview
The Super Admin application (`admin_app`) is the centralized command center for system owners to monitor health, manage the user base, and provide administrative support to families.

## Functional Requirements

### 0. Admin Onboarding & Approval
- **Secure Invitation Link**: Existing Super Admins must generate a unique, time-limited invitation link from the dashboard.
  - **Expiration Options**: 1 hour, 1 day, or Unlimited.
- **Restricted Signup**: Candidates must use the **Invitation Link** + **Google Sign-In** to apply for access.
- **Request Notification**: Existing Super Admins receive a real-time notification when a new invitation is accepted/sign-up occurs.
- **Approval Console**: 
  - Admins can filter users by "Admin Request" status.
  - View request details and choose to **Approve** or **Reject**.
  - Approval instantly elevates the user's role to `SYSTEM_ADMIN` or `SUPPORT_AGENT`.

### 1. Dashboard & Monitoring
- **Real-time Statistics**:
  - Total registered users.
  - Total active families.
  - New users/families in the last 24 hours.
- **System Health**: Overview of backend service status (link to monitoring).

### 2. User Management
- **Directory Search**: Search users by Email, Phone, or Name.
  - **Logic**: Flexible matching using lower-case and accent-neutral text (e.g., "trần" matches "tran").
- **Account Control**: Ability to suspend or reactivate user accounts for system safety.
- **Role Management**: Promote/Demote other System Admins.

### 3. Family Support & Administration
- **Support Workflow (Privacy-First)**:
  - Super Admin identifies a user via Directory Search.
  - Super Admin sends a **Friend Request** to the user.
  - Once accepted, the User can chose to grant the **Admin Role** to the Super Admin for a specific Family.
  - **System Admin access is NEVER automatic**; it relies on standard family role delegation.
- **Concierge Family Creation**:
  - Super Admin can create a new family on behalf of a friend.
  - Super Admin manages initial tree setup (adding members, mapping relationships).
  - Super Admin transfers **Ownership** to the friend and leaves the family.
- **Conflict Resolution**: Provide support for account linking or system-level data issues ONLY after being invited by the user.

### 4. Family Management Parity
- **Full Capabilities**: When acting as a delegated Admin for a family, the `admin_app` provides the complete feature set of the `user_app` for that family:
  - **Member Management**: Add, edit, remove, and reindex family members.
  - **Events & Timeline**: Create and automate family events and timeline entries.
  - **Tree Visualization**: Full interactive tree editing.
  - **Media**: Access to family photo galleries and shared media (as allowed by the owner).

## User Roles (Admin Context)
- **SYSTEM_ADMIN**: Full access to all administrative modules.
- **SUPPORT_AGENT**: Restricted access (Read-only on stats, can manage users but cannot access private family trees unless explicitly invited).

## Security & Privacy
- **Role-Based Access Control (RBAC)**: Enforced via custom Firebase Claims.
- **Data Privacy**: Super Admins cannot view private family content (chats, photos, tree nodes) unless the family owner has explicitly granted "Admin Access".
