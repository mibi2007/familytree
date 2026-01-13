# Domain Driven Design: Go Implementation

## Directory Structure
We follow a "Feature-Sliced" DDD approach in Go. Each feature is self-contained in `internal/features/<feature_name>`.

```
internal/features/auth/
├── domain/                  # Pure Business Logic
│   ├── user.go             # Entities
│   ├── repository.go       # Interfaces (Persistence, External Services)
│   └── errors.go           # Domain specific errors
├── app/                     # App Services
│   ├── auth_service.go     # Implementation of use cases
│   └── auth_service_test.go
├── data/                    # Adapters & Implementations
│   ├── postgres/           # Database implementations
│   │   ├── user_repository.go
│   │   └── token_repository.go
│   └── firebase/           # External service implementations
├── interfaces/             # Entry Points (View Layer)
    └── grpc/               # gRPC Handlers
        ├── auth_handler.go
        └── mapper.go       # Proto <-> Domain mapping
```

## Rules & Standards

### 1. Domain Layer
- **No external dependencies**: Should not import `database/sql`, `gin`, `grpc`, etc.
- **Interfaces strictly here**: Repository interfaces are defined where they are *used* (conceptually), but in our clean arch, they sit in Domain to define the contract.
- **Pure Entities**: Structs with JSON tags are allowed if needed for simple serialization, but mainly pure fields.

### 2. Data Layer
- **Implements Interfaces**: Must implement interfaces defined in `domain`.
- **Dependency Injection**: Structs should accept a `*sql.DB` or similar in a `New...` factory function.
- **Mapping**: Convert DB models (if different) to Domain entities before returning.

### 3. App Layer
- **Orchestration**: Calls Repositories, handles transactions (if using UoW pattern), triggers events.
- **No Transport Logic**: Should not know about HTTP/gRPC status codes. Returns standard Go errors or Domain errors.

### 4. Interfaces Layer (gRPC / View)
- **Transport Translation**: Converts gRPC Requests -> App Service Calls -> gRPC Responses.
- **Error Handling**: Maps Domain errors (e.g., `ErrUserNotFound`) to gRPC Status codes (`codes.NotFound`).
- **Middleware**: Validation and Authentication happen here (Interceptors).

## Example: Adding a Field
1.  Add field to **Domain** struct.
2.  Update **Data** SQL queries/Scan.
3.  Update **Proto** definition.
4.  Update **Interfaces** mapper to map Proto <-> Domain.
