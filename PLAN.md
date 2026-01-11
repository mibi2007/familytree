# Family Tree Chat - Project Roadmap

## Phase 0: Conceptualization & Design (DONE)
- [x] **Documentation System**: Established `docs/` for Auth, Family, Chat, AI, Admin, and Data.
- [x] **Architecture Design**: Defined DDD layers, gRPC communication, and Go microservices.
- [x] **Technical Solutions**: Documented tree snapshot caching, Vietnamese kinship logic, and AI context injection.
- [x] **Super Admin Strategy**: Defined privacy-first support flows and concierge onboarding.

## Phase 1: Baseline Infrastructure (CORE DONE)
- [x] **Flutter Architecture**: Melos workspace initialized with `user_app`, `admin_app`, and `shared_package`.
- [x] **Firebase Hosting**: Multi-site configuration for `dev`, `stg`, and `prod`.
- [x] **Deployment Automation**: Unified `deploy.sh` for multi-env builds.
- [x] **Local Environment**: Multi-env config for Go/Flutter & Emulator setup.

## Phase 2: Core Backend - `familytree_go` (IN PROGRESS)
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
    - [x] **Repo**: `LogRepository` (Postgres).
    - [x] **Testing**: Middleware unit tests.
- [x] **Feature: Family (Core Logic)**:
    - [x] **Service**: `CreateFamily`, `GetFamily`, `UpdateMember`, `GetTree`, `JoinFamily`.
    - [x] **Schema**: Many-to-many access via `family_access`.
    - [x] **Logic**: Kinship calculation engine. (Basic levels implemented)
    - [x] **Testing**: JoinFamily and Access Control unit tests.

## Phase 3: Core Frontend - `familytree_flutter` (IN PROGRESS)
- [x] **Shared Package (`shared_package`)**:
    - [x] **Infrastructure**: gRPC Client (`auth.pbgrpc`, `family.pbgrpc`) & Interceptors.
    - [x] **Auth Repository**: `FirebaseAuthRepository` (Google, Email, Phone).
    - [x] **State Management**: Riverpod providers (`authRepositoryProvider`, `authClientProvider`).
    - [x] **Testing**: Unit tests for Auth Repository (using `mocktail`).
- [ ] **Admin App (`admin_app`)**:
    - [x] **Screens**: Login, Admin Onboarding.
    - [x] **Logic**: Auth Status Check, Routing, Submit Admin Request.
    - [x] **Screens**: Dashboard, Admin Request List.
    - [x] **Logic**: Approve/Reject requests.
    - [x] **Logic**: Invite Users.
- [x] **User App (`user_app`)**:
    - [x] **Screens**: Login, Profile, Family Tree View.
    - [x] **Logic**: Join/Create Family, Update Profile.

## Phase 4: Integration & Features (UPCOMING)
- [x] **Super Admin Onboarding**: Connect Flutter Admin App UI to Go Backend `RequestAdminAccess`.
- [ ] **Family Management**: Visual Tree Builder in Flutter + Graph logic in Go.
- [ ] **Family Invite System**: Interface to generate/manage family invitation tokens.
- [x] **Real-time Chat**: gRPC Streams (backend) + Merged Providers (Flutter).
    - [x] **Features**: History loading, live updates, sender profiles.

## Phase 5: Advanced Features (UPCOMING)
- [ ] **AI Assistant**: Gemini context integration.
- [ ] **Vietnamese Kinship**: Complex addressing logic.

## Verification Tasks (CURRENT)
- [x] backend: `go test ./...` (PASS)
- [x] frontend: `flutter test` in `shared_package` (PASS)
- [x] frontend: `flutter test` in `apps/admin_app` (PASS - Onboarding Flow)
- [x] frontend: `flutter test` in `apps/user_app` (PASS - Smoke Test)
- [x] frontend: `flutter analyze` (PASS)
- [x] backend: Role promotion logic and migrations (PASS)
- [ ] Integration: End-to-end flow (Login -> Sync -> Data Persistence).
- [ ] Phase 4: Integration & Features
    - [x] Super Admin Onboarding integration.
    - [x] Admin Approval Flow (Promote User to Admin).
    - [ ] Family Management: Visual Tree Builder in Flutter + Graph logic in Go.
    - [x] Real-time Chat: gRPC Streams + Flutter UI (User App).
