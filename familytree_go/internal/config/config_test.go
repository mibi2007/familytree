package config

import (
	"os"
	"testing"

	"github.com/stretchr/testify/require"
)

func TestLoad_AIDefaultsDisabledWithGeminiProvider(t *testing.T) {
	t.Chdir(t.TempDir())
	t.Setenv("APP_ENV", "test")
	require.NoError(t, os.Unsetenv("AI_ENABLED"))
	require.NoError(t, os.Unsetenv("AI_PROVIDER"))
	require.NoError(t, os.Unsetenv("GEMINI_API_KEY"))

	cfg := Load()

	require.False(t, cfg.AIEnabled)
	require.Equal(t, "gemini", cfg.AIProvider)
	require.Empty(t, cfg.GeminiAPIKey)
}

func TestLoad_AIConfigurationComesFromEnvironment(t *testing.T) {
	t.Chdir(t.TempDir())
	t.Setenv("APP_ENV", "test")
	t.Setenv("AI_ENABLED", "true")
	t.Setenv("AI_PROVIDER", "gemini")
	t.Setenv("GEMINI_API_KEY", "test-key")

	cfg := Load()

	require.True(t, cfg.AIEnabled)
	require.Equal(t, "gemini", cfg.AIProvider)
	require.Equal(t, "test-key", cfg.GeminiAPIKey)
}
