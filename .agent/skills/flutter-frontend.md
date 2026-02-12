# Flutter Frontend Development

Cross-platform development for User and Admin applications.

## Core Stack
- **Flutter**: UI toolkit using Dart.
- **Signals**: Fine-grained reactive state management (migrating from Riverpod).
- **Riverpod**: Legacy state management (being phased out - see migration plan).
- **Melos**: Monorepo management for multiple apps and shared packages.
- **Freezed & JSON Serializable**: Code generation for type-safe data models and unions.
- **fpdart**: Functional programming primitives for error handling (Either/Option).

## Standards
- **Material 3**: Modern, responsive design system.
- **Shared Package**: Centralized themes, widgets, and gRPC clients to ensure consistency.
- **Multi-Flavor**: Isolated configurations for `dev`, `stg`, and `prod`.

## State Management Migration
**Current Status**: Migrating from Riverpod to Signals (Phase 1-10)
- **Completed**: Infrastructure (Phase 1), Data Layer (Phase 2)
- **In Progress**: Auth Feature (Phase 3)
- **See**: `docs/migration/RIVERPOD_TO_SIGNALS_MIGRATION_PLAN.md`

