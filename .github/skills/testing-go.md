# Testing Standards: Go

## Frameworks
- **Test Runner**: Standard `go test`.
- **Assertions**: `github.com/stretchr/testify/assert` and `require`.
- **Mocking**: `github.com/stretchr/testify/mock`.
- **DB Mocking**: `github.com/DATA-DOG/go-sqlmock`.

## Service Layer Testing
- **Structure**: Tests sit in the same package (e.g., `application` package tests in `auth_service_test.go`).
- **Mocking Dependencies**:
    - Create struct `mockUserRepo` embedding `mock.Mock`.
    - Implement interface methods calling `m.Called(...)`.
    - Inject mock into Service.
- **Pattern**:
    ```go
    func TestMyService_Method(t *testing.T) {
        // Setup
        mockRepo := new(MockRepo)
        svc := NewService(mockRepo)
        
        // Expectations
        mockRepo.On("Find", ctx, "id").Return(user, nil)
        
        // Execute
        result, err := svc.Method(ctx, "id")
        
        // Assert
        assert.NoError(t, err)
        assert.Equal(t, user, result)
        mockRepo.AssertExpectations(t)
    }
    ```

## Repository Layer Testing
- **Strategy**: Use `go-sqlmock` to simulate DB responses. Do not rely on a running Postgres instance for Unit Tests.
- **Verification**: Ensure correct SQL queries are constructed and arguments mapped.

## Running Tests
- **All**: `go test ./internal/features/...`
- **Coverage**: `go test -cover ./...`
