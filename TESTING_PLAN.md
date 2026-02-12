# 🧪 Testing Improvement Plan

**Created**: 2026-02-02  
**Goal**: Increase test coverage from 40% to 60%+  
**Priority**: High (from Code Review)

---

## 📊 Current State

### Backend (Go) - **70%** ✅
- ✅ Auth Service: 80%
- ✅ Family Service: 75%
- 🟡 Chat Service: 60%
- ✅ Repositories: 70%
- 🟡 Middleware: 50%

### Frontend (Flutter) - **40%** 🔴
- ✅ Firebase Auth Repo: 80%
- 🟡 Family Provider: 60%
- 🟡 Admin Onboarding: 50%
- 🔴 User App Widgets: 20%
- 🔴 Chat Page: 10%

---

## 🎯 Testing Priorities

### Phase 1: Critical Frontend Tests (Priority: HIGH)
**Goal**: Get User App to 60%+

1. **Chat Provider Tests** (`shared_package/test/app/providers/chat_provider_test.dart`)
   - [x] Test `familyChatStream` provider
   - [x] Test `chatHistory` provider
   - [x] Test `MergedChatMessages` deduplication logic
   - [x] Test `ChatController.sendMessage()`
   - **Estimated Coverage**: +20%

2. **Chat Page Widget Tests** (`user_app/test/features/chat/view/chat_page_test.dart`)
   - [x] Test message list rendering
   - [x] Test send message interaction
   - [x] Test loading/error states
   - [x] Test user profile resolution
   - **Estimated Coverage**: +15%

3. **Family Tree View Tests** (`user_app/test/features/family/view/family_tree_view_page_test.dart`)
   - [x] Test tree rendering
   - [x] Test add member dialog
   - [x] Test invite generation
   - [x] Test node tap interactions
   - **Estimated Coverage**: +15%

### Phase 2: Backend Edge Cases (Priority: MEDIUM)
**Goal**: Get Backend to 80%+

4. **Chat Service Tests** (improve `chat_service_test.go`)
   - [x] Test streaming with multiple subscribers
   - [x] Test error handling on send
   - [x] Test pagination edge cases
   - **Estimated Coverage**: +10%

5. **Middleware Tests** (`middleware/auth_test.go`, `middleware/recovery_test.go`)
   - [x] Test invalid JWT handling
   - [x] Test missing auth header
   - [x] Test panic recovery
   - **Estimated Coverage**: +10%

### Phase 3: Integration Tests (Priority: LOW)
**Goal**: End-to-end flow validation

6. **User Flow Integration** (`user_app/integration_test/`)
   - [ ] Login → Create Family → Add Member → Send Message
   - [ ] Join Family via invite token
   - **Estimated Coverage**: +5%

7. **Admin Flow Integration** (`admin_app/integration_test/`)
   - [ ] Login → Approve Request → Revoke Admin
   - [ ] Generate invite token
   - **Estimated Coverage**: +5%

---

## 📝 Test Implementation Checklist

### Immediate Actions (Today)
- [x] Create TESTING_PLAN.md
- [ ] Implement Chat Provider Tests
- [ ] Implement Chat Page Widget Tests
- [ ] Implement Family Tree View Tests

### This Week
- [ ] Improve Chat Service Tests
- [ ] Add Middleware Tests
- [ ] Run full test suite and measure coverage

### Next Week
- [ ] Integration tests for User App
- [ ] Integration tests for Admin App
- [ ] CI/CD pipeline integration

---

## 🎯 Success Metrics

| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| Overall Coverage | 55% | 65% | 🔴 In Progress |
| Backend Coverage | 70% | 80% | 🟡 Good |
| Frontend Coverage | 40% | 60% | 🔴 Needs Work |
| User App Widgets | 20% | 60% | 🔴 Critical |
| Chat Features | 35% | 70% | 🔴 Critical |

---

## 🛠️ Testing Tools & Best Practices

### Flutter Testing
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/chat/view/chat_page_test.dart

# Generate coverage HTML
genhtml coverage/lcov.info -o coverage/html
```

### Go Testing
```bash
# Run all tests
go test ./...

# Run with coverage
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out -o coverage.html

# Run specific test
go test -v ./internal/features/chat/app -run TestChatService
```

### Best Practices
1. ✅ **Arrange-Act-Assert** pattern
2. ✅ **Mock external dependencies** (gRPC clients, Firebase)
3. ✅ **Test edge cases** (null, empty, errors)
4. ✅ **Test async operations** (Future, Stream)
5. ✅ **Widget tests** for UI components
6. ✅ **Integration tests** for critical flows

---

## 📚 Test Templates

### Flutter Widget Test Template
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProvider extends Mock implements SomeProvider {}

void main() {
  group('WidgetName Tests', () {
    late MockProvider mockProvider;

    setUp(() {
      mockProvider = MockProvider();
    });

    testWidgets('should render correctly', (tester) async {
      // Arrange
      when(() => mockProvider.getSomething()).thenAnswer((_) async => data);

      // Act
      await tester.pumpWidget(ProviderScope(
        overrides: [someProvider.overrideWith((_) => mockProvider)],
        child: MaterialApp(home: WidgetName()),
      ));

      // Assert
      expect(find.text('Expected Text'), findsOneWidget);
    });
  });
}
```

### Go Service Test Template
```go
func TestServiceMethod(t *testing.T) {
	// Arrange
	mockRepo := &MockRepository{}
	service := NewService(mockRepo)
	ctx := context.Background()

	// Act
	result, err := service.Method(ctx, input)

	// Assert
	assert.NoError(t, err)
	assert.NotNil(t, result)
	assert.Equal(t, expected, result.Field)
}
```

---

## 🚀 Next Steps

1. **Prioritize Chat Tests** - Critical user feature
2. **Add Family Tree Tests** - Core functionality
3. **Improve Backend Coverage** - Edge cases
4. **Set up CI/CD** - Automated test runs
5. **Generate Coverage Reports** - Track progress

---

**Status**: 🔴 In Progress  
**Target Completion**: This Week  
**Owner**: Development Team
