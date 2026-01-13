# Testing Standards: Flutter

## Frameworks
- **Unit/Widget**: `flutter_test`.
- **Mocking**: `mocktail`.
- **Integration**: `integration_test`.

## Unit Testing (Repositories/Logic)
- **Location**: `test/` directory mirroring `lib/` structure.
- **Mocking**:
    - Extend `Mock` from `mocktail`.
    - `when(() => mock.method()).thenAnswer(...)`.
- **Async**: Use `await` and `expectLater` for Streams.

## Widget Testing (UI)
- **Riverpod Overrides**:
    Critical for injecting mocks into the widget tree.
    ```dart
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(mockAuthRepo),
        ],
        child: MaterialApp(home: MyWidget()),
      ),
    );
    ```
- **Finder**: `find.byType`, `find.text`.
- **Interactions**: `tester.tap`, `tester.enterText`.
- **Pumping**: `tester.pump()` (frame), `tester.pumpAndSettle()` (animations).

## Integration Testing
- **Location**: `integration_test/app_test.dart`.
- **Runner**: `flutter test integration_test`.
- **Scope**: Full app flow (Login -> Dashboard). usually runs on Emulator.

## Running Tests
- **Package level**: `flutter test` inside `packages/shared_package`.
- **App level**: `flutter test` inside `apps/user_app`.
