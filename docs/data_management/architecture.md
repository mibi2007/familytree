# Data Management - Architecture

## DDD Layers

### 1. Domain Layer
- **Entities**: `ImportSummary`, `DataRow`.
- **Interfaces**: `IDataTransformer`.

### 2. Data Layer
- **Implementations**: `CsvTransformerService`.
- **File Handling**: Integration with local storage/system pickers.

### 3. App Layer
- **Processors**: `BulkImportUseCase`.
- **State**: `ImportProgressProvider`.

### 4. View Layer
- **UI**:
  - `ImportWorkflowStepper`: Manages Upload -> Validate -> Preview -> Confirm.
  - `DraftTreeView`: A special instance of the Family Tree that renders diffs/highlights.
  - `CSVMappingScreen`: Match CSV columns to app fields.

### 5. Backup & Recovery Domain
- **Domain Layer**:
  - **Entities**: `BackupArtifact` (id, timestamp, size_bytes, gcs_path).
  - **Interfaces**: `IBackupservice` (listBackups, triggerBackup, deleteBackup).
- **Data Layer**:
  - **Implementation**: `GCSBackupService`.
  - **Storage**: Google Cloud Storage SDK.
- **View Layer**:
  - **Admin UI**: `BackupDashboard` (List, Create Backup, Delete Backup).
