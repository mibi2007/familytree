# Events - Architecture

## DDD Layers

### 1. Domain Layer
- **Entities**: `FamilyEvent`.
- **Failures**: `EventFailure` (DuplicateEvent, InvalidDate, etc.).
- **Value Objects**: `EventType`, `EventSchedule`.
- **Interfaces**: `IEventRepository`.

### 2. Infrastructure Layer
- **Implementation**: `PostgresEventRepository`.
- **Data Source**: PostgreSQL API.

### 3. Application Layer
- **Providers**: `familyEventsProvider(familyId)`, `eventTimelineProvider(eventId)`.
- **Use Cases**: `CreateEventUseCase`, `LinkTimelineToEventUseCase`.

### 4. Presentation Layer
- **Widgets**: 
  - `EventCalendarView`: Monthly/List view of family events.
  - `EventDetailSheet`: Shows event info + linked timeline history.
- **Pages**: `EventsDashboardPage`.
