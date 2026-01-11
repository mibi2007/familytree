# Deployment & DevOps

## Environment Strategy
We use a unified build system targeting three environments:
1.  **Dev (`dev`)**: Active development, frequent deploys.
2.  **Staging (`stg`)**: QA and pre-release testing.
3.  **Prod (`prod`)**: Live production system.

## Build Scripts
- **Location**: Root `deploy.sh`.
- **Usage**: `./deploy.sh [service] [environment]`
    - `service`: `web-user`, `web-admin`, `backend`, `firestore`, `functions`.
    - `environment`: `dev`, `stg`, `prod`.

## Frontend Hosting (Firebase)
- **Multi-Site**: Configured in `firebase.json`.
    - User App: `familytree-user-<env>`
    - Admin App: `familytree-admin-<env>`
- **Target Selection**: script uses `firebase target:apply` to switch targets dynamically based on environment.

## Backend Deployment
- **Go Server**: Currently set up for Cloud Run or VM (Dockerized).
- **Dockerfile**: `familytree_go/Dockerfile`.
- **Config**: Environment variables (DB_HOST, FIREBASE_PROJECT_ID) injected at runtime.

## CI/CD (Future)
- **GitHub Actions**:
    - On PR: Run Tests (`go test`, `flutter test`).
    - On Merge to `main`: Deploy to `dev`.
    - On Tag: Deploy to `prod`.
