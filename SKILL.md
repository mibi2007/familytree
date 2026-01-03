# SKILL.md - Family Tree Chat Coding Standards

## 1. Architecture: Domain Driven Design (DDD)
The project follows a strict 4-layer DDD architecture for each feature:

- **Domain Layer**: The heart of the feature. Contains pure logic, entities, and repository interfaces. No dependencies on external packages (except for functional programming libs if used).
- **Infrastructure Layer**: Implementation of the repository interfaces. Handles data sources (Firebase, APIs, Local DB). Converts external data models to Domain entities.
- **Application Layer**: Use cases and service logic. Orchestrates the flow of data between Domain and Presentation.
- **Presentation Layer**: UI components, widgets, and state management (e.g., BLoC or Riverpod).

## 2. Package Management: Melos
- All Flutter code is managed via **Melos** in the `familytree_flutter` workspace.
- **Shared Package**: `shared_package` contains shared UI components, themes, and common logic used by both `user_app` and `admin_app`.
- Apps must depend on `shared_package` for unified branding and common assets.

## 3. Firebase Integration
- Firebase logic should be abstracted in the **Infrastructure** layer.
- Use Cloud Functions for complex backend logic (handled in `familytree_firebase`).

## 4. Technical Stack
- **Databases**:
  - **PostgreSQL**: Primary relational storage (Users, Families, Roles, Chat History).
  - **Firebase Realtime Database**: Real-time message synchronization.
  - **Firebase Storage**: Image and media hosting (5GB quota).
- **State Management**: [Riverpod](https://riverpod.dev/) (Hooks approach preferred where applicable).
- **Functional Programming**: [fpdart](https://pub.dev/packages/fpdart) for Type-safe error handling (Either, TaskEither).
- **Data Modeling**: [Freezed](https://pub.dev/packages/freezed) for data classes, unions, and pattern matching.
- **AI Integration**: Google Generative AI (Gemini) with GenUI.

## 5. AI Assistence (@family)
- Integration with Gemini/GenUI should reside in its own feature module following the DDD pattern.
- Prompt engineering for "Family knowledge" should be centralized in the backend or a dedicated service.

## 6. Localization (l10n)
- **Primary Language**: Vietnamese (`vi`).
- **Secondary Language**: English (`en`).
- **Standard**: Use `flutter_localizations` and `.arb` files in `shared_package`.
- **Naming**: Use descriptive keys (e.g., `auth_signIn_google`).

## 7. Theming
- **Supported Modes**: Light, Dark, and System (device-based).
- **Material Design**: Use Material 3 (`useMaterial3: true`).
- **Implementation**: Color schemes should be defined in `shared_package` and applied consistently across both apps.
- **State Management**: Use a Riverpod provider to persist and switch theme modes.

## 8. Environment Management
We support 3 environments: **dev**, **stg**, and **prod**.
- **Isolation**: Each environment uses a completely separate Firebase Project.
- **Flutter Flavors**: 
  - Each environment has its own entry point: `lib/main_dev.dart`, `lib/main_stg.dart`, and `lib/main_prod.dart`.
  - These files are essential for initializing environment-specific configurations (like Firebase) without cluttering `main.dart` with conditional logic.
- **Firebase Infrastructure**:
  - We use a **single folder structure** in `familytree_firebase` (functions, firestore, storage).
  - **Git-based Versioning**: Environment-specific code logic is managed via **Git branches** (e.g., `main`, `staging`, `develop`).
  - **Configuration Isolation**: Different Firebase projects are targeted using `.firebaserc` and CLI aliases (`firebase use dev`).
