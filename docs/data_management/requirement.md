# Data Management - Requirements

## Overview
Enable bulk management of family data to facilitate migrating existing records into the app.

## Functional Requirements
- **CSV Export**: Current family structure can be downloaded as a CSV file.
- **CSV Import**:
  - Ability to upload a CSV file to add or update multiple members at once.
    - **User Mapping Awareness (Blocking/Warnings)**: 
      - **Blocking Error**: If a member node is already linked to an active user (acted user) but is **missing** from the new import CSV, the import is INVALID and cannot proceed.
      - **Warning**: If a member node is NOT linked to any user and is missing from the import, display a **Warning**.
    - **Confirmation List**: 
      - All warnings (e.g., deletions of unlinked members) must be presented in a list.
      - Each item must be explicitly confirmed/checked by the Admin.
      - Import only proceeds to preview/execution once the entire list is confirmed.
    - Check for logical errors (e.g., child born before parent).
  - **Preview & Diff Step**:
    - Show a visual comparison between CSV data and existing Family Tree data.
    - **Highlight Differences**: New members, updated fields (e.g., phone change), and relationship shifts must be visually distinct in a "Draft Tree" view.
    - **Confirm Action**: Import only proceeds after user explicitly approves the highlighted changes.
- **Format**: Follow the template provided in `docs/Gia Đình Năm Cảnh - Thành viên gia đình.csv`.
- **Permissions**: Only Family Admins can perform bulk import/export.
