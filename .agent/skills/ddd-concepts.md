# Domain Driven Design (DDD)

The project follows a strict 4-layer DDD architecture to ensure high maintainability and testability.

## 4-Layer Architecture
1. **Domain Layer**: 
   - Contains pure business logic, entities, and repository interfaces.
   - Zero dependencies on external frameworks or data sources.
2. **Data Layer**:
   - Implementation of repository interfaces.
   - Handles external systems: PostgreSQL, Firebase, gRPC Clients.
   - Mapping between data models and domain entities.
3. **App Layer**:
   - Orchestrates use cases.
   - Maps between UI requests and domain service calls.
4. **View/Interface Layer**:
   - **Go**: gRPC Handlers, Middleware.
   - **Flutter**: UI Widgets, Riverpod Controllers.
