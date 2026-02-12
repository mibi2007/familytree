package grpc

import (
	"context"

	"github.com/mibi2007/familytree/familytree_go/internal/features/settings/application"
	"github.com/mibi2007/familytree/familytree_go/internal/features/settings/domain/entities"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	settingsv1 "github.com/mibi2007/familytree/familytree_go/proto/settings/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/timestamppb"
)

// SettingsHandler implements the gRPC SettingsService
type SettingsHandler struct {
	settingsv1.UnimplementedSettingsServiceServer
	service *application.SettingsService
}

// NewSettingsHandler creates a new settings handler
func NewSettingsHandler(service *application.SettingsService) *SettingsHandler {
	return &SettingsHandler{
		service: service,
	}
}

// GetUserSettings retrieves user settings
func (h *SettingsHandler) GetUserSettings(ctx context.Context, req *settingsv1.GetUserSettingsRequest) (*settingsv1.GetUserSettingsResponse, error) {
	// Get authenticated user from context
	user := middleware.GetUser(ctx)
	if user == nil {
		return nil, status.Error(codes.Unauthenticated, "authentication required")
	}

	// Allow users to only get their own settings
	// (unless we want admins to view others' settings in the future)
	if req.UserId != user.UID {
		return nil, status.Error(codes.PermissionDenied, "can only access your own settings")
	}

	settings, err := h.service.GetUserSettings(ctx, req.UserId)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to get settings: %v", err)
	}

	return &settingsv1.GetUserSettingsResponse{
		Settings: toProtoSettings(settings),
	}, nil
}

// UpdateUserSettings updates user settings
func (h *SettingsHandler) UpdateUserSettings(ctx context.Context, req *settingsv1.UpdateUserSettingsRequest) (*settingsv1.UpdateUserSettingsResponse, error) {
	// Get authenticated user from context
	user := middleware.GetUser(ctx)
	if user == nil {
		return nil, status.Error(codes.Unauthenticated, "authentication required")
	}

	// Ensure user can only update their own settings
	if req.Settings.UserId != user.UID {
		return nil, status.Error(codes.PermissionDenied, "can only update your own settings")
	}

	// Convert proto to domain entity
	settings := toEntitySettings(req.Settings)

	// Update settings
	updatedSettings, err := h.service.UpdateUserSettings(ctx, settings)
	if err != nil {
		return nil, status.Errorf(codes.Internal, "failed to update settings: %v", err)
	}

	return &settingsv1.UpdateUserSettingsResponse{
		Settings: toProtoSettings(updatedSettings),
	}, nil
}

// toProtoSettings converts domain entity to proto message
func toProtoSettings(settings *entities.UserSettings) *settingsv1.UserSettings {
	var themeMode settingsv1.ThemeMode
	switch settings.ThemeMode {
	case entities.ThemeModeLight:
		themeMode = settingsv1.ThemeMode_THEME_MODE_LIGHT
	case entities.ThemeModeDark:
		themeMode = settingsv1.ThemeMode_THEME_MODE_DARK
	case entities.ThemeModeSystem:
		themeMode = settingsv1.ThemeMode_THEME_MODE_SYSTEM
	default:
		themeMode = settingsv1.ThemeMode_THEME_MODE_UNSPECIFIED
	}

	var language settingsv1.Language
	switch settings.Language {
	case entities.LanguageVi:
		language = settingsv1.Language_LANGUAGE_VI
	case entities.LanguageEn:
		language = settingsv1.Language_LANGUAGE_EN
	default:
		language = settingsv1.Language_LANGUAGE_UNSPECIFIED
	}

	return &settingsv1.UserSettings{
		UserId:                    settings.UserID,
		ThemeMode:                 themeMode,
		Language:                  language,
		EmailNotificationsEnabled: settings.EmailNotificationsEnabled,
		PushNotificationsEnabled:  settings.PushNotificationsEnabled,
		CreatedAt:                 timestamppb.New(settings.CreatedAt),
		UpdatedAt:                 timestamppb.New(settings.UpdatedAt),
	}
}

// toEntitySettings converts proto message to domain entity
func toEntitySettings(proto *settingsv1.UserSettings) *entities.UserSettings {
	var themeMode entities.ThemeMode
	switch proto.ThemeMode {
	case settingsv1.ThemeMode_THEME_MODE_LIGHT:
		themeMode = entities.ThemeModeLight
	case settingsv1.ThemeMode_THEME_MODE_DARK:
		themeMode = entities.ThemeModeDark
	case settingsv1.ThemeMode_THEME_MODE_SYSTEM:
		themeMode = entities.ThemeModeSystem
	default:
		themeMode = entities.ThemeModeSystem // Default to system
	}

	var language entities.Language
	switch proto.Language {
	case settingsv1.Language_LANGUAGE_VI:
		language = entities.LanguageVi
	case settingsv1.Language_LANGUAGE_EN:
		language = entities.LanguageEn
	default:
		language = entities.LanguageVi // Default to Vietnamese
	}

	settings := &entities.UserSettings{
		UserID:                    proto.UserId,
		ThemeMode:                 themeMode,
		Language:                  language,
		EmailNotificationsEnabled: proto.EmailNotificationsEnabled,
		PushNotificationsEnabled:  proto.PushNotificationsEnabled,
	}

	if proto.CreatedAt != nil {
		settings.CreatedAt = proto.CreatedAt.AsTime()
	}
	if proto.UpdatedAt != nil {
		settings.UpdatedAt = proto.UpdatedAt.AsTime()
	}

	return settings
}
