# Domain Driven Design: Flutter Implementation

## Directory Structure
Flutter code is managed in a monorepo. Shared logic resides in `shared_package`, while app-specific UI resides in `apps/`.
However, we follow DDD within `shared_package` for core logic and within `apps` for specific features.

```
lib/features/family/
├── app/
│   ├── providers/
│   │   └── family_provider.dart # Riverpod Controllers/Providers
├── domain/
│   ├── member.dart          # Freezed Entity
│   └── family_repository.dart # Abstract Class (Interface)
├── data/
│   └── repositories/
│       └── grpc_family_repository.dart # Implementation calls gRPC client
├── view/
│   ├── widgets/
│   │   └── family_tree_canvas.dart
│   └── pages/
│       └── family_page.dart
```

## Rules & Standards

### 1. Domain Layer
- **Freezed Classes**: Use `freezed` for immutable state and entities.
- **Failures**: Use `fpdart`'s `Either<Failure, Success>` return types for Repository methods.
- **No Flutter Widgets**: Domain files should be pure Dart.

### 2. App Layer
- **Providers/Controllers**: App Logic flows here. Use `Riverpod` providers to connect UI with Domain/Data.
- **Orchestration**: Manage state and coordinate Repositories.

### 3. Data Layer
- **Repositories**: Implement Domain interfaces.
- **Data Sources**: Call `grpc_client` providers.
- **DTOs**: Protobuf generated classes live here (technically imported from `generated/`). Map Protobuf objects to Domain entities immediately.

### 4. View Layer
- **Riverpod**:
    - **Providers**: `ref.watch(repositoryProvider)`.
    - **Controllers**: `AsyncNotifier` or `StateNotifier` for managing UI state.
- **Widgets**: Dumb components that take data as arguments.
- **Pages**: Smart components that interact with Providers.

## State Management Pattern
1.  **Repository Provider**: `@riverpod FamilyRepository familyRepository(Ref ref) => ...`
2.  **Service/Controller**: Uses Repo.
3.  **UI**: Watches Controller state (`AsyncValue`).

## Example: New Feature
1.  Define `Entity` in `domain/`.
2.  Define `Repository` interface in `domain/`.
3.  Implement `Repository` in `data/` (calling gRPC).
4.  Create `Provider` in `app/providers/`.
5.  Build UI.
