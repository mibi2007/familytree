package application_test

import (
	"context"
	"testing"

	"github.com/mibi2007/familytree/familytree_go/internal/features/settings/application"
	"github.com/mibi2007/familytree/familytree_go/internal/features/settings/domain/entities"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
	"github.com/stretchr/testify/require"
)

// MockSettingsRepository is a mock implementation of ISettingsRepository
type MockSettingsRepository struct {
	mock.Mock
}

func (m *MockSettingsRepository) GetUserSettings(ctx context.Context, userID string) (*entities.UserSettings, error) {
	args := m.Called(ctx, userID)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).(*entities.UserSettings), args.Error(1)
}

func (m *MockSettingsRepository) UpdateUserSettings(ctx context.Context, settings *entities.UserSettings) error {
	args := m.Called(ctx, settings)
	return args.Error(0)
}

func (m *MockSettingsRepository) CreateDefaultSettings(ctx context.Context, userID string) error {
	args := m.Called(ctx, userID)
	return args.Error(0)
}

func TestSettingsService_GetUserSettings_Success(t *testing.T) {
	repo := new(MockSettingsRepository)
	service := application.NewSettingsService(repo)
	ctx := context.Background()

	userID := "user-123"
	expectedSettings := &entities.UserSettings{
		UserID:    userID,
		ThemeMode: entities.ThemeModeLight,
		Language:  entities.LanguageEn,
	}

	repo.On("GetUserSettings", ctx, userID).Return(expectedSettings, nil)

	settings, err := service.GetUserSettings(ctx, userID)
	require.NoError(t, err)
	assert.Equal(t, expectedSettings, settings)
	repo.AssertExpectations(t)
}

func TestSettingsService_UpdateUserSettings_Success(t *testing.T) {
	repo := new(MockSettingsRepository)
	service := application.NewSettingsService(repo)
	ctx := context.Background()

	settings := &entities.UserSettings{
		UserID:    "user-456",
		ThemeMode: entities.ThemeModeDark,
		Language:  entities.LanguageEn,
	}

	repo.On("UpdateUserSettings", ctx, settings).Return(nil)
	repo.On("GetUserSettings", ctx, settings.UserID).Return(settings, nil)

	updated, err := service.UpdateUserSettings(ctx, settings)
	require.NoError(t, err)
	assert.Equal(t, settings, updated)
	repo.AssertExpectations(t)
}

func TestSettingsService_UpdateUserSettings_Validation(t *testing.T) {
	repo := new(MockSettingsRepository)
	service := application.NewSettingsService(repo)
	ctx := context.Background()

	// Test empty user ID
	_, err := service.UpdateUserSettings(ctx, &entities.UserSettings{
		UserID: "",
	})
	assert.Error(t, err)

	// Test invalid theme
	_, err = service.UpdateUserSettings(ctx, &entities.UserSettings{
		UserID:    "user-789",
		ThemeMode: "invalid",
		Language:  entities.LanguageEn,
	})
	assert.Error(t, err)
}
