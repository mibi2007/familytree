# Design System Requirements

## Overview
The Family Tree application allows for a consistent yet flexible design system across multiple Flutter applications (User App, Admin App). This approach ensures a unified brand identity while allowing specific apps to tailor the experience as needed.

## Architecture: Two-Layer System

We utilize a two-layer design system hierarchy:

### Layer 1: Core Design System (Shared)
*   **Location:** `familytree_flutter/packages/shared_package/lib/view`
*   **Purpose:** Defines the foundational visual identity of the entire platform.
*   **Components:**
    *   **Color Palettes:** dynamic schemes including `familyLight` and `familyDark` themes.
    *   **Typography:** Base text styles, font families, and sizes.
    *   **Shapes & Spacing:** Standard metrics for padding, margins, and borders.
    *   **Widgets:** Reusable, styled widgets (Buttons, Inputs, Cards) that adhere to the core theme.
*   **Important Note:** The file `familytree_flutter/packages/shared_package/lib/view/theme.dart` is **EXPORTED FROM DESIGN TOOLS** and must be treated as **READ-ONLY**. Do not modify it manually; only import and use it.

### Layer 2: Application Override (App Specific)
*   **Location:** Inside each specific application (e.g., `apps/user_app/lib/core/theme`, `apps/admin_app/lib/core/theme`).
*   **Purpose:** Allows for specific deviations or extensions of the core theme to suit the specific context of that app.
*   **Behavior:**
    *   This layer is **optional**. If an app does not strictly require overrides, it should use the Core Design System directly.
    *   Overrides should be minimal and purposeful (e.g., specific branding for the Admin portal vs. the User app).
    *   It inherits from the Core theme and applies `copyWith()` or equivalent mechanisms to modify specific properties.

## Implementation Guidelines

### Color Usage
*   **Strict Rule:** **NEVER** hardcode colors (e.g., `Colors.red`, `Color(0xFF...)`) directly in widget files.
*   **Usage:** ALWAYS use the `Theme.of(context)` or specific theme helper extensions to access colors.
    *   *Correct:* `color: Theme.of(context).colorScheme.primary`
    *   *Incorrect:* `color: Colors.blue`
*   **Extensions:** Use semantic names defined in our theme extensions (e.g., `context.color.warning`, `context.color.success`) if the standard Material `ColorScheme` is insufficient.

### Typography
*   Use `Theme.of(context).textTheme` for all text styles.
*   Avoid manually setting `fontSize` or `fontFamily` in widgets unless implementing a specific, one-off design requirement that cannot be abstracted (which should be rare).

### Spacing & Layout
*   Use standard spacing constants defined in the Shared Package (e.g., `AppSpacing.m`, `AppSpacing.l`) instead of magic numbers.
