# AI Assistant (@family) - Requirements

## Overview
A smart assistant capable of understanding family relationships and helping members with questions about their ancestry and family events.

## Functional Requirements
- **Interaction Modes**:
  - **Private Chat**: Direct 1-on-1 session with @family.
  - **Group Chat**: Mention `@family` to invoke the assistant in shared family groups.
- **Knowledge Base**:
  - Access to the Family Tree (nodes and relationships).
  - Access to family documents and shared histories.
  - **Kinship Title Awareness**: @family must resolve titles (e.g., "Ông Ngoại", "Bác", "Mẹ") relative to the member node the user is currently "Acting" as.
- **Interaction Modes**:
  - **Private Chat (1-on-1)**: 
    - Always available regardless of current family context.
    - Supports multiple chat sessions ("New Chat") and saved history.
    - **Focus Options**: Users can select what the AI "knows" for each session:
      - **Families Context**: Default: "All Families" (access to all family data). Option to manually select specific families.
      - **Social Context**: Default: "All Chats" (access to history with anyone). Option to manually select specific users/conversations.
  - **Group Chat Assistant**:
    - Invoked in family group chats via `@family` mention.
    - Behaves as a "virtual member" of that family within the group.
- **UX**:
  - **Real-time Streaming**: AI responses appear as they are generated.
  - **Interactive UI**: Show family tree nodes directly in the chat when referenced.
  - **Kinship Title Suggestion**: Help users choose the most appropriate way to address a new or distant relative.
  - **Multi-language**: Responses should match the user's preferred language (Vietnamese/English).
- **Personality & Behavior Instructions**:
  - **Hierarchical Controls**:
    - **Level 1 (Global)**: Set by Super Admins. Defines the baseline tone, safety guardrails, and core behaviors for @family across the entire app.
    - **Level 2 (Family)**: Set by Family Admins. Allows adjusting the assistant's "personality" for their specific family (e.g., "Be more formal", "Focus on northern traditions").
  - **Behavioral Focus**: Users must be clearly informed that these settings only influence **how** the AI acts, not what family data is stored or accessed.
- **History**: Same lazy-loading logic as standard chat.
