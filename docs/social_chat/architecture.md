# Social & Chat - Architecture

## DDD Layers

### 1. Domain Layer
- **Entities**: `Contact`, `ChatMessage`, `Conversation`.
- **Value Objects**: `MessageContent`, `StorageQuota`.
- **Interfaces**: `IChatRepository`, `IFriendRepository`, `ICallService`.

### 2. Data Layer
- **Implementations**:
  - `PostgresFriendRepository`: Manages requests and friend lists.
  - `RTDBChatRepository`: Handles active message delivery.
  - `PostgresHistoryRepository`: Fetches historical messages.
  - `FirebaseStorageService` (with quota logic).
  - `GoWebRTCService`: Connects to Go signaling server via WebSockets.

### 2.1 Backend Integration (Go / gRPC)
- **Signaling Server**: `ws://api.familytree.app/v1/calls/signal` (Maintaining WebSocket for WebRTC).
- **Service**: `ChatHistoryService`
- **RPCs**:
  - `GetChatHistory(HistoryRequest) returns (HistoryResponse)`: Unary or Server Streaming for loading archives.
- **Protobuf**: `chat.proto`

### 3. App Layer
- **Services**: `ChatManager`, `CallController`.
- **Providers**: `activeConversationProvider`, `messageListProvider`.

### 4. View Layer
- **Components**:
  - `SearchUserScreen`: Search by Email/ID.
  - `FriendRequestList`: Manage incoming/outgoing requests.
  - `MessageThread`: Handles lazy-loading logic.
  - `MediaPicker`: Handles image compression and quota checks.
  - `CallOverlay`: Manages video stream UI.
