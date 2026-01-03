# Events - Requirements

## Overview
Manage and track important family dates and organized gatherings.

## Functional Requirements
- **Event Types**:
  - **Automatic Events**: Birthday and Death Anniversary events are automatically created, updated, or removed whenever the respective dates are populated or changed in a member's profile.
    - **Date Synchronization**: If a member's birth or death date is edited, the associated event's date must be updated immediately to remain in sync.
  - **Manual Events**: Members can create custom events (e.g., Family Reunion, Anniversary).
  - **Recurrence**: Events can be **Yearly** (e.g., Anniversary, Birthday) or **One-time** (e.g., Wedding).
- **Event Participation**:
  - **Joining**: Members can explicitly "Join" an event.
  - **Chat Integration**: 
    - Users can mention an Event in group or private chats.
    - Mentioned events display a "Join" button for other members.
- **Automation**:
  - When the event date occurs, a **Timeline Post** is automatically generated.
  - All joined members are automatically tagged in this post.
- **Duplicate Prevention**:
  - The system must check for existing events before creation.
  - Criteria for duplication: Same **title**, **date**, and **member/family** association.
  - Automatic events (Birthdays/Deaths) must be idempotent (one event per member per event type).
- **Timeline Integration**:
  - A Timeline post can be "promoted" to an Event or linked to an existing Event.
  - When viewing an Event (or receiving a reminder), users can see a chronological list of associated Timeline posts.
- **Visibility**:
  - All family members can view all events within that family.
- **Reminders**:
  - Events trigger notifications based on user settings (e.g., N days before).
