# AIDD Enablement (Family Tree)

This project applies an **AI-Driven Development (AIDD)** loop so we can move fast while keeping quality and decision control.

## AIDD Loop

### 1) Inception (decide what and why)
For each feature, complete:
- **Requirements Definition**: clarify user value and constraints.
- **Task Creation**: split into small, testable work packages.
- **Application Design**: map impacts across DDD layers (Domain, Infrastructure, Application, Presentation).

### 2) Construction (build and verify)
Implement package-by-package:
- **Coding**: small vertical slices.
- **Testing**: targeted tests first, then broader checks.
- **QA**: evidence-based review (pass/fail, risks, unresolved issues).

### 3) Human-in-the-loop gates
Pause AI execution for explicit approval when needed:
- **Permission**: destructive/high-risk changes (schema, secrets, production risk).
- **Question**: ambiguous requirements needing product clarification.
- **Decision**: architecture/UX tradeoff selection.

## Zed Profile Mapping

| Profile | Intended usage |
|---|---|
| `Ask` | Plan mode (Inception only, no code changes) |
| `Write` | Construction mode (implementation + tests + QA evidence) |
| `Minimal` | Lightweight ideation / guidance |

## Validation Commands

```bash
# Backend
cd familytree_go && go test ./...

# Frontend tests
cd familytree_flutter/packages/shared_package && flutter test
cd familytree_flutter/apps/admin_app && flutter test
cd familytree_flutter/apps/user_app && flutter test

# Frontend analysis
cd familytree_flutter && flutter analyze
```

Use `.agent/workflows/run-dev.md` for local runtime setup.

> [!IMPORTANT]
> Do **not** run `flutter run -d web-server` automatically. The user manages the Flutter web server.
