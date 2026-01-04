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
- [ ] **Cloud Connection**: Run `flutterfire configure` for all 3 environments.

## Phase 2: Backend & Data Foundations (UPCOMING)
- [ ] **Contract Definition**: Implement `.proto` files in `familytree_go` for core gRPC services.
- [ ] **Database Setup**: Create Postgres migration scripts (Families, Members, Relationships, Secure Tokens).
- [ ] **Backend Baseline**: Initialize Go gRPC server with JWT middleware and Audit interceptors.
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
