# Family Core - Requirements

## Overview
The "Family" is the central organizational unit. One user creates the Family (Admin), and members are invited to join.

## Functional Requirements
- **Family Creation**: A user can create one or more families.
- **Invitations**:
  - Invite via **Email**, **Phone**, **User ID**, or directly from your **Friends List**.
  - **Member-Bound Invites**: Every invitation MUST be linked to a specific member node in the tree.
  - **QR Code Invites**: Admins generate a QR code for a specific member node.
- **Roles & Membership**:
  - **Role System**: Users have roles specific to each family (stored in `family_members` table).
  - **Admin**: Full management (invite, remove members, edit family info, set roles).
  - **Member**: Access to family chat and tree.
  - **Acting Roles**: 
    - Invited users are automatically assigned to the member node specified in their invitation.
    - **No Reassignment**: Invited users *cannot* change the member node they are acting as.
    - **Profile Control**: Users have full control over the **General Information** (Markdown) of the member they act as.
- **Onboarding & Home Screen**:
  - **New User / No Family State**: If a user has no families, the home screen highlights two main actions: **"Create Family"** and **"Add Friend"**.
  - **Family Selected State**: When a user selects/opens a family, they are directed immediately to the **Default Family Group Chat**.
- **Family Tree**:
  - Interactive visualization of parent-child relationships.
  - Interactive nodes (tap to view profile).
- **Member Profiles**:
  - **Core Data**: Full name, Gender, Birthdate, Birthyear.
  - **Contact**: Phone number, physical address.
  - **Relationships**: Parent-Child (Con của), Spouse (Chồng/Vợ của).
  - **Memorial Data**: Year of death, Date of death (Solar & Lunar - Âm lịch).
  - **General Info**: Configurable Markdown text block for personal history/notes.
  - **Reminders**: Option to receive notifications for Birthday or Death Anniversary with a configurable "days before" setting.
- **Addressing & Pronunciation (Addressing System)**:
  - **Level from Root**: Each member has a generation level (e.g., Level 0, 1, 2).
  - **Member-to-Member Logic**: Titles are calculated based on the position of two member nodes in the tree.
  - **Automated Title Generation**: When a new member is added, the system automatically generates and stores 1-to-1 titles between the new member and all existing members in the family.
  - **Manual Override**: Members can manually edit the auto-generated titles for themselves relative to others.
  - **1-on-1 Consistency**: Every pair of members in a family has a pre-calculated title, allowing for instant discovery.
  - **Display Preferences**: Users can toggle between seeing **Real Names** or **Family Titles** for others in chats and profiles.
  - **AI Suggestions**: The AI Assistant can suggest culturally appropriate or "user-friendly" titles based on the tree position.
  - **Node Ownership**: All kinship titles (auto-generated or manual overrides) are properties of the **Family Member Node**, NOT the User account.
  - **Persistence**: If a user deletes their account, the titles associated with the member node they were acting as remain unchanged in the family tree.
  - **Acting Inheritance**: When a user "Acts" as a member, they inherit the kinship titles corresponding to that member's position.
  - **Localization**: Titles must support both Vietnamese (Primary) and English (Secondary) translations.
