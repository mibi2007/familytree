# Data Management - Technical Solution

## Bulk Import Validation Flow
```mermaid
sequenceDiagram
    participant Admin
    participant App
    participant Postgres

    Note over Admin, Postgres: CSV Upload & Parsing
    Admin->>App: Upload CSV
    App->>App: Parse to Draft Model
    App->>Postgres: Fetch Current Family Structure (Live Model)

    Note over Admin, Postgres: Strict Validation Logic
    App->>App: Compare Live vs Draft

    alt Blocking Error: Linked Member Missing
        Note right of App: A member with user_id exists in Live but not in Draft
        App-->>Admin: Show ERROR: "Active member [Name] missing from CSV"
        Admin->>App: Fix CSV & Re-upload
    else Warnings: Unlinked Members Missing
        Note right of App: Unlinked members missing in Draft
        App->>App: Generate Confirmation List
        App-->>Admin: Show Warning List (Checklist)
        Admin->>App: Confirm each deletion in list
        App->>Admin: Enable [Proceed to Preview]
    end

    Note over Admin, Postgres: Final Review
    Admin->>App: Click [Proceed to Preview]
    App->>Admin: Show Draft Tree (Color-coded Diff)
    Admin->>App: Click [Commit Changes]
    App->>Postgres: Batched Write Updates
    Postgres-->>Admin: Success
```

## Mapping Schema (CSV to DB)
```mermaid
erDiagram
    CSV_Row ||--|| family_members : "updates/creates"
    CSV_Row {
        string MemberID PK "Matches family_members.id"
        string FullName
        string UserID "Matches users.id (Acting Link)"
        string ParentID
        string SpouseID
    }
    
    family_members ||--o| users : "acts_as"
```

## Serialization
- **Format**: Comma Separated Values (CSV).
- **Encoding**: UTF-8 (Required for Vietnamese character support).

## Processing & Preview Flow
1. **Parsing & Validation**:
   - Parse CSV into a `DraftFamilyModel`.
   - **Link Check**: Identify nodes in `LiveFamilyModel` where `user_id IS NOT NULL`.
   - **Strict Validation**:
     - `INVALID`: If a node from `LiveFamilyModel` with a `user_id` is missing in `DraftFamilyModel` -> Stop process, show error.
     - `WARNING`: If a node from `LiveFamilyModel` with `user_id IS NULL` is missing in `DraftFamilyModel` -> Add to confirmation list.
2. **Confirmation Interface**:
   - Display a list of all `WARNING` items.
   - Admin must toggle each item to `confirmed`.
   - The "Proceed to Preview" button is enabled only when `all(warnings.confirmed)`.
3. **Diffing Algorithm**:
   - Categorize nodes: `Identical`, `Modified`, `New`, `DeletionWarning`.
4. **Visualization (Preview Mode)**:
   - Use the Family Tree renderer in "Preview State".
   - Color coding:
     - **Green Overlay**: New nodes/branches.
     - **Yellow Overlay**: Updated fields in existing nodes.
     - **Cyan/Blue Outline**: Member node linked to a different User.
     - **Red/Error**: Invalid mapping attempts.
     - **Strikethrough/Grey**: Confirmed deletions.
5. **Execution**:
   - On final approval, trigger batched writes to Postgres.

## Parent-Child Linking
- Import will attempt to link children to parents using the `ParentID` or `ParentName` columns provided in the CSV.
- If a parent isn't in the system, create a placeholder node.
