# AI Integration

Intelligent family context and assistant features.

## Technologies
- **Framework**: [Genkit Go](./genkit-go.md) - Google's framework for building AI-powered applications. Handles flow orchestration, tool calling, and evaluations.
- **Model**: **Google Generative AI (Gemini)** - Core LLM for natural language processing.
- **Frontend Tooling**: **GenUI** - Generative User Interface components for dynamic AI interactions in Flutter.

## Architecture Patterns
- **Context Injection**: Specialized prompts that incorporate family tree snapshots into AI conversation history.
- **Trie-based Kinship Resolution**: Using tree structures to map natural language terms (e.g., "Uncle") to specific Member IDs.
