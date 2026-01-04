---
description: How to run the local development environment (Emulators, Backend, Flutter)
---

This workflow guides you through starting the full Family Tree ecosystem locally.

### 1. Prerequisites
- Ensure [Docker Desktop](https://www.docker.com/products/docker-desktop/) is running (for PostgreSQL).
- Ensure [Firebase CLI](https://firebase.google.com/docs/cli) is installed (`npm install -g firebase-tools`).

### 2. Start PostgreSQL
Ensure the PostgreSQL service is running on your Windows machine.
- Default connection: `postgres://postgres:postgres@localhost:5432/familytree?sslmode=disable`
- Database Name: `familytree`

### 3. Start Firebase Emulators
// turbo
```bash
cd familytree_firebase
firebase emulators:start --import=./seeds --export-on-exit=./seeds
```
> [!NOTE]
> The first time you run this, you might not have `./seeds`. You can omit the `--import` flag.

### 4. Start Go Backend
// turbo
```bash
cd familytree_go
go run cmd/server/main.go
```

### 5. Run Flutter Apps (LOCAL)
Run the apps using the `main_local.dart` entry point to connect to the emulators and local gRPC server.

**User App:**
```bash
cd familytree_flutter/apps/user_app
flutter run -t lib/main_local.dart
```

**Admin App:**
```bash
cd familytree_flutter/apps/admin_app
flutter run -t lib/main_local.dart
```
