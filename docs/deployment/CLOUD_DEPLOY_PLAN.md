# Cloud Development Deployment Plan

This document outlines the strategy for deploying the `familytree_go` backend and PostgreSQL database to a cloud development environment.

## Objective
Deploy the Go backend and PostgreSQL database to a cloud server to allow the Flutter apps (web/mobile) to connect to a live backend environment instead of localhost.

## Current State
- **Frontend**: Deployed via Firebase Hosting (Dev/Stg/Prod).
- **Backend (Go)**: Running locally.
- **Database (Postgres)**: Running locally via Docker or local install.

## Proposed Strategy: Single VM on Google Cloud Platform (GCP)

Given the project uses Firebase, GCP is the natural choice. For a "Dev Server", we recommend using a single Google Compute Engine (GCE) instance running Docker Compose.

### Architecture
- **Infrastructure**: Google Compute Engine (GCE) VM.
- **Region**: `asia-southeast1` (Singapore, closest to Vietnam).
- **OS**: Ubuntu 22.04 LTS.
- **Runtime**: Docker & Docker Compose.
- **Components**:
  - `familytree-server` (Go Backend Container).
  - `familytree-db` (PostgreSQL Container).
  - `caddy` (Reverse Proxy for HTTPS & Automatic TLS).
- **Domains**:
  - Frontend: `family.binhhm.dev` (Firebase Hosting)
  - Backend: `family-be.binhhm.dev` (GCE VM)

### Deployment Rules
- **Scripting**: Bash scripts (`.sh`) ONLY. Cross-platform support (macOS/Windows).
- **Git**: Build artifacts (`.zip`, `.tar.gz`) are strictly excluded.

### Why this approach?
1.  **Cost Effective**: A single `e2-micro` instance (~$7/month).
2.  **Performance**: Low latency for Vietnam users via `asia-southeast1`.
3.  **Simplicity**: Docker Compose mirrors local dev.

## Implementation Steps

### 1. Containerization (Done)
- [x] Create `Dockerfile` for `familytree_go`.
- [x] Create `docker-compose.yml`.

### 2. Infrastructure Setup (GCP)
- [ ] Create GCE VM `familytree-dev-server` in `asia-southeast1-b`.
- [ ] Reserve static IP.
- [ ] Configure Firewall (HTTP/HTTPS/SSH).
- [ ] **Action**: User updates DNS A record for `family-be.binhhm.dev` to point to the new Static IP.

### 3. Server Configuration
- [ ] Install Docker & Docker Compose (via startup script).
- [ ] Configure Caddy for `family-be.binhhm.dev`.

### 4. Automation
- [ ] `scripts/deploy_backend.sh` (Bash) to package, upload, and restart.

## Next Actions
1.  Run `scripts/setup_gce.sh` to provision the Asia server.
2.  User updates DNS records.
3.  Run `scripts/deploy_backend.sh` to deploy.
