package application

import (
	"context"
	"database/sql"
	"fmt"

	"github.com/mibi2007/familytree/familytree_go/internal/features/settings/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/features/settings/domain/entities"
)

// SettingsService handles business logic for user settings
type SettingsService struct {
	repo domain.ISettingsRepository
}

// NewSettingsService creates a new settings service
func NewSettingsService(repo domain.ISettingsRepository) *SettingsService {
	return &SettingsService{
		repo: repo,
	}
}

// GetUserSettings retrieves settings for a user, creating defaults if not found
func (s *SettingsService) GetUserSettings(ctx context.Context, userID string) (*entities.UserSettings, error) {
	if userID == "" {
		return nil, fmt.Errorf("user ID is required")
	}

	settings, err := s.repo.GetUserSettings(ctx, userID)
	if err != nil {
		// If settings don't exist, create default settings
		if err == sql.ErrNoRows || (err != nil && err.Error() == "settings not found for user "+userID+": sql: no rows in result set") {
			if createErr := s.repo.CreateDefaultSettings(ctx, userID); createErr != nil {
				return nil, fmt.Errorf("failed to create default settings: %w", createErr)
			}
			// Retrieve the newly created settings
			settings, err = s.repo.GetUserSettings(ctx, userID)
			if err != nil {
				return nil, fmt.Errorf("failed to get newly created settings: %w", err)
			}
		} else {
			return nil, fmt.Errorf("failed to get user settings: %w", err)
		}
	}

	return settings, nil
}

// UpdateUserSettings updates user settings with validation
func (s *SettingsService) UpdateUserSettings(ctx context.Context, settings *entities.UserSettings) (*entities.UserSettings, error) {
	if settings == nil {
		return nil, fmt.Errorf("settings cannot be nil")
	}

	if settings.UserID == "" {
		return nil, fmt.Errorf("user ID is required")
	}

	// Validate theme mode
	if !s.isValidThemeMode(settings.ThemeMode) {
		return nil, fmt.Errorf("invalid theme mode: %s", settings.ThemeMode)
	}

	// Validate language
	if !s.isValidLanguage(settings.Language) {
		return nil, fmt.Errorf("invalid language: %s", settings.Language)
	}

	// Update settings
	if err := s.repo.UpdateUserSettings(ctx, settings); err != nil {
		return nil, fmt.Errorf("failed to update settings: %w", err)
	}

	// Return updated settings
	return s.repo.GetUserSettings(ctx, settings.UserID)
}

// isValidThemeMode validates theme mode
func (s *SettingsService) isValidThemeMode(mode entities.ThemeMode) bool {
	switch mode {
	case entities.ThemeModeLight, entities.ThemeModeDark, entities.ThemeModeSystem:
		return true
	default:
		return false
	}
}

// isValidLanguage validates language
func (s *SettingsService) isValidLanguage(lang entities.Language) bool {
	switch lang {
	case entities.LanguageVi, entities.LanguageEn:
		return true
	default:
		return false
	}
}
