# Timeline - Requirements

## Overview
Capture and relive family history through a chronological record of stories, milestones, and memories.

## Functional Requirements
- **Timeline Posts**:
  - Content: Text (Markdown support), Images (multiple), and Timestamp.
  - Ownership: Post can be associated with a **Family** (general events) or a specific **Member** (life events).
  - Tagging: Ability to tag one or more family members in a post.
  - **Event Linking**: Posts can be linked to a specific **Family Event** to build a historical record of that event over the years.
- **Visibility**:
  - All members of a family can view the timeline posts belonging to that family and its members.
- **"On This Day" Reminders**:
  - Automatically resurface posts from the same calendar day in previous years.
  - Similar to Facebook memories, these appear in the feed or as notifications.
- **Automated Generation**:
  - When a **Family Event** occurs, the system automatically creates a Timeline post.
  - The post automatically tags all members who successfully "joined" the event.
