# Localization Workflow

This document outlines the strict rules for updating language files in the Family Tree project.

## Rules

1.  **Update English (`app_en.arb`) First**
    - Add the new translation key and value to `d:\Code\FamilyTree\source\familytree_flutter\apps\user_app\lib\l10n\app_en.arb`.
    - Include any necessary metadata (e.g., description) in the `@key` object.

2.  **Update Vietnamese (`app_vi.arb`) Immediately**
    - Add the *same* key and its Vietnamese translation to `d:\Code\FamilyTree\source\familytree_flutter\apps\user_app\lib\l10n\app_vi.arb`.
    - **CRITICAL**: The structure must be identical.
    - You MUST add an empty metadata object (`@key: {}`) for the key in `app_vi.arb` to match the line count of `app_en.arb`.

3.  **Verify Line Count**
    - Ensure that both files have the same number of lines and consistent formatting.

## Example

**app_en.arb**:
```json
    "newKey": "New Value",
    "@newKey": {}
```

**app_vi.arb**:
```json
    "newKey": "Giá trị mới",
    "@newKey": {}
```
