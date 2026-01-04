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

## Phase 2: Backend & Data Foundations (IN PROGRESS)
- [x] **Contract Definition**: Implemented `.proto` files for Auth, Family, and Common services.
- [x] **Database Setup**: Created initial SQL migration (`0001_initial_schema.sql`).
- [/] **Backend Baseline**: Initializing Go module, gRPC server, and service skeletons.
- [ ] **Token System**: Implement Secure Token generation and auto-cleanup logic.

## Phase 3: Core Implementation (UPCOMING)
- [ ] **Authentication**: Implement shared `AuthRepository` with Google/Email/Phone (User) and Google-only (Admin).
- [ ] **Family Core**: implement Member CRUD, Tree reindexing, and Snapshot caching.
- [ ] **Social & Chat**: Implement real-time messaging with Interactive Mentions and Rich Media.
- [ ] **Super Admin Console**: Build the User Directory with accent-neutral search and Approval Dashboard.

## Phase 4: AI & Advanced UX (UPCOMING)
- [ ] **AI Assistant**: Integrate Gemini with Snapshot context and Relative Pronunciation awareness.
- [ ] **GenUI Implementation**: Build the engine for interactive widgets within the Chat UI.
- [ ] **Timeline & Events**: Automate family milestones and shared calendars.

## Verification & Launch
- [ ] Integration Testing (Go <> Flutter).
- [ ] Multi-environment Deployment Validation.
- [ ] Super Admin Handover.
