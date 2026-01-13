# Super Admin Setup Guide

## Overview
This document describes how to bootstrap the Super Admin system and grant the initial `SYSTEM_ADMIN` privileges.

## Prerequisites
- Access to the **Go Backend** database (`family_tree_dev` or `family_tree_prod`).
- A registered user account (Sign in via Admin App or User App).

## Bootstrapping the First Super Admin
Since the `RequestAdminAccess` flow requires an existing Super Admin to approve requests, the **first** Super Admin must be created manually by manipulating the database.

### Steps
1.  **Register/Login**: Sign in to the Admin App using Google Sign-In. This creates a record in the `users` table.
2.  **Get User ID**: obtain your Firebase User ID (UID). You can find this in:
    - Firebase Console > Authentication.
    - Or query the `users` table: `SELECT id, email, display_name FROM users;`
3.  **Update Role**: Execute the following SQL command on the PostgreSQL database:

```sql
-- Replace 'YOUR_USER_ID' with the actual Firebase UID
UPDATE users 
SET role = 'SUPER_ADMIN' 
WHERE id = 'YOUR_USER_ID';
```

4.  **Verify**: Log out and log back in to the Admin App. You should now see the Admin Dashboard.

## Onboarding Subsequent Admins
Once the first Super Admin is established, use the built-in invite system:

1.  **Generate Token**: Go to **Admin Dashboard > Generate Invite**.
2.  **Share**: Send the invite link/token to the new admin candidate.
3.  **Request**: The candidate uses the token to sign up/request access.
4.  **Approve**: Valid requests appear in **Admin Dashboard > Requests**. The bootstrapping Super Admin can then `Approve` them.
