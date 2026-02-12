# Family Tree Chat - Project Roadmap

## Phase 0: Conceptualization & Design (DONE ✅)
- [x] **Documentation System**: Established `docs/` for Auth, Family, Chat, AI, Admin, and Data.
- [x] **Architecture Design**: Defined DDD layers, gRPC communication, and Go microservices.
- [x] **Technical Solutions**: Documented tree snapshot caching, Vietnamese kinship logic, and AI context injection.
- [x] **Super Admin Strategy**: Defined privacy-first support flows and concierge onboarding.

## Phase 1: Baseline Infrastructure (DONE ✅)
- [x] **Flutter Architecture**: Melos workspace initialized with `user_app`, `admin_app`, and `shared_package`.
- [x] **Firebase Hosting**: Multi-site configuration for `dev`, `stg`, and `prod`.
- [x] **Deployment Automation**: Unified `deploy.sh` for multi-env builds.
- [x] **Local Environment**: Multi-env config for Go/Flutter & Emulator setup.

## Phase 2: Core Backend - `familytree_go` (DONE ✅)
- [x] **Foundation**:
    - [x] gRPC Server & Interceptors.
    - [x] Postgres DB Connection & Migrations.
    - [x] Config Loading (Env vars).
- [x] **Feature: Auth (Identity & Access)**:
    - [x] **Domain**: `User`, `Token`, `SuperAdminRequest`.
    - [x] **Repo**: `UserRepository`, `TokenRepository`, `SuperAdminRequestRepository` (Postgres).
    - [x] **Service**: `RegisterUser`, `Login` (Sync), `RequestAdminAccess`.
    - [x] **Admin Flow**: Invite Token Parsing, Generating, & Validation.
    - [x] **Testing**: Unit tests for Service & Repository layers.
- [x] **Feature: System (Observability)**:
    - [x] **Audit**: Middleware for logging critical admin actions (`AuditInterceptor`).
    - [x] **Health**: `GetHealthStatus` RPC for system components (Server, DB, GSC).
    - [x] **Repo**: `LogRepository` (Postgres).
    - [x] **Testing**: Middleware & Health Service unit tests.
- [x] **Feature: Family (Core Logic)**:
    - [x] **Service**: `CreateFamily`, `GetFamily`, `UpdateMember`, `GetTree`, `JoinFamily`.
    - [x] **Schema**: Many-to-many access via `family_access`.
    - [x] **Logic**: Kinship calculation engine. (Basic levels implemented)
    - [x] **Testing**: JoinFamily and Access Control unit tests.
- [x] **Feature: Chat (Real-time Messaging)**:
    - [x] **Service**: `SendMessage`, `ListMessages`, `StreamMessages`.
    - [x] **Pub/Sub**: In-memory publisher for real-time streaming.
    - [x] **Testing**: Chat service unit tests.
- [x] **Feature: Settings (User Preferences)**:
    - [x] **Domain**: `UserSettings` entity with theme, language, notifications.
    - [x] **Repo**: PostgreSQL repository with UPSERT logic.
    - [x] **Service**: Business logic with validation & default settings.
    - [x] **Handler**: gRPC endpoints with authentication.
    - [x] **Database**: Migration for `user_settings` table.

## Phase 3: Core Frontend - `familytree_flutter` (DONE ✅)
- [x] **Shared Package (`shared_package`)**:
    - [x] **Infrastructure**: gRPC Client (proto for all services) & Interceptors.
    - [x] **Auth Repository**: `FirebaseAuthRepository` (Google, Email, Phone).
    - [x] **State Management**: **Signals** (migration from Riverpod complete).
    - [x] **Signals Architecture**:
        - [x] Data layer signals (gRPC clients, repositories).
        - [x] App layer signals (auth, settings).
        - [x] Computed signals for derived state.
    - [x] **Settings Signal**: Local persistence + cloud sync with shared_preferences.
    - [x] **Testing**: Unit tests for Auth Repository (using `mocktail`).
    - [x] **Testing**: Chat Provider tests (11 tests) - 90% coverage.

## Phase 3.5: Signals Migration (COMPLETE ✅)
**Goal**: Migrate state management from Riverpod to Signals.

**Status**: **COMPLETE** - All features migrated to Signals

**Completed Work**:
- [x] Infrastructure Setup & POC
- [x] Data Layer Migration (gRPC clients, repositories)
- [x] Auth Feature Migration (auth signals, controllers)
- [x] Navigation Migration (GoRouter with signals)
- [x] Admin App Migration (all features using Signals)
- [x] Settings Feature Implementation (Signals-first)
- [x] Cleanup: Removed Riverpod dependencies

**Benefits Realized**:
- ✅ **No code generation** - eliminated build_runner dependency
- ✅ **60% less boilerplate** - cleaner, more maintainable code
- ✅ **Better performance** - fine-grained reactivity
- ✅ **Simpler mental model** - direct reactive primitives

- [x] **Admin App (`admin_app`)**:
    - [x] **Screens**: Login, Admin Onboarding, Dashboard (Health Monitor), Admin Request List, Settings.
    - [x] **Logic**: Auth Status Check (Role-based), Routing, Submit Admin Request.
    - [x] **Logic**: Approve/Reject requests.
    - [x] **Logic**: Invite Users (Token Generation).
    - [x] **Logic**: Theme switching (Light, Dark, System).
    - [x] **Health**: Integrated real-time health monitoring of backend components.
    - [x] **State Management**: Fully migrated to Signals.
- [x] **User App (`user_app`)**:
    - [x] **Screens**: Login, Profile, Family Tree View, Real-time Chat.
    - [x] **Logic**: Join/Create Family, Update Profile.
    - [x] **Testing**: Chat Page widget tests (15 tests) - 85% coverage.
    - [x] **Testing**: Family Tree View tests (17 tests) - 60% coverage.

## Phase 4: Integration & Features (DONE ✅)
- [x] **Super Admin Onboarding**: Connect Flutter Admin App UI to Go Backend `RequestAdminAccess`.
- [x] **Family Management**: Visual Tree Builder in Flutter (GraphView, Add Child).
- [x] **Family Invite System**: Create Invite Token (Go/Flutter), Join Family Dialog.
- [x] **Real-time Chat**: gRPC Streams (backend) + Signals (Flutter).
    - [x] **Features**: History loading, live updates, sender profiles.
- [x] **Code Review**: Comprehensive review of all components (see CODE_REVIEW.md).
- [x] **Testing Improvements**: Added 43 new tests, increased coverage from 40% to ~70%.

## Phase 5: User Settings (COMPLETE ✅)
- [x] **Backend**:
    - [x] Proto definition for SettingsService.
    - [x] Database migration for `user_settings` table.
    - [x] Repository implementation with UPSERT.
    - [x] Application service with validation.
    - [x] gRPC handler with authentication.
    - [x] Server registration in main.go.
    - [x] Unit tests (repository, service, handler).
- [x] **Frontend**:
    - [x] Settings signal with local storage (shared_preferences).
    - [x] Cloud sync logic (DB precedence).
    - [x] Settings page UI (theme, language, notifications).
    - [x] Bootstrap integration for initialization.
    - [x] MaterialApp theme wired to settings.
    - [x] Theme signal reactivity (computed from settings).
    - [x] Multi-user settings isolation (bug fix).
- [x] **Testing**:
    - [x] Unit tests: 7/7 passing (initialization, reactivity, multi-user isolation).
    - [x] Integration tests: 4/4 passing (multi-user scenarios, signal state).
    - [x] Manual testing: Theme switching, persistence, database sync verified.
- [x] **Integration**:
    - [x] Proto generation scripts updated.
    - [x] Go protos generated.
    - [x] Dart protos generated.
- [x] **Documentation**:
    - [x] Cleaned up outdated migration docs.
    - [x] Created comprehensive walkthrough.
- [x] **Admin App Improvements**:
    - [x] Dark mode fixes for invite dialogs.
    - [x] "Go to Home" Button after admin approval.
    - [x] Fixed navigation timing issues.

## Phase 6: Advanced Features (PLANNED �)
- [ ] **AI Assistant**: Gemini context integration via Genkit Go.
    - [ ] Set up Genkit Go framework.
    - [ ] Create AI service with context injection.
    - [ ] Integrate with chat for family history queries.
- [ ] **Vietnamese Kinship**: Complex addressing logic.
    - [ ] Implement relationship calculator.
    - [ ] Add cultural titles (Bác, Chú, Cô, Dì, etc.).
    - [ ] Handle spouse-side family addressing.

## Verification Tasks (CURRENT)
- [x] backend: `go test ./...` (PASS)
- [x] frontend: `flutter test` in `shared_package` (PASS)
- [x] frontend: `flutter test` in `apps/admin_app` (PASS - Onboarding Flow)
- [x] frontend: `flutter test` in `apps/user_app` (PASS - Smoke Test)
- [x] frontend: `flutter analyze` (PASS)
- [x] backend: Role promotion logic and migrations (PASS)
- [x] Integration: End-to-end flow (Login -> Sync -> Role Persistence) (PASS).
- [x] Phase 4: Integration & Features
    - [x] Super Admin Onboarding & Manual Bootstrapping (Verified).
    - [x] Admin Approval Flow (Promote User to Admin).
    - [x] Family Management: Visual Tree Builder in Flutter (GraphView + Add Child).
    - [x] Real-time Chat: gRPC Streams + Flutter UI (User App).
    - [x] System Health Monitoring in Admin Dashboard.
- [x] Phase 5: User Settings
    - [x] Backend implementation and registration.
    - [x] Frontend UI and integration.
    - [x] Database migration applied.
    - [x] End-to-end verification (theme switching, persistence, sync).
    - [x] Comprehensive testing (11 unit + integration tests passing).
    - [x] Multi-user isolation bug fixed and tested.

## Recent Achievements
- ✅ **Signals Migration Complete** (Feb 2026): Fully migrated from Riverpod to Signals across all features.
- ✅ **Settings Feature Complete** (Feb 2026): Full implementation with theme/language/notification preferences, local + cloud persistence.
- ✅ **Admin UI Improvements** (Feb 2026): Dark mode support + optimized onboarding flow.
