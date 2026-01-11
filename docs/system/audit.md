# System Audit & Compliance

## Overview
The Audit System provides a centralized mechanism for tracking sensitive actions performed within the application. Unlike Access Control (authentication/authorization) which *prevents* actions, the Audit System *records* actions after they occur for accountability and historical analysis.

## Architecture

The audit system is implemented as a **gRPC Interceptor** in the Go backend. This ensures that every successful request to a monitored endpoint is automatically logged without cluttering the business logic.

### Data Flow
1.  **Request**: Client sends a gRPC request (e.g., `ReviewAdminRequest`).
2.  **Auth Layer**: Verifies identity and permissions.
3.  **Application Logic**: Executes the business rule (e.g., updates database).
4.  **Audit Interceptor**:
    *   Checks if the method is flagged for auditing.
    *   If successful, creates an `AuditLog` entry.
    *   Persists the entry to the `admin_activity_logs` table.

## Schema (`admin_activity_logs`)

| Field | Type | Description |
| :--- | :--- | :--- |
| `id` | UUID | Unique identifier for the log entry. |
| `admin_id` | TEXT | Firebase UID of the user who performed the action. |
| `target_id` | UUID | ID of the object being acted upon (User ID, Family ID). |
| `action` | TEXT | gRPC method name (e.g., `/auth.v1.AuthService/ReviewAdminRequest`). |
| `metadata` | JSONB | JSON object containing additional context (e.g., old/new values). |
| `created_at` | TIMESTAMP | Time of the action. |

## Monitored Actions

The following actions are currently audited:

*   **Authentication & Admin**:
    *   `ReviewAdminRequest`: Approving or rejecting new admin applications.
    *   `GenerateInviteToken`: Creating new secure system invites.
*   **Family Management**:
    *   `UpdateFamilyOwner`: Critical ownership transfers.
    *   `DeleteMember`: Permanent removal of data nodes.

## Usage

### For Developers
To add auditing to a new method, add the full gRPC method path to the `isAuditAction` function in `internal/middleware/audit.go`.

### For Super Admins
Audit logs provide the "Paper Trail" for all critical system changes. While primarily for security compliance, this data can also be exposed to Super Admins to review the history of actions taken by their Support Agents.
