# Super Admin - Technical Solution

## Data Modeling (Postgres)

### System Statistics (Materialized Views or Summary Table)
- **`system_stats`**:
  - `total_users`: int
  - `total_families`: int
  - `last_updated`: timestamp
- **`admin_activity_logs`**:
  - `admin_id`: uuid
  - `target_id`: uuid (User or Family)
  - `action`: string
  - `metadata`: jsonb (e.g., "changed status from active to suspended")

### General Purpose Secure Token System (Postgres)
- **`secure_tokens` Table**:
  - `token`: string PK (Cryptographically secure 32-char string)
  - `purpose`: enum (ADMIN_ONBOARDING, FAMILY_INVITE, SUPPORT_GRANT)
  - `associated_id`: uuid Nullable (e.g., family_id)
  - `created_by`: string FK (users.id)
  - `expires_at`: timestamp Nullable (NULL = Unlimited)
  - `is_used`: boolean (Default: false)
  - `created_at`: timestamp

### Token Lifecycle & Cleanup
- **Generation**: Triggered from `admin_app` with high-entropy 32-char string.
- **Validation (Precise)**: The backend performs a real-time check during usage:
  - `expires_at > NOW()`
  - `is_used == false`
- **Consumption**: Upon successful sign-up or invitation acceptance, the backend marks the token as `is_used = true` within the same transaction.
- **Cleanup Schedule (Garbage Collection)**: 
  - **Frequency**: Once per day (Off-peak hours).
  - **Logic**: `DELETE FROM secure_tokens WHERE (expires_at < NOW() AND expires_at IS NOT NULL) OR is_used = true`.

### Admin Requests (Postgres)
- **`admin_access_requests`**:
  - `user_id`: string PK, FK (users.id)
  - `requested_role`: enum (SYSTEM_ADMIN, SUPPORT_AGENT)
  - `status`: enum (PENDING, APPROVED, REJECTED)
  - `reason`: text
  - `reviewed_by`: string FK (users.id)
  - `updated_at`: timestamp

### User Search Optimization (Postgres)
- **Searchable Columns**: `display_name`, `email`, `phone`.
- **Implementation**:
  - Use Postgres `unaccent` extension to normalize text.
  - Perform `ILIKE` or `SIMILAR TO` queries on lower-cased, unaccented values.
  - Example: `SELECT * FROM users WHERE unaccent(lower(display_name)) LIKE unaccent(lower('%Trần%'))` -> Matches "Tran", "Trần", "TRAN".

### Family Access Support Logic
- **Mechanism**: Standard Family Roles.
- **Process**:
  1. System Admin user ID is added to the `family_members` or a family roles table as an `ADMIN`.
  2. The Go backend treats the System Admin as a standard family admin for that specific `family_id`.
  3. No special bypass tables are used; privacy is maintained through standardized RBAC.

### Concierge Handover Logic
- **Ownership Transfer**: 
  - The Go backend provides an `UpdateFamilyOwner` RPC.
  - This method updates the `owner_id` in the `families` table.
  - Verification: Only the current `owner_id` (the Super Admin in this case) can trigger the transfer.
- **Handover Termination**: 
  - After transfer, the Super Admin triggers a `LeaveFamily` RPC.
  - This removes the Super Admin's record from the `family_members` table for that family.

## Infrastructure Strategy

### Go Backend (SuperAdminService)
- **Restricted RPCs**: All methods in `SuperAdminService` must verify the `is_system_admin: true` claim from the JWT.
- **Audit Interceptor**: A gRPC middleware that automatically logs all write-operations performed by system admins.

### Real-time Sync & Notifications
- **Firebase RTDB**: Used for:
  - **Live Dashboard**: Reflect active user counts and system status changes instantly.
  - **Admin Sign-up Notifications**: When `admin_access_requests` is updated, the backend pushes a notification payload to RTDB, triggering a toast/badge in the `admin_app` for all online Super Admins.

## Security Controls
- **Admin App Lockdown**: The `admin_app` will check for the `SYSTEM_ADMIN` claim immediately after login. If missing, it will redirect to an unauthorized screen or log out.
- **Access Revocation**: When a family owner revokes "Admin Access", the Go backend must immediately invalidate any active session for that family in the admin app.
