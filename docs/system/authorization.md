# Authorization & Access Control

## Overview
The FamilyTree system uses **Firebase Authentication** for identity verification and custom Role-Based Access Control (RBAC) within the application logic to restrict access to sensitive operations.

## Architecture

### 1. Identity Provider (IdP)
- **Firebase Auth** handles the initial authentication (Sign In, Token Generation).
- All protected gRPC endpoints require a valid Firebase ID Token in the `Authorization` header (`Bearer <token>`).

### 2. Middleware & Context
- An **AuthInterceptor** validates the Firebase token on every request.
- If valid, the **Firebase Token** (containing `uid`, `email`, etc.) is injected into the request context.

### 3. Application-Level Guards
To ensure consistent security and clean API implementation, we use **Guards** to enforce RBAC rules.

#### SuperAdminGuard
- **Purpose**: Restricts access to highly sensitive endpoints (e.g., listing admins, revoking roles, approving requests).
- **Behavior**:
  1. Retrieves the authenticated user from the context.
  2. Fetches the user's current role from the PostgreSQL database (via `AppService`).
  3. Checks if the role matches `SYSTEM_ROLE_SUPER_ADMIN`.
  4. If unauthorized, returns a consistent `PermissionDenied` error.

## Implementation Pattern

### Handler Integration
Handlers delegate authorization checks to the service layer or explicit guard helpers.

```go
// Example Handler
func (s *AuthHandler) ListAdmins(ctx context.Context, req *Request) (*Response, error) {
    // 1. Guard Check
    if err := s.guard.RequireSuperAdmin(ctx); err != nil {
        return nil, err
    }

    // 2. Business Logic
    return s.service.ListAdmins(ctx)
}
```

### Roles
- **USER**: Standard access.
- **SUPPORT_AGENT**: Can manage users but limited system access.
- **SUPER_ADMIN**: Full system access.

## Future Improvements
- **Custom Claims**: In the future, we may mirror the PostgreSQL role into Firebase Custom Claims to reduce database lookups during authorization checks.
