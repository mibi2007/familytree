# Data Management - Architecture

## DDD Layers

### 1. Domain Layer
- **Entities**: `ImportSummary`, `DataRow`.
- **Interfaces**: `IDataTransformer`.

### 2. Infrastructure Layer
- **Implementations**: `CsvTransformerService`.
- **File Handling**: Integration with local storage/system pickers.

### 3. Application Layer
- **Processors**: `BulkImportUseCase`.
- **State**: `ImportProgressProvider`.

### 4. Presentation Layer
- **UI**:
  - `ImportWorkflowStepper`: Manages Upload -> Validate -> Preview -> Confirm.
  - `DraftTreeView`: A special instance of the Family Tree that renders diffs/highlights.
  - `CSVMappingScreen`: Match CSV columns to app fields.
