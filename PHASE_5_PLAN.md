# 🚀 Phase 5 Implementation Plan - Advanced Features

**Status**: IN PROGRESS  
**Start Date**: 2026-02-02  
**Target Completion**: 2-3 weeks

---

## 📋 Overview

Phase 5 focuses on two major advanced features:
1. **AI Assistant** - Gemini-powered chat assistant for family history queries
2. **Vietnamese Kinship** - Cultural relationship addressing system

---

## 🎯 Part 1: AI Assistant Integration

### Objective
Integrate Google Gemini via Genkit Go to provide intelligent family history assistance within the chat interface.

### Prerequisites
- ✅ Chat system working (Phase 4 complete)
- ✅ Family tree data model ready
- ✅ gRPC infrastructure in place
- ⏳ Gemini AI API key
- ⏳ Genkit Go framework setup

---

### Step 1.1: Genkit Go Setup (1-2 days)

**Goal**: Set up Genkit Go framework in the backend

#### Tasks:
```bash
# 1. Install Genkit Go
cd familytree_go
go get github.com/firebase/genkit/go/ai
go get github.com/firebase/genkit/go/plugins/googleai

# 2. Initialize Genkit in server
# Create new service: internal/features/ai/
```

#### Files to Create:
- `internal/features/ai/domain/ai_types.go` - AI domain models
- `internal/features/ai/app/ai_service.go` - AI orchestration service
- `internal/features/ai/app/context_builder.go` - Family context injection
- `internal/features/ai/interfaces/grpc/ai_handler.go` - gRPC handler

#### Configuration:
```go
// Add to server initialization
import (
    "github.com/firebase/genkit/go/ai"
    "github.com/firebase/genkit/go/plugins/googleai"
)

// Initialize Gemini plugin
ctx := context.Background()
if err := googleai.Init(ctx, &googleai.Config{
    APIKey: os.Getenv("GEMINI_API_KEY"),
}); err != nil {
    log.Fatal(err)
}
```

---

### Step 1.2: AI Service Implementation (2-3 days)

**Goal**: Create AI service that can answer family history questions

#### Core Functionality:
```go
type AIService struct {
    familyRepo domain.FamilyRepository
    memberRepo domain.MemberRepository
    chatRepo   domain.ChatRepository
}

// Generate AI response with family context
func (s *AIService) AskQuestion(ctx context.Context, familyID, question string) (string, error) {
    // 1. Get family tree data
    members, _ := s.memberRepo.ListByFamily(ctx, familyID)
    
    // 2. Get recent chat history for context
    history, _ := s.chatRepo.ListMessages(ctx, familyID, 20, "")
    
    // 3. Build context prompt
    context := s.buildFamilyContext(members, history)
    
    // 4. Call Gemini with context + question
    response, err := s.callGemini(context, question)
    
    return response, err
}
```

#### Context Builder:
```go
func (s *AIService) buildFamilyContext(members []*Member, history []*Message) string {
    var context strings.Builder
    
    context.WriteString("Family Tree Structure:\n")
    for _, member := range members {
        context.WriteString(fmt.Sprintf("- %s (Level %d)\n", member.DisplayName, member.Level))
        if member.ParentID != "" {
            parent, _ := s.memberRepo.GetByID(ctx, member.ParentID)
            context.WriteString(fmt.Sprintf("  Parent: %s\n", parent.DisplayName))
        }
    }
    
    context.WriteString("\nRecent Family Chat:\n")
    for _, msg := range history {
        context.WriteString(fmt.Sprintf("- %s: %s\n", msg.SenderID, msg.Content))
    }
    
    return context.String()
}
```

---

### Step 1.3: Protobuf Definitions (0.5 day)

**Goal**: Define AI service API contract

#### Create: `proto/ai/v1/ai.proto`
```protobuf
syntax = "proto3";

package ai.v1;

option go_package = "github.com/mibi2007/familytree/familytree_go/proto/ai/v1";

service AIService {
  rpc AskQuestion(AskQuestionRequest) returns (AskQuestionResponse);
  rpc SuggestQuestions(SuggestQuestionsRequest) returns (SuggestQuestionsResponse);
}

message AskQuestionRequest {
  string family_id = 1;
  string question = 2;
}

message AskQuestionResponse {
  string answer = 1;
  repeated string sources = 2; // Member IDs referenced in answer
}

message SuggestQuestionsRequest {
  string family_id = 1;
}

message SuggestQuestionsResponse {
  repeated string suggested_questions = 1;
}
```

---

### Step 1.4: Flutter Integration (1-2 days)

**Goal**: Add AI chat button and display AI responses

#### User App Changes:
```dart
// 1. Create AI Provider
@riverpod
class AIController extends _$AIController {
  Future<String> askQuestion(String familyId, String question) async {
    final client = ref.read(aiClientProvider);
    final response = await client.askQuestion(
      AskQuestionRequest(familyId: familyId, question: question),
    );
    return response.answer;
  }
}

// 2. Update Chat Page with AI button
Row(
  children: [
    IconButton(
      icon: Icon(Icons.auto_awesome), // AI sparkle icon
      onPressed: () => _showAIDialog(context, ref),
    ),
    Expanded(child: TextField(...)),
    IconButton(icon: Icon(Icons.send), onPressed: _sendMessage),
  ],
)

// 3. AI Question Dialog
void _showAIDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (context) => AIQuestionDialog(familyId: widget.familyId),
  );
}
```

---

## 🎯 Part 2: Vietnamese Kinship System

### Objective
Implement culturally accurate Vietnamese family relationship addressing.

### Background
Vietnamese kinship is complex:
- Paternal vs maternal side have different titles
- Age relative to parents matters
- Gender of relative matters
- Generation level (parents, grandparents, etc.)

---

### Step 2.1: Kinship Domain Model (1 day)

**Goal**: Define kinship calculation domain

#### Create: `internal/features/family/domain/kinship.go`
```go
type KinshipRelation struct {
    FromMemberID string
    ToMemberID   string
    Relationship string // e.g., "con" (child), "bác" (uncle)
    VietnameseTitle string
    Side         RelationSide // PATERNAL, MATERNAL
}

type RelationSide string
const (
    PATERNAL RelationSide = "PATERNAL"
    MATERNAL RelationSide = "MATERNAL"
)

// Kinship calculator interface
type KinshipCalculator interface {
    CalculateRelationship(ctx context.Context, fromID, toID string) (*KinshipRelation, error)
    GetVietnameseTitle(relation *KinshipRelation) string
}
```

---

### Step 2.2: Relationship Calculator (2-3 days)

**Goal**: Calculate Vietnamese kinship titles

#### Implementation:
```go
type vietnameseKinshipCalculator struct {
    memberRepo MemberRepository
}

func (c *vietnameseKinshipCalculator) CalculateRelationship(
    ctx context.Context, 
    fromID, toID string,
) (*KinshipRelation, error) {
    from, _ := c.memberRepo.GetByID(ctx, fromID)
    to, _ := c.memberRepo.GetByID(ctx, toID)
    
    // 1. Determine generation difference
    genDiff := to.Level - from.Level
    
    // 2. Trace common ancestor
    ancestor := c.findCommonAncestor(ctx, from, to)
    
    // 3. Determine side (paternal/maternal)
    side := c.determineSide(ctx, from, to, ancestor)
    
    // 4. Calculate Vietnamese title
    title := c.getTitle(genDiff, side, to.Gender)
    
    return &KinshipRelation{
        FromMemberID: fromID,
        ToMemberID:   toID,
        Relationship: title,
        Side:         side,
    }, nil
}

func (c *vietnameseKinshipCalculator) getTitle(
    genDiff int, 
    side RelationSide, 
    gender string,
) string {
    // Parents generation (genDiff = -1)
    if genDiff == -1 {
        if gender == "male" {
            if side == PATERNAL {
                return "Bác" // Father's older brother
            }
            return "Chú" // Father's younger brother or mother's brother
        }
        if side == PATERNAL {
            return "Cô" // Father's sister
        }
        return "Dì" // Mother's sister
    }
    
    // Grandparents generation (genDiff = -2)
    if genDiff == -2 {
        if gender == "male" {
            if side == PATERNAL {
                return "Ông nội" // Paternal grandfather
            }
            return "Ông ngoại" // Maternal grandfather
        }
        // ... similar for grandmother
    }
    
    // ... more relationships
    
    return "Họ hàng" // Generic relative
}
```

---

### Step 2.3: UI Integration (1 day)

**Goal**: Display Vietnamese titles in family tree

#### Family Tree View Changes:
```dart
// Add Vietnamese title to member display
class MemberNode extends StatelessWidget {
  final Member member;
  final Member? currentUser; // User viewing the tree
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getVietnameseTitle(member, currentUser),
      builder: (context, snapshot) {
        return Column(
          children: [
            Text(member.displayName),
            if (snapshot.hasData)
              Text(
                snapshot.data!, // "Bác", "Chú", etc.
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
          ],
        );
      },
    );
  }
  
  Future<String> _getVietnameseTitle(Member member, Member? current) async {
    if (current == null) return '';
    // Call backend to calculate relationship
    final client = ref.read(familyClientProvider);
    final response = await client.getKinshipRelation(
      GetKinshipRelationRequest(
        fromMemberId: current.id,
        toMemberId: member.id,
      ),
    );
    return response.vietnameseTitle;
  }
}
```

---

## 📊 Implementation Timeline

### Week 1: AI Foundation
- [ ] Day 1-2: Genkit Go setup & configuration
- [ ] Day 3-4: AI Service implementation
- [ ] Day 5: Protobuf definitions & code generation

### Week 2: AI Integration
- [ ] Day 1-2: Flutter AI provider & UI
- [ ] Day 3-4: Testing & debugging
- [ ] Day 5: Documentation & examples

### Week 3: Vietnamese Kinship
- [ ] Day 1: Domain model & interfaces
- [ ] Day 2-3: Relationship calculator implementation
- [ ] Day 4: UI integration
- [ ] Day 5: Testing & refinement

---

## 🧪 Testing Strategy

### AI Service Tests
```go
func TestAIService_AskQuestion(t *testing.T) {
    // Mock family data
    members := []*Member{
        {ID: "m1", DisplayName: "John", Level: 0},
        {ID: "m2", DisplayName: "Jane", Level: 1, ParentID: "m1"},
    }
    
    service := NewAIService(mockFamilyRepo, mockGeminiClient)
    
    // Test question answering
    answer, err := service.AskQuestion(ctx, "family123", "Who are John's children?")
    
    assert.NoError(t, err)
    assert.Contains(t, answer, "Jane")
}
```

### Kinship Calculator Tests
```go
func TestKinshipCalculator_VietnameseTitle(t *testing.T) {
    tests := []struct{
        name     string
        from     *Member
        to       *Member
        expected string
    }{
        {
            name: "Father's older brother",
            from: &Member{Level: 0},
            to:   &Member{Level: -1, Gender: "male", /* is older */},
            expected: "Bác",
        },
        // ... more test cases
    }
    
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            calc := NewVietnameseKinshipCalculator(mockRepo)
            title := calc.getTitle(/* params */)
            assert.Equal(t, tt.expected, title)
        })
    }
}
```

---

## 🎯 Success Criteria

### AI Assistant
- [ ] AI can answer questions about family tree structure
- [ ] AI responses include relevant member names
- [ ] AI uses chat history for context
- [ ] Response time < 3 seconds
- [ ] Graceful handling of unclear questions

### Vietnamese Kinship
- [ ] Correctly identifies 20+ kinship relations
- [ ] Distinguishes paternal vs maternal side
- [ ] Handles spouse-side relationships
- [ ] Displays titles in family tree UI
- [ ] Supports multiple generations

---

## 📚 Resources

### Genkit Go
- [Genkit Go Documentation](https://firebase.google.com/docs/genkit-go)
- [Gemini API Documentation](https://ai.google.dev/docs)

### Vietnamese Kinship
- Cultural reference materials
- Family tree relationship charts
- Vietnamese language resources

---

## 🚧 Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Gemini API costs | High | Implement caching, rate limiting |
| Complex kinship logic | Medium | Start with basic relations, iterate |
| AI response accuracy | High | Add human review, feedback system |
| API latency | Medium | Cache common questions, async processing |

---

## 🎉 Next Immediate Steps

### Option A: Start with AI (Recommended)
**Why**: Adds user value immediately, less complex than kinship

1. Set up Genkit Go in backend
2. Create basic AI service with family context
3. Add AI button to chat UI
4. Test with simple questions

### Option B: Start with Vietnamese Kinship
**Why**: Core feature for Vietnamese users, no external dependencies

1. Implement kinship domain model
2. Create basic relationship calculator
3. Add Vietnamese titles to tree view
4. Test with common relationships

---

**Which path would you like to start with?**  
A) AI Assistant (easier, immediate value)  
B) Vietnamese Kinship (more complex, cultural feature)  
C) Another priority?
