package domain

import (
	"context"

	"github.com/mibi2007/familytree/familytree_go/internal/features/settings/domain/entities"
)

// ISettingsRepository defines the contract for settings data access
type ISettingsRepository interface {
	// GetUserSettings retrieves settings for a specific user
	GetUserSettings(ctx context.Context, userID string) (*entities.UserSettings, error)

	// UpdateUserSettings updates or creates user settings (upsert)
	UpdateUserSettings(ctx context.Context, settings *entities.UserSettings) error

	// CreateDefaultSettings creates default settings for a new user
	CreateDefaultSettings(ctx context.Context, userID string) error
}
