# Social & Chat - Requirements

## Overview
Connect with family and friends through messaging, media sharing, and real-time communication.

## Functional Requirements
- **Friends System**:
  - Search members by ID/Email.
  - Send/Accept/Decline friend requests.
  - **Invite to Family**: Users can directly invite their friends to join their family tree as a specific member node.
- **Messaging**:
  - Private (1-on-1) and Group Chat.
  - **Default Family Group Chat**: 
    - Automatically created when a new Family is initialized.
    - All family members are automatically joined upon being added to the family.
    - **Primary Entry Point**: The family group chat is the first screen shown when a user opens a specific family.
  - Text, Emojis, and Image sharing (Gallery View).
  - **Location Sharing**: Native-like interactive Google Maps widget.
  - **Social Mentions**:
    - **@Member**: Deep link to member profile/chat.
    - **@Event**: Interactive joinable widget.
  - **Rich Embeds**:
    - **URL Preview**: Metadata extraction (title, description, thumbnail).
    - **YouTube Player**: Inline video playback.
    - **Google Maps**: Static or interactive maps for shared addresses.
  - **Display Preferences**: Option to switch between "Real Name" and "Kinship Title" for message senders.
  - **Chat Controls**: Option to mute/unmute notifications per conversation (Selection: 3 hrs, 1 day, or Always).
  - **Sticky Widgets**: 
    - Any member in a group/private chat can "stick" a structured message (e.g., an Event widget) to the bottom of the screen.
    - The sticky widget remains visible regardless of scrolling until unpinned or replaced.
    - Example: Sticking a "Death Anniversary" event showing joined participants.
  - **Pagination**: Load only recent history; scroll to load archive.
- **Storage**:
  - **5GB Quota**: Each user gets 5GB of storage for shared images.
- **Real-time Voice/Video**:
  - 1-on-1 or 1-on-2 (small group) Video calls.
  - Low latency priority.
