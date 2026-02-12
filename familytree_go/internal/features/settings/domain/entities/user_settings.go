package entities

import "time"

// ThemeMode represents the theme preference
type ThemeMode string

const (
	ThemeModeLight  ThemeMode = "light"
	ThemeModeDark   ThemeMode = "dark"
	ThemeModeSystem ThemeMode = "system"
)

// Language represents the language preference
type Language string

const (
	LanguageVi Language = "vi" // Vietnamese
	LanguageEn Language = "en" // English
)

// UserSettings represents user preferences
type UserSettings struct {
	UserID                    string    `json:"user_id"`
	ThemeMode                 ThemeMode `json:"theme_mode"`
	Language                  Language  `json:"language"`
	EmailNotificationsEnabled bool      `json:"email_notifications_enabled"`
	PushNotificationsEnabled  bool      `json:"push_notifications_enabled"`
	CreatedAt                 time.Time `json:"created_at"`
	UpdatedAt                 time.Time `json:"updated_at"`
}

// DefaultSettings returns default settings for a new user
func DefaultSettings(userID string) *UserSettings {
	return &UserSettings{
		UserID:                    userID,
		ThemeMode:                 ThemeModeSystem,
		Language:                  LanguageVi,
		EmailNotificationsEnabled: true,
		PushNotificationsEnabled:  true,
		CreatedAt:                 time.Now(),
		UpdatedAt:                 time.Now(),
	}
}
