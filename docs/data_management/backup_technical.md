
## Backup & Restore Technical Flow
```mermaid
sequenceDiagram
    participant Admin
    participant GoService
    participant Postgres
    participant GCS

    Note over Admin, GCS: Manual Backup Trigger
    Admin->>GoService: Request: CreateBackup()
    GoService->>Postgres: Exec: pg_dump > /tmp/backup.sql
    Postgres-->>GoService: Stream SQL Dump
    GoService->>GoService: Gzip Compress
    GoService->>GCS: UploadObject("backups/{date}.tar.gz")
    GCS-->>GoService: Success (URL)
    GoService-->>Admin: Backup Created Successfully

    Note over Admin, GCS: Delete Process
    Admin->>GoService: Request: DeleteBackup(backup_id)
    GoService->>GCS: DeleteObject(backup_id)
    GCS-->>GoService: Success
    GoService-->>Admin: Backup Deleted
```

### Security & Permissions
- **Service Account**: Go Backend uses a GCP Service Account with `Storage Object Admin` role.
- **Encryption**: GCS Server-Side Encryption (default) + Transfer via HTTPS.
### APIs & Prerequisites
- **GCP Project**: `familytree-db-all` (Hosts VM + Backups).
- **Required APIs**:
  - `compute.googleapis.com` (For VM Management).
  - `storage.googleapis.com` (Cloud Storage API for Backups).
- **Buckets**:
  - `gs://familytree-backups-prod`
  - `gs://familytree-backups-dev`
