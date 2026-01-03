# Family Core - Architecture

## DDD Layers

### 1. Domain Layer
- **Value Objects**: `AddressingTitle`, `RelationshipType`, `MarkdownProfile`.
- **Interfaces**: `IFamilyRepository`.

### 2. Infrastructure Layer
- **Implementation**: `PostgresFamilyRepository` (Client calling Go API).
- **Data Sources**:
  - `RemoteDataSource`: gRPC calls to Go backend.
  - `LocalCacheDataSource`: Hive / Persistent storage for tree snapshots.
- **Serialization**: Freezed / Protocol Buffers for structured tree data.

### 2.1 Backend Integration (Go / gRPC)
- **Service**: `FamilyService`
- **RPCs**:
  - `GetFamilyTree(FamilyIdRequest) returns (FamilyTreeResponse)`: Returns current snapshot. Supports `if_version_matches` logic for caching.
  - `CreateInvitation(InviteRequest) returns (InviteResponse)`: Creates member-bound invitation.
  - `ActAsMember(ActRequest) returns (MemberResponse)`: Links current user to a member node.
- **Protobuf**: `family_core.proto`

### 3. Application Layer
- **Services**: `FamilyTreeManager`, `InvitationCoordinator`, `KinshipTitleGenerator`.
- **Providers**: `activeFamilyProvider`, `familyMembersProvider`.

### 4. Presentation Layer
- **Components**: 
  - `FamilyTreeCanvas`: Interactive graph.
  - `MemberProfileEditor`: Rich Markdown editor for the "Acting" node.
  - `InviteGenerator`: UI to create invites bound to specific tree nodes.
  - `LandingEmptyState`: Highlighted "Create Family" and "Add Friend" view.
