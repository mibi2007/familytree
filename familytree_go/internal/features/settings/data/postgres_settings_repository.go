package data

import (
	"context"
	"database/sql"
	"fmt"
	"time"

	"github.com/mibi2007/familytree/familytree_go/internal/features/settings/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/features/settings/domain/entities"
)

// PostgresSettingsRepository implements ISettingsRepository using PostgreSQL
type PostgresSettingsRepository struct {
	db *sql.DB
}

// NewPostgresSettingsRepository creates a new PostgreSQL settings repository
func NewPostgresSettingsRepository(db *sql.DB) domain.ISettingsRepository {
	return &PostgresSettingsRepository{db: db}
}

// GetUserSettings retrieves settings for a specific user
func (r *PostgresSettingsRepository) GetUserSettings(ctx context.Context, userID string) (*entities.UserSettings, error) {
	query := `
		SELECT user_id, theme_mode, language, email_notifications_enabled, 
		       push_notifications_enabled, created_at, updated_at
		FROM user_settings
		WHERE user_id = $1
	`

	var settings entities.UserSettings
	var themeMode, language string

	err := r.db.QueryRowContext(ctx, query, userID).Scan(
		&settings.UserID,
		&themeMode,
		&language,
		&settings.EmailNotificationsEnabled,
		&settings.PushNotificationsEnabled,
		&settings.CreatedAt,
		&settings.UpdatedAt,
	)

	if err != nil {
		if err == sql.ErrNoRows {
			return nil, fmt.Errorf("settings not found for user %s: %w", userID, err)
		}
		return nil, fmt.Errorf("failed to get user settings: %w", err)
	}

	settings.ThemeMode = entities.ThemeMode(themeMode)
	settings.Language = entities.Language(language)

	return &settings, nil
}

// UpdateUserSettings updates or creates user settings (upsert)
func (r *PostgresSettingsRepository) UpdateUserSettings(ctx context.Context, settings *entities.UserSettings) error {
	query := `
		INSERT INTO user_settings (
			user_id, theme_mode, language, email_notifications_enabled,
			push_notifications_enabled, created_at, updated_at
		) VALUES ($1, $2, $3, $4, $5, $6, $7)
		ON CONFLICT (user_id) 
		DO UPDATE SET
			theme_mode = EXCLUDED.theme_mode,
			language = EXCLUDED.language,
			email_notifications_enabled = EXCLUDED.email_notifications_enabled,
			push_notifications_enabled = EXCLUDED.push_notifications_enabled,
			updated_at = $7
	`

	now := time.Now()
	if settings.CreatedAt.IsZero() {
		settings.CreatedAt = now
	}
	settings.UpdatedAt = now

	_, err := r.db.ExecContext(ctx, query,
		settings.UserID,
		string(settings.ThemeMode),
		string(settings.Language),
		settings.EmailNotificationsEnabled,
		settings.PushNotificationsEnabled,
		settings.CreatedAt,
		settings.UpdatedAt,
	)

	if err != nil {
		return fmt.Errorf("failed to update user settings: %w", err)
	}

	return nil
}

// CreateDefaultSettings creates default settings for a new user
func (r *PostgresSettingsRepository) CreateDefaultSettings(ctx context.Context, userID string) error {
	defaultSettings := entities.DefaultSettings(userID)
	return r.UpdateUserSettings(ctx, defaultSettings)
}
