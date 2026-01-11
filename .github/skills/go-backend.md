# Go Backend Development

Highly performant and concurrent backend services leveraging Go's ecosystem.

## Core Stack
- **Go**: Primary language for business logic and gRPC services.
- **gRPC**: Efficient, type-safe communication between frontend and backend.
- **PostgreSQL**: Reliable relational storage with complex relationship management (e.g., family trees).
- **SQLMigrations**: Raw SQL migration files for versioned schema changes.

## Patterns
- **Concurrency**: Safe usage of goroutines and channels (e.g., used in the Chat Publisher).
- **Dependency Injection**: Manual DI in `main.go` for clear ownership and testability.
- **Testing**: Using `testify` and `sqlmock` for robust unit and integration testing.
