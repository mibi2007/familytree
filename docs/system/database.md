# Database Infrastructure

## Overview
The project uses **PostgreSQL** as the primary relational database for persistent metadata, family structure, and user relationships.

## Deployment Architecture
- **Infrastructure Strategy**: **PostgreSQL runs inside Docker Compose on each environment's VM** (co-located with the Go backend and Caddy).
  - `dev` environment → `familytree-dev-server` VM (GCP project: `mibi-family-tree-dev`)
  - `prod` environment → `familytree-prod-server` VM (GCP project: `mibi-family-tree-prod`)
- **Database per environment**:
  - Dev DB: configured via `familytree_go/.env.dev` (`POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD`)
  - Prod DB: configured via `familytree_go/.env.prod`
- **No shared/central DB VM** — the old `familytree-db-all` GCP project is no longer used.

## Connection
- Database is accessed internally within Docker Compose via the service name `db` on port `5432`.
- Connection string format: `postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@db:5432/${POSTGRES_DB}?sslmode=disable`
- External access is **not exposed** — PostgreSQL port is not published to the host.

## Maintenance & Backups
- **Strategy**: Automated and Manual triggers.
- **Storage**: **Google Cloud Storage (GCS)** buckets.
- **Tools**: `pg_dump` for backup, `pg_restore` for recovery.

### Backup Workflow
1. **Trigger**:
   - **Automated**: Cron job on the VM or Cloud Scheduler via Go endpoint.
   - **Manual**: Triggered from **Admin App** dashboard.
2. **Process**:
   - Go Backend service invokes `pg_dump`.
   - Compresses the output (e.g., `.tar.gz`).
   - Uploads to GCS Bucket: `gs://familytree-backups/{env}/{timestamp}.tar.gz`.

### Schema Migrations
- **Tool**: [Goose](https://github.com/pressly/goose) (Go-native migration tool).
- **Execution**:
  - Migrations should be run **manually via the terminal** to ensure control and visibility.
  - The Admin UI does **not** auto-run migrations.
- **Support**:
  - **Admin App**: Displays the current database schema version and the expected version.
  - **Command Helper**: Provides the exact copy-pasteable `goose` command for the admin to run on the server/VM (e.g., `goose postgres "user=... dbname=..." up`).

### Restore Strategies
- **Concept**: Restoring is a sensitive, potentially destructive operation and is **NOT** performed via the Admin UI.
- **Admin App Role**:
  - Displays list of backup artifacts from GCS.
  - Allows **Delete** of old backups.
  - Shows details (Version, Date, Size).
- **Execution**:
  - Restoration is performed manually by a System Administrator.
  1. **Download**: Admin pulls the specific `.tar.gz` from GCS.
  2. **Restore**: `pg_restore` is run against the Postgres instance via the terminal.
  3. **Migrate**: `goose up` is run manually to align schema.
