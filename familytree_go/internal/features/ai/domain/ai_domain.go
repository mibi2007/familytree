package domain

import (
	"context"
	"errors"
	"time"
)

var (
	ErrAIProviderNotConfigured = errors.New("ai provider is not configured")
	ErrSelectedFamilyRequired  = errors.New("selected family id is required")
	ErrActingMemberRequired    = errors.New("acting member id is required")
	ErrQuestionRequired        = errors.New("question is required")
	ErrAIUnavailable           = errors.New("ai service is unavailable")
	ErrFamilyAccessDenied      = errors.New("access to selected family is denied")
)

// AIPrompt captures the minimal request payload for an AI assistant turn.
type AIPrompt struct {
	FamilyID        string
	UserID          string
	ActingMemberID  string
	Question        string
	ConversationRef string
	GroupChat       bool
	Context         *FamilyContext
}

// AIRecommendation represents a generated answer from the AI provider.
type AIRecommendation struct {
	Answer   string
	Provider string
}

type MessageRole string

const (
	MessageRoleUser   MessageRole = "user"
	MessageRoleModel  MessageRole = "model"
	MessageRoleSystem MessageRole = "system"
)

// ContextMessage is a role-aware message included in an AI request.
type ContextMessage struct {
	Role      MessageRole
	Content   string
	CreatedAt time.Time
}

// FamilySnapshot is the latest cached tree representation for a selected family.
type FamilySnapshot struct {
	FamilyID    string
	VersionHash string
	TreeData    []byte
	UpdatedAt   time.Time
}

// FamilyContext is the privacy-bounded context assembled for one AI request.
type FamilyContext struct {
	FamilyID        string
	ActingMemberID  string
	Snapshot        *FamilySnapshot
	SnapshotSummary string
	History         []ContextMessage
	TitleToMember   map[string]string
}

// ContextRepository reads only data relevant to the selected family.
type ContextRepository interface {
	GetLatestSnapshot(ctx context.Context, familyID string) (*FamilySnapshot, error)
	ListRelevantHistory(ctx context.Context, familyID string, limit int) ([]ContextMessage, error)
}

// TitleMappingService supplies kinship title mappings relative to the acting member.
type TitleMappingService interface {
	BuildTitleMapping(ctx context.Context, familyID, actingMemberID string) (map[string]string, error)
}

// IAIAgentService defines the application-facing contract for AI generation.
type IAIAgentService interface {
	Generate(ctx context.Context, prompt *AIPrompt) (*AIRecommendation, error)
}

// FamilyAccessService verifies that an authenticated user can use the selected family as AI context.
type FamilyAccessService interface {
	HasFamilyAccess(ctx context.Context, userID, familyID string) (bool, error)
}

// GroupReplyPublisher persists and broadcasts trusted AI replies to family chat.
type GroupReplyPublisher interface {
	PublishAIReply(ctx context.Context, familyID, answer string) error
}
