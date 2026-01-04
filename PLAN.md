# Family Tree Chat - Project Roadmap

## Phase 0: Conceptualization & Design (DONE)
- [x] **Documentation System**: Established `docs/` for Auth, Family, Chat, AI, Admin, and Data.
- [x] **Architecture Design**: Defined DDD layers, gRPC communication, and Go microservices.
- [x] **Technical Solutions**: Documented tree snapshot caching, Vietnamese kinship logic, and AI context injection.
- [x] **Super Admin Strategy**: Defined privacy-first support flows and concierge onboarding.

## Phase 1: Baseline Infrastructure (CORE DONE)
- [x] **Flutter Architecture**: Melos workspace initialized with `user_app`, `admin_app`, and `shared_package`.
- [x] **Firebase Hosting**: Multi-site configuration for `dev`, `stg`, and `prod` with precise app-to-folder mapping.
- [x] **Deployment Automation**: Unified `deploy.sh` for multi-env builds and gated artifact staging.
- [x] **Git Remote Integration**: Linked and synced to `github:mibi2007/familytree`.
- [x] **Exclusion Strategy**: Localized `.gitignore` and `.gitkeep` setup for clean repository management.
- [x] **Cloud Connection**: Ran `flutterfire configure` for `dev` and `prod` in both apps, organized into `lib/core/config/`.

## Phase 2: Backend & Data Foundations (CORE DONE)
- [x] **Contract Definition**: Implemented `.proto` files for Auth, Family, and Common services.
- [x] **Database Setup**: Created initial SQL migration (`0001_initial_schema.sql`).
- [x] **Backend Baseline**: Initialized Go module, gRPC server, and service skeletons.
- [x] **Token System**: Implement Secure Token generation and auto-cleanup logic.
- [x] **Local Environment**: Multi-env config for Go/Flutter & Emulator setup (Verified).

## Phase 3: Identity & Profile (DONE)
- [x] **Auth Flow**: Sign Up, Sign In (Email/Phone/Google) for both Apps.
- [x] **Profile Sync**: User Profile CRUD with Firebase/Postgres sync.
- [x] **Cross-App Testing**: Verify consistent profile state across User/Admin apps.

## Phase 4: Super Admin Setup (UPCOMING)
- [ ] **Admin Onboarding**: Invite token flow for elevated access.
- [ ] **Admin Directory**: accent-neutral search across users/families.
- [ ] **Access Controls**: Approval dashboard for support agent requests.

## Phase 5: Social & Communication (UPCOMING)
- [ ] **Friendship**: Add friend flow with real-time notifications.
- [ ] **Real-time Chat**: Messaging with Interactive Mentions and Rich Media.
- [ ] **Calling**: Voice/Video integration (e.g., via Stream or WebRTC).

## Phase 6: Family Ecosystem (UPCOMING)
- [ ] **Family Management**: Creation, Member CRUD, and Tree reindexing.
- [ ] **Interactive Tree**: Kinship logic and hierarchical visualization.
- [ ] **AI Assistant**: Gemini integration with Family Snapshot context.

## Verification & Launch
- [ ] Integration Testing (Go <> Flutter).
- [ ] Multi-environment Deployment Validation.
- [ ] Super Admin Handover.
