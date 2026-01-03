# Notifications - Requirements

## Overview
Keep users informed about family events and personal reminders through timely notifications.

## Functional Requirements
- **Notification Providers**:
  - **Push (Device)**: Using Firebase Cloud Messaging (FCM).
  - **Email**: Transactional emails for reminders.
  - **Notification Control**:
  - **Mute Feature**: Users can mute notifications for specific private or group chats.
    - **Options**: Indefinite, 3 Hours, 1 Day.
  - **Opt-In/Out**: Users can choose which providers they want active for each notification type.
- **Family Core Reminders**:
  - **Triggers**: Birthday, Death Anniversary, **Timeline Memories (On This Day)**.
  - **Granularity**: Set at the family or member level.
  - **Advance Notice**: User can specify "N days before" the event to receive the notification.
  - **Contextual History**: Notifications for Birthdays/Anniversaries should provide a link to view all past timeline stories/images associated with that event or date.
- **Delivery Schedule**:
  - All reminder-based notifications must be dispatched at **7:00 AM (GMT+7)**.
- **System Notifications**:
  - **Private Chat Messages**: Real-time push alert when receiving a message.
  - Friend requests, Family invites, Group chat mentions.
