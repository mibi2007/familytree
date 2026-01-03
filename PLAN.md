# PLAN.md - Family Tree Chat Roadmap

## Phase 1: Infrastructure & Authentication
- [x] Initialize Melos workspace in `familytree_flutter`.
- [x] Configure Dev, Stg, Prod environments with Flutter entry points.
- [ ] Setup Firebase CLI with 3 project targets (Pending Firebase project creation).
- [ ] Implement `shared_package` for common themes and basic UI components.
- [/] Implement Authentication (Email/Google) in both User and Admin apps.
    - [x] Define Auth Domain Entities and Repositories.
    - [ ] Implement Firebase Auth Repository.

## Phase 2: Core Chat Features
- [ ] Implement 1-on-1 Chat.
- [ ] Implement Group Chat functionality.
- [ ] Image upload/sharing using Firebase Storage.
- [ ] Real-time updates with Firestore.

## Phase 3: AI Family Assistant (@family)
- [ ] Integrate Google AI (Gemini) using GenUI.
- [ ] Implement context-aware prompting for family-related knowledge.
- [ ] Setup specialized AI chat interface.

## Phase 4: Family Tree Visualization
- [ ] Design Family Tree data model (Parent-Child relationships).
- [ ] Create interactive Family Tree visualization component.
- [ ] Integrate Family Tree with AI (ask AI to "show me the tree").

## Phase 5: Admin & Management
- [ ] Admin app: Manage family members, roles, and tree structure.
- [ ] Dashboard for family activity overview.
