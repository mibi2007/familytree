# Phase 6 Inception Plan (AIDD)

## Scope
This plan structures Phase 6 from `PLAN.md`:
1. **AI Assistant** (Gemini + Genkit)
2. **Vietnamese Kinship** (culturally accurate addressing)

## Inputs
- `PLAN.md` (Phase 6)
- `docs/ai_assistant/requirement.md`
- `docs/ai_assistant/architecture.md`
- `docs/ai_assistant/technical.md`
- DDD conventions in `SKILL.md`

---

## AI Assistant Packages

### AI-1 — Genkit/Gemini Foundation
- **Objective**: Establish backend AI module and bootstrap Gemini.
- **Key areas**:
  - `familytree_go/internal/features/ai/domain/*`
  - `familytree_go/internal/features/ai/app/*`
  - `familytree_go/internal/features/ai/interfaces/grpc/*`
  - `familytree_go/cmd/server/main.go` + config/env
- **Acceptance criteria**:
  - [x] DDD module scaffold exists and is wired through server bootstrap and interface readiness.
  - [x] Gemini initialization is env-driven and constructs Genkit with the Google Generative AI plugin only when `AI_ENABLED=true`.
  - [x] Missing API key behavior is defined and unit-tested: disabled AI starts without a key; enabled AI fails startup validation.
- **Gate**: **Permission** (API key/cost/policy approval) — **Closed** for foundation construction; no live Gemini request was made and no secret was added to the repository.
- **Construction status**: **Complete** (2026-08-31).
- **Evidence**:
  - `familytree_go/internal/features/ai/data/genkit/provider.go` owns runtime initialization.
  - `familytree_go/cmd/server/main.go` initializes the module from environment-backed config.
  - `go test ./internal/features/ai/... ./internal/config` passes.

### AI-2 — Context Injection Pipeline
- **Objective**: Inject acting-member and family-aware context for each AI request.
- **Key areas**:
  - Context builder service in AI app layer
  - Family snapshot ingestion (`family_tree_snapshots`)
  - Title-to-member mapping integration
- **Acceptance criteria**:
  - [x] Context includes `acting_member_id`, role-aware history, and tree snapshot summary.
  - [x] Privacy defaults use one explicitly selected family and only that family's relevant bounded chat history.
  - [x] Fallback behavior for a missing snapshot is unit-tested and produces a safe explanatory summary.
  - [x] Title-to-member mapping is integrated behind a domain port; an empty mapping is used until KIN-3 supplies cultural mappings.
- **Gate**: **Decision** (privacy/knowledge boundary defaults) — **Closed**. Project owner selected option 2: selected family plus relevant chats only.
- **Construction status**: **Complete** (2026-08-31).
- **Evidence**:
  - `familytree_go/internal/features/ai/app/context_builder.go` enforces selected-family and acting-member inputs.
  - `familytree_go/internal/features/ai/data/postgres/context_repository.go` reads one selected snapshot and bounded family chat history with explicit roles.
  - `go test ./internal/features/ai/... ./cmd/server` passes.

### AI-3 — gRPC Contract + Handler
- **Objective**: Expose AI APIs over protobuf/gRPC.
- **Key areas**:
  - `proto/ai/v1/*.proto`
  - Generated Go/Dart stubs
  - Backend handler registration
- **Acceptance criteria**:
  - [x] Contract supports unary `Ask` and server-streaming `AskStream` flows.
  - [x] Handler requires interceptor-provided authentication, verifies selected-family access, and calls the AI application service.
  - [x] Contract, application, infrastructure, and handler tests pass.
  - [x] Go and Dart stubs are generated and the backend service is registered.
- **Gate**: None.
- **Construction status**: **Complete** (2026-08-31).
- **Evidence**:
  - `proto/ai/v1/ai.proto` defines unary and streaming-ready APIs.
  - `familytree_go/internal/features/ai/interfaces/grpc/ai_handler.go` authenticates and maps stable gRPC status errors.
  - `familytree_go/internal/features/ai/app/assistant_service.go` authorizes family membership before context/model access.
  - `bash scripts/generate_go_protos.sh` and `bash scripts/generate_dart_protos.sh` pass.
  - `go test ./internal/features/ai/... ./proto/ai/v1 ./cmd/server` passes.

### AI-4 — Flutter Integration (Private + Mention Entry)
- **Objective**: Enable AI usage from user chat UX.
- **Key areas**:
  - Shared package AI client/provider
  - User app chat UI entry points
  - Mention trigger path (`@family`) scope
- **Acceptance criteria**:
  - [x] User can ask and receive response with loading/error handling.
  - [x] Group `@family` mention flow is implemented.
  - [x] Basic signal and widget tests cover private and group entry paths.
- **Gate**: **Decision closed** (release scope: private plus group `@family`).
- **Construction status**: **Complete** (2026-09-30).
- **Evidence**:
  - `familytree_flutter/packages/shared_package/lib/app/signals/ai_signals.dart` provides authenticated request state and mention detection.
  - `familytree_flutter/apps/user_app/lib/features/ai/view/ai_assistant_page.dart` provides private chat context selection, loading, error, and response UX.
  - `familytree_flutter/apps/user_app/lib/features/chat/view/chat_page.dart` invokes and displays group `@family` replies.
  - Targeted private assistant, group mention, and shared AI signal tests pass.

### AI-5 — Behavior Controls + QA Readiness
- **Objective**: Apply global/family behavior instructions and produce QA evidence.
- **Key areas**:
  - Prompt assembly using global + family instructions
  - Logging/observability for AI outcomes
  - QA checklist + evidence notes
- **Acceptance criteria**:
  - Prompt composition follows hierarchy from technical doc.
  - Logs avoid sensitive payload leakage.
  - QA evidence covers happy path + failure path.
- **Gate**: **Permission** (safety/compliance sign-off).

---

## Vietnamese Kinship Packages

### KIN-1 — Domain Model + Rule Catalog
- **Objective**: Define kinship domain language and baseline rules.
- **Key areas**:
  - `familytree_go/internal/features/family/domain/*kinship*`
  - Supporting rule notes in docs
- **Acceptance criteria**:
  - [x] Model captures generation, side (`nội`/`ngoại`), gender, and age order.
  - [x] Baseline title set includes `Bác`, `Chú`, `Cô`, `Dì`, `Ông/Bà nội`, `Ông/Bà ngoại`.
  - [x] Rule catalog is reviewable by product/domain owner.
- **Gate**: **Decision closed** (common northern-Vietnamese baseline; regional overrides are future configuration).
- **Construction status**: **Complete** (2026-09-30).

### KIN-2 — Relationship Calculator Engine
- **Objective**: Implement deterministic kinship calculation.
- **Key areas**:
  - Family app-layer kinship service
  - Relationship traversal/LCA utilities
- **Acceptance criteria**:
  - [x] Resolves direct + uncle/aunt + grandparent relations.
  - [x] Side and age-sensitive variants are test-covered.
  - [x] Same inputs produce same outputs.
- **Gate**: None.
- **Construction status**: **Complete** (2026-09-30).

### KIN-3 — Spouse-side + Acting-member Mapping
- **Objective**: Support spouse-side relations and AI disambiguation mapping.
- **Key areas**:
  - Kinship calculator extensions
  - Mapping generator consumed by AI context builder
- **Acceptance criteria**:
  - [x] Spouse-side relations return valid titles.
  - [x] Mapping supports phrase-to-member resolution in AI prompts.
  - [x] Ambiguous cases have documented fallback behavior.
- **Gate**: **Question** (resolve ambiguous cultural variants).
- **Construction status**: **Complete pending regional-policy review** (2026-09-30).

### KIN-4 — API + UX Exposure + QA
- **Objective**: Expose kinship outputs via API and user-facing flows.
- **Key areas**:
  - Family/AI API response models
  - Flutter UI points for suggested addressing
  - Scenario-based test dataset
- **Acceptance criteria**:
  - [x] API returns title plus relationship, generation, side, gender, age-order, spouse-path, and ambiguity metadata.
  - [x] UI displays suggested addressing from a selected acting member on family member details.
  - [x] Regression tests include spouse-side, ambiguity, access-control, and Flutter display scenarios.
- **Gate**: None.
- **Construction status**: **Complete** (2026-09-30).
- **Evidence**:
  - `FamilyService.GetKinship` is generated for Go and Dart and enforces authenticated family membership.
  - Family tree UX exposes a `Show titles as` selector and structured kinship result.
  - Scoped backend packages, 37 shared-package tests, and 28 user-app tests pass.

---

## Gate Queue
- `AI-1`: **Permission gate closed** for foundation construction; runtime calls still require an operator-provided key and incur Gemini policy/cost considerations.
- `AI-2`: **Decision gate closed** — selected family plus relevant chats only.
- `AI-3`: **Complete** — no human gate was required.
- `AI-4`: **Decision gate closed** — release private assistant plus group `@family` mentions.
- `KIN-1`: **Decision gate approved** for construction; canonical title policy remains the package acceptance boundary.

## Decision Log

| Date | Package ID | Gate Type | Decision/Answer | Owner | Status |
|---|---|---|---|---|---|
| 2026-08-31 | AI-1 | Permission | Foundation construction approved; keep AI disabled by default, require an environment-provided Gemini key when enabled, and make no live model call during bootstrap/tests. | Project owner | Closed |
| 2026-08-31 | KIN-1 | Decision | Inception/construction approved as recorded in `PLAN.md`. | Project owner | Closed |
| 2026-08-31 | AI-2 | Decision | Use one explicitly selected family and only that family's relevant bounded chat history by default (option 2). | Project owner | Closed |
| 2026-09-30 | AI-4 | Decision | Release both the private assistant and group `@family` mention entry paths. | Project owner | Closed |
