---
description: Apply AIDD for a feature from inception through construction, QA evidence, and roadmap updates
---

Use this workflow whenever starting a new feature or major enhancement.

## 1) Inception Artifacts
- [ ] Link source docs (e.g., `PLAN.md`, `docs/**/requirement.md`).
- [ ] Define package IDs (`AI-*`, `KIN-*`, etc.).
- [ ] For each package, record:
  - objective
  - key files/areas (DDD-aligned)
  - acceptance criteria
  - required gate type (if any)

## 2) Human Gate Approval
- [ ] Trigger gate before coding when required:
  - **Permission**: risk/destructive/cost-sensitive actions
  - **Question**: unresolved requirement
  - **Decision**: product/architecture choice
- [ ] Record outcomes in a decision log.

## 3) Construction
- [ ] Implement one package at a time.
- [ ] Keep scope aligned with approved inception artifacts.
- [ ] Update related docs/contracts/tests in same slice.

## 4) Testing + QA Evidence
- [ ] Run backend checks:
  - `cd familytree_go && go test ./...`
- [ ] Run frontend checks:
  - `cd familytree_flutter/packages/shared_package && flutter test`
  - `cd familytree_flutter/apps/admin_app && flutter test`
  - `cd familytree_flutter/apps/user_app && flutter test`
  - `cd familytree_flutter && flutter analyze`
- [ ] Capture evidence: passed checks, failed checks, known risks.

## 5) Update Roadmap
- [ ] Update `PLAN.md` with package progress.
- [ ] Mark completed items and pending gates.
- [ ] Keep wording tied to acceptance criteria.

## Templates

### Acceptance Criteria

```md
- [ ] AC-1: <observable behavior>
- [ ] AC-2: <testable constraint>
- [ ] AC-3: <edge/error behavior>
```

### Decision Log

| Date | Package ID | Gate Type | Decision/Answer | Owner | Status |
|---|---|---|---|---|---|
| YYYY-MM-DD | AI-1 | Permission | Approved dev-only Gemini key usage | <owner> | Closed |
