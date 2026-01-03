# Timeline - Architecture

## DDD Layers

### 1. Domain Layer
- **Entities**: `TimelinePost`, `TimelineMedia`, `TimelineTag`.
- **Value Objects**: `PostContent`, `EventDate`.
- **Interfaces**: `ITimelineRepository`.

### 2. Infrastructure Layer
- **Implementation**: `PostgresTimelineRepository`.
- **Data Source**: PostgreSQL API.

### 3. Application Layer
- **Providers**: `timelineProvider(familyId)`, `memoriesProvider`.
- **Use Cases**: `CreatePostUseCase`, `GetMemoriesUseCase`, `TagMemberUseCase`.

### 4. Presentation Layer
- **Widgets**: 
  - `TimelineList`: Chronological list of posts.
  - `MemoryCard`: "On This Day" highlight widget.
  - `PostComposer`: Markdown editor with image picker and tagger.
- **Pages**: `FamilyTimelinePage`, `MemberTimelinePage`.
