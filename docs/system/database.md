# Database Infrastructure

## Overview
The project uses **PostgreSQL** as the primary relational database for persistent metadata, family structure, and user relationships.

## Deployment Architecture
- **Infrastructure Strategy**: **Single Shared VM**.
  - **Project ID**: `familytree-db-all` (GCP).
  - **Machine Type**: `e2-medium` (or higher) to support concurrent workloads.
- **Databases**:
  - `family_tree_prod` (Owner: `prod_user`).
  - `family_tree_dev` (Owner: `dev_user`).
- **Access Management**:
  - **Caddy** manages ingress for both environments.
  - Connection strings distinguish environments via **Database Name** and **Credentials**.

## Connection
- **VM Name**: `familytree-db-main`
- **Zone**: `asia-southeast1-b`
- **External IP**: `34.2.28.4`
- **Port**: `5432` (Postgres Standard)
- **Services Connection**:
    - **Host**: `34.2.28.4` (or Internal IP `10.148.0.2` if within same VPC)
    - **Dev**: User `dev_user`, DB `family_tree_dev`
    - **Prod**: User `prod_user`, DB `family_tree_prod`

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
