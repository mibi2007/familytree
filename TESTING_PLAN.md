# 🧪 Testing Improvement Plan

**Created**: 2026-02-02  
**Goal**: Increase test coverage from 40% to 60%+  
**Priority**: High (from Code Review)

---

## 📊 Historical Baseline

The percentages below are the original February 2026 baseline. They must not be treated as current until fresh coverage reports are generated.

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

### Phase 3: Integration Tests (COMPLETE)
**Goal**: End-to-end flow validation

Browser-level system tests use Playwright in `e2e/` and validate Firebase, gRPC-Web, Go, and PostgreSQL together. Separate Flutter `integration_test` duplication is not required for these system flows.

6. **User Flow Integration** (`e2e/tests/user/`)
   - [x] Login → Create Family → Add Member → Send Message
   - [x] Join Family via invite token
   - [x] Parent/child creation and kinship lookup
   - [x] Invalid and reused invite-token handling

7. **Admin Flow Integration** (`e2e/tests/admin/`)
   - [x] Login → Approve Request → Revoke Admin
   - [x] Generate invite token (covered by Playwright)
   - [x] Pending/rejected onboarding routing
   - [x] Submit onboarding request → visible to root admin

8. **Playwright System E2E** (`e2e/`)
   - [x] Deterministic local stack and seeded identities
   - [x] User/admin smoke coverage
   - [x] Invalid user credential feedback
   - [x] Email signup, backend profile registration, and re-login
   - [x] English/Vietnamese localization key parity, rendering, and persisted language switching
   - [x] Theme and notification preference persistence
   - [x] Authenticated user logout
   - [x] Create family → add member → invite/join → chat flow
   - [x] Parent/child member creation and kinship lookup
   - [x] Invalid and single-use family invite-token enforcement without backend interruption
   - [x] Admin health, onboarding submission/routing, request approval/rejection, and revocation flows
   - [x] Admin invitation-token generation, expiry, and copy controls
   - [x] Full traces, videos, and screenshots for every test

---

## 📝 Test Implementation Checklist

### Immediate Actions (Today)
- [x] Create TESTING_PLAN.md
- [x] Implement Chat Provider Tests
- [x] Implement Chat Page Widget Tests
- [x] Implement Family Tree View Tests

### This Week
- [x] Improve Chat Service Tests
- [x] Add Middleware Tests
- [ ] Run full test suite and measure coverage

### Next Week
- [x] Integration tests for User App via Playwright
- [x] Integration tests for Admin App via Playwright

---

## 🎯 Success Metrics

| Metric | Historical | Target | Current Status |
|--------|------------|--------|----------------|
| Overall Coverage | 55% | 65% | Needs fresh measurement |
| Backend Coverage | 70% | 80% | Needs fresh measurement |
| Frontend Coverage | 40% | 60% | Needs fresh measurement |
| User App Widgets | 20% | 60% | Needs fresh measurement |
| Chat Features | 35% | 70% | Needs fresh measurement |

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

1. **Generate Coverage Reports** - Run Go and Flutter coverage commands locally.
2. **Update Success Metrics** - Replace historical percentages with measured results.
3. **Maintain Focused Tests** - Run only the affected package/project while developing.
4. **Run Full Validation Manually** - Use the full suite only at release checkpoints.

---

**Status**: 🟡 Test implementation complete; coverage measurement pending  
**Owner**: Development Team
