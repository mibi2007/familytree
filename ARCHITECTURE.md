# 🏗️ System Architecture - Visual Overview

## 📐 High-Level Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────────┐
│                          CLIENT LAYER (Flutter)                          │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  ┌──────────────────────┐           ┌──────────────────────┐            │
│  │   Admin App          │           │   User App           │            │
│  ├──────────────────────┤           ├──────────────────────┤            │
│  │ - Dashboard          │           │ - Family Tree View   │            │
│  │ - Admin Requests     │           │ - Add Members        │            │
│  │ - Invite Generation  │           │ - Real-Time Chat     │            │
│  │ - Health Monitor     │           │ - Join Family        │            │
│  │ - Settings           │           │ - Profile            │            │
│  └──────────┬───────────┘           └──────────┬───────────┘            │
│             │                                   │                        │
│             └───────────────┬───────────────────┘                        │
│                             │                                            │
│                    ┌────────▼────────┐                                   │
│                    │ Shared Package  │                                   │
│                    ├─────────────────┤                                   │
│                    │ - Auth Provider │                                   │
│                    │ - Family Prov.  │                                   │
│                    │ - Chat Provider │                                   │
│                    │ - gRPC Clients  │                                   │
│                    │ - Auth Repo     │                                   │
│                    └────────┬────────┘                                   │
└─────────────────────────────┼──────────────────────────────────────────┘
                              │
                              │ gRPC (HTTP/2)
                              │ + Firebase Auth
                              │
┌─────────────────────────────▼──────────────────────────────────────────┐
│                     BACKEND LAYER (Go + Firebase)                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  ┌────────────────────┐          ┌────────────────────┐                 │
│  │ Firebase Auth      │          │ gRPC Server        │                 │
│  │ Emulator (Local)   │◄─────────┤ :50051             │                 │
│  │ Hosted (Prod)      │          ├────────────────────┤                 │
│  └────────────────────┘          │ - Auth Service     │                 │
│                                   │ - Family Service   │                 │
│                                   │ - Chat Service     │                 │
│                                   │ - System Service   │                 │
│  ┌────────────────────┐          └─────────┬──────────┘                 │
│  │ grpcwebproxy       │                    │                             │
│  │ localhost:8080     │                    │                             │
│  └────────────────────┘                    │                             │
│                                             │                             │
│                          ┌──────────────────▼──────────────────┐         │
│                          │      Middleware Layer               │         │
│                          ├─────────────────────────────────────┤         │
│                          │ - Auth Interceptor (JWT Verify)     │         │
│                          │ - Audit Interceptor (Admin Logs)    │         │
│                          │ - Recovery Interceptor (Panics)     │         │
│                          └──────────────────┬──────────────────┘         │
│                                             │                             │
│                          ┌──────────────────▼──────────────────┐         │
│                          │   Application Layer (Services)      │         │
│                          ├─────────────────────────────────────┤         │
│                          │ - AuthService                       │         │
│                          │ - FamilyService                     │         │
│                          │ - ChatService                       │         │
│                          │ - SystemService                     │         │
│                          └──────────────────┬──────────────────┘         │
│                                             │                             │
│                          ┌──────────────────▼──────────────────┐         │
│                          │   Domain Layer (Business Logic)     │         │
│                          ├─────────────────────────────────────┤         │
│                          │ - User, Token, AdminRequest         │         │
│                          │ - Family, Member                    │         │
│                          │ - Message, ChatPublisher            │         │
│                          │ - Repository Interfaces             │         │
│                          └──────────────────┬──────────────────┘         │
│                                             │                             │
│                          ┌──────────────────▼──────────────────┐         │
│                          │   Infrastructure Layer              │         │
│                          ├─────────────────────────────────────┤         │
│                          │ - Postgres Repositories             │         │
│                          │   • UserRepository                  │         │
│                          │   • FamilyRepository                │         │
│                          │   • ChatRepository                  │         │
│                          │   • TokenRepository                 │         │
│                          │   • LogRepository                   │         │
│                          └──────────────────┬──────────────────┘         │
└─────────────────────────────────────────────┼──────────────────────────┘
                                              │
                                              │ SQL Queries
                                              │
┌─────────────────────────────────────────────▼──────────────────────────┐
│                        DATA LAYER (Persistence)                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  ┌────────────────────────────────────────────────────────────────┐     │
│  │                    PostgreSQL Database                          │     │
│  ├────────────────────────────────────────────────────────────────┤     │
│  │  Tables:                                                         │     │
│  │  - users                 (UID, email, role, created_at)         │     │
│  │  - families              (ID, name, owner_id, ai_instructions)  │     │
│  │  - family_access         (family_id, user_id, role) ★           │     │
│  │  - family_members        (ID, family_id, display_name, level)   │     │
│  │  - chat_messages         (ID, family_id, sender_id, content)    │     │
│  │  - secure_tokens         (token, purpose, associated_id)        │     │
│  │  - admin_access_requests (ID, user_id, status, reason)          │     │
│  │  - admin_activity_logs   (ID, admin_id, action, target)         │     │
│  └────────────────────────────────────────────────────────────────┘     │
│                                                                           │
│  ┌────────────────────────────────────────────────────────────────┐     │
│  │              Google Cloud Storage (GCS)                         │     │
│  ├────────────────────────────────────────────────────────────────┤     │
│  │  Buckets:                                                        │     │
│  │  - familytree-media-dev   (User photos, family images)          │     │
│  │  - familytree-media-prod  (Production assets)                   │     │
│  └────────────────────────────────────────────────────────────────┘     │
│                                                                           │
└───────────────────────────────────────────────────────────────────────────┘

★ = Many-to-many junction table (key architecture decision)
```

---

## 🔄 Data Flow Diagrams

### 1. **User Authentication Flow**

```
┌─────────┐     1. Sign In     ┌─────────────┐     2. Verify Token     ┌──────────┐
│ Flutter ├───────────────────►│  Firebase   ├──────────────────────►│  gRPC    │
│   App   │                     │    Auth     │                        │  Server  │
└────┬────┘                     └─────────────┘                        └────┬─────┘
     │                                                                       │
     │  6. User Profile                                                      │
     │◄──────────────────────────────────────────────────────────────────────┤
     │                                                                       │
     │                          3. Extract UID                               │
     │                              from JWT                                 │
     │                                  │                                    │
     │                                  ▼                                    │
     │                          ┌───────────────┐                            │
     │                          │  Auth Service │                            │
     │                          ├───────────────┤                            │
     │                          │ EnsureUser    │──────4. Insert/Update──────┤
     │                          │ Exists()      │                            │
     │                          └───────────────┘                            │
     │                                  │                                    │
     │                                  ▼                                    │
     │                          ┌───────────────┐                            │
     │                          │  User Repo    │                            │
     │                          ├───────────────┤                            │
     │                          │ UpsertUser()  │                            │
     │                          └───────┬───────┘                            │
     │                                  │                                    │
     │                                  ▼                                    │
     │                          ┌───────────────┐                            │
     │                          │   Postgres    │                            │
     │                          │  users table  │                            │
     │                          └───────────────┘                            │
```

---

### 2. **Admin Access Request Flow**

```
User                Firebase         gRPC Server          Admin App
 │                     │                  │                    │
 │  1. Request Admin   │                  │                    │
 ├─────────────────────┼─────────────────►│                    │
 │                     │   JWT Token      │                    │
 │                     │                  │                    │
 │                     │  2. Verify UID   │                    │
 │                     │◄─────────────────┤                    │
 │                     │                  │                    │
 │                     │  3. Create       │                    │
 │                     │     Request      │                    │
 │                     │                  ├───────►┌─────────┐ │
 │                     │                  │        │Postgres │ │
 │                     │                  │◄───────┤requests │ │
 │                     │                  │        └─────────┘ │
 │  4. Request Pending │                  │                    │
 │◄────────────────────┼──────────────────┤                    │
 │                     │                  │                    │
 │                     │                  │  5. Poll Requests  │
 │                     │                  │◄───────────────────┤
 │                     │                  │                    │
 │                     │                  │  6. List Pending   │
 │                     │                  ├───────────────────►│
 │                     │                  │                    │
 │                     │                  │  7. Admin Approves │
 │                     │                  │◄───────────────────┤
 │                     │                  │                    │
 │                     │  8. Update Role  │                    │
 │                     │                  ├───────►┌─────────┐ │
 │                     │                  │        │Postgres │ │
 │                     │                  │◄───────┤ users   │ │
 │                     │                  │        │ SET role│ │
 │                     │                  │        └─────────┘ │
 │                     │                  │                    │
 │  9. Next Login      │                  │                    │
 │     (Now Admin)     │                  │                    │
 ├─────────────────────┼─────────────────►│                    │
 │                     │  JWT w/ role     │                    │
 │                     │◄─────────────────┤                    │
```

---

### 3. **Family Invite & Join Flow**

```
Owner                  Server                  New Member
  │                      │                         │
  │  1. Create Invite    │                         │
  ├─────────────────────►│                         │
  │                      │                         │
  │                      ├──────►┌──────────┐      │
  │                      │       │ Generate │      │
  │                      │       │  Token   │      │
  │                      │◄──────┤ UUID     │      │
  │                      │       └──────────┘      │
  │                      │                         │
  │                      ├──────►┌──────────┐      │
  │  2. Token + Expiry   │       │ Postgres │      │
  │◄─────────────────────┤       │ tokens   │      │
  │                      │◄──────┤ INSERT   │      │
  │                      │       └──────────┘      │
  │  3. Share Token      │                         │
  │──────────────────────┼────────────────────────►│
  │    (Copy/Paste)      │                         │
  │                      │                         │
  │                      │  4. Join Family         │
  │                      │◄────────────────────────┤
  │                      │    with Token           │
  │                      │                         │
  │                      ├──────►┌──────────┐      │
  │                      │       │ Validate │      │
  │                      │       │  Token   │      │
  │                      │◄──────┤ (unused, │      │
  │                      │       │  valid)  │      │
  │                      │       └──────────┘      │
  │                      │                         │
  │                      ├──────►┌──────────┐      │
  │                      │       │ Add to   │      │
  │                      │       │ family_  │      │
  │                      │       │ access   │      │
  │                      │◄──────┤ (MEMBER) │      │
  │                      │       └──────────┘      │
  │                      │                         │
  │                      ├──────►┌──────────┐      │
  │                      │       │ Mark     │      │
  │                      │       │ Token    │      │
  │                      │◄──────┤ Used     │      │
  │                      │       └──────────┘      │
  │                      │                         │
  │                      │  5. Family Access       │
  │                      ├────────────────────────►│
  │                      │    Granted              │
```

---

### 4. **Real-Time Chat Flow**

```
User A               Server                  User B
  │                    │                       │
  │  1. Send Message   │                       │
  ├───────────────────►│                       │
  │                    │                       │
  │                    ├────►┌──────────┐      │
  │                    │     │ Save to  │      │
  │                    │     │ Postgres │      │
  │                    │◄────┤ messages │      │
  │                    │     └──────────┘      │
  │                    │                       │
  │                    ├────►┌──────────┐      │
  │                    │     │ Publish  │      │
  │  2. Ack            │     │ to All   │      │
  │◄───────────────────┤     │ Streams  │      │
  │                    │     └──────────┘      │
  │                    │                       │
  │                    │  3. Stream Event      │
  │                    ├──────────────────────►│
  │                    │    (New Message)      │
  │                    │                       │
  │                    │                       │
  │  4. History Load   │                       │
  │◄───────────────────┤                       │
  │    (on Connect)    │                       │
  │                    │                       │
  │  5. Stream Sub     │                       │
  ├───────────────────►│                       │
  │    (live updates)  │                       │
  │                    │                       │

Flutter UI:
┌──────────────────────────────────────┐
│  MergedChatMessagesProvider          │
│  ┌────────────┐   ┌───────────────┐  │
│  │ History    │ + │ Stream        │  │
│  │ (50 msgs)  │   │ (new msgs)    │  │
│  └────────────┘   └───────────────┘  │
│           │             │             │
│           └──────┬──────┘             │
│                  ▼                    │
│         ┌────────────────┐            │
│         │ Deduplicated   │            │
│         │ Message List   │            │
│         └────────────────┘            │
└──────────────────────────────────────┘
```

---

## 🗄️ Database Schema Relationships

```
┌──────────────┐
│    users     │
├──────────────┤
│ id (PK)      │◄────────────┬───────────────────┐
│ email        │             │                   │
│ role         │             │                   │
│ created_at   │             │                   │
└──────────────┘             │                   │
       ▲                     │                   │
       │                     │                   │
       │                     │                   │
       │               ┌─────▼──────┐     ┌──────▼──────┐
       │               │  families  │     │ chat_msgs   │
       │               ├────────────┤     ├─────────────┤
       │               │ id (PK)    │     │ id (PK)     │
       │               │ name       │     │ family_id   │
       │               │ owner_id ──┼──┐  │ sender_id ──┼──┐
       │               └─────┬──────┘  │  └─────────────┘  │
       │                     │         │                   │
       │                     │         └───────────────────┘
       │               ┌─────▼──────────┐
       │               │ family_access  │ ★ JUNCTION TABLE
       │               ├────────────────┤
       │               │ family_id (PK) │
       │               │ user_id (PK)───┼──┐
       │               │ role           │  │
       │               └────────────────┘  │
       │                                   │
       └───────────────────────────────────┘

┌──────────────────┐
│ secure_tokens    │
├──────────────────┤
│ token (PK)       │
│ purpose          │
│ associated_id ───┼────► (families.id OR users.id)
│ is_used          │
│ expires_at       │
└──────────────────┘

┌──────────────────────┐
│ admin_access_requests│
├──────────────────────┤
│ id (PK)              │
│ user_id ─────────────┼───► users.id
│ status               │
│ reason               │
│ reviewed_by ─────────┼───► users.id
└──────────────────────┘

┌──────────────────────┐
│ admin_activity_logs  │
├──────────────────────┤
│ id (PK)              │
│ admin_id ────────────┼───► users.id
│ action               │
│ target_id            │
│ timestamp            │
└──────────────────────┘

┌──────────────────┐
│ family_members   │
├──────────────────┤
│ id (PK)          │
│ family_id ───────┼───► families.id
│ display_name     │
│ parent_id ───────┼───► family_members.id (self-ref)
│ spouse_id ───────┼───► family_members.id (self-ref)
│ user_id ─────────┼───► users.id (optional claim)
│ level            │
└──────────────────┘
```

---

## 🌐 Technology Stack Visualization

```
┌─────────────────────────────────────────────────────────────┐
│                      FRONTEND STACK                          │
├─────────────────────────────────────────────────────────────┤
│  Framework:      Flutter (Dart)                              │
│  State Mgmt:     Riverpod 2.x (Code Generation)              │
│  Auth:           Firebase Authentication                     │
│  API Client:     gRPC (Protobuf)                             │
│  Navigation:     go_router                                   │
│  Testing:        flutter_test + mocktail                     │
│  Build Tool:     build_runner (code gen)                     │
│  Package Mgmt:   Melos (monorepo)                            │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                      BACKEND STACK                           │
├─────────────────────────────────────────────────────────────┤
│  Language:       Go 1.21+                                    │
│  Framework:      gRPC + grpcwebproxy                         │
│  Architecture:   DDD (Domain-Driven Design)                  │
│  Database:       PostgreSQL 15                               │
│  Auth:           Firebase Admin SDK                          │
│  Storage:        Google Cloud Storage (GCS)                  │
│  Testing:        go test + testify                           │
│  Migrations:     goose                                       │
│  Linting:        golangci-lint                               │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                   INFRASTRUCTURE STACK                       │
├─────────────────────────────────────────────────────────────┤
│  Hosting:        Firebase Hosting (multi-site)               │
│  Database:       Cloud SQL (PostgreSQL)                      │
│  Storage:        GCS Buckets                                 │
│  Auth:           Firebase Auth                               │
│  Compute:        Cloud Run (planned)                         │
│  CI/CD:          GitHub Actions (planned)                    │
│  Monitoring:     Custom Health Checks (in-app)               │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔐 Security Architecture

```
┌───────────────────────────────────────────────────────────────┐
│                      SECURITY LAYERS                          │
└───────────────────────────────────────────────────────────────┘

Layer 1: AUTHENTICATION
┌─────────────────────────────────────────┐
│  Firebase Authentication                │
│  ✓ Google Sign-In                       │
│  ✓ Email/Password                       │
│  ✓ Phone (future)                       │
│  ✓ Anonymous (temp UID migration)       │
└─────────────────────────────────────────┘
          │
          ▼ JWT Token (verified on every request)
          │
Layer 2: AUTHORIZATION
┌─────────────────────────────────────────┐
│  Auth Interceptor Middleware            │
│  ✓ Verify Firebase JWT                  │
│  ✓ Extract UID + Email                  │
│  ✓ Inject User into gRPC Context        │
└─────────────────────────────────────────┘
          │
          ▼ User Context
          │
Layer 3: ROLE-BASED ACCESS CONTROL
┌─────────────────────────────────────────┐
│  Service-Level Checks                   │
│  ✓ Admin-only endpoints (e.g., Approve) │
│  ✓ Owner-only actions (e.g., Delete)    │
│  ✓ Member access (via family_access)    │
└─────────────────────────────────────────┘
          │
          ▼ Authorized Actions
          │
Layer 4: AUDIT LOGGING
┌─────────────────────────────────────────┐
│  Audit Interceptor                      │
│  ✓ Log all admin actions                │
│  ✓ Timestamp + Action + Target          │
│  ✓ Stored in admin_activity_logs        │
└─────────────────────────────────────────┘
```

---

## 📈 Scalability Considerations

### Current Capacity
```
┌────────────────────────────────────────┐
│  Component         │ Max Throughput    │
├────────────────────┼───────────────────┤
│  gRPC Server       │ 1000 req/s        │
│  Postgres          │ 500 conn          │
│  Firebase Auth     │ Unlimited (Cloud) │
│  GCS Storage       │ Unlimited (Cloud) │
│  Chat Streaming    │ 100 concurrent    │
└────────────────────────────────────────┘
```

### Bottlenecks & Solutions
```
1. Database Connections
   Problem:  Fixed conn pool (500)
   Solution: Read replicas, PgBouncer

2. Chat Pub/Sub (In-Memory)
   Problem:  Single server limit
   Solution: Redis Pub/Sub, Firestore

3. gRPC Single Instance
   Problem:  No load balancing
   Solution: Cloud Run (auto-scale)
```

---

**Created**: 2026-02-02  
**Version**: 1.0  
**Status**: ✅ Current Implementation
