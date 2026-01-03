# AI Assistant (@family) - Architecture

## DDD Layers

### 1. Domain Layer
- **Entities**: `AIPrompt`, `AIRecommendation`, `FamilyContext`.
- **Interfaces**: `IAIAgentService` (generateStream, stopGeneration).

### 2. Infrastructure Layer
- **Implementation**: `GeminiGenUIService`.
- **Context Builders**: 
  - `FamilyTreeContextBuilder`: Extracts structural text from the latest `family_tree_snapshots` blob.
  - `PronunciationContextService`: Generates relative titles-to-IDs map based on acting position.

### 3. Application Layer
- **Providers**: 
  - `aiChatProvider` (auto-disposable state).
  - `aiFocusOptionProvider`: Stores the current session's knowledge boundary (Families/Users).
- **Handlers**: `MentionResponder` (Background service for group @mentions).

### 4. Presentation Layer
- **Components**:
  - `GenUIWidgetFactory`: Maps AI intents to Flutter widgets.
  - `ThinkingIndicator`: Visual feedback during streaming.
