package app

import (
	"context"
	"testing"

	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/data/genkit"
	"github.com/stretchr/testify/require"
)

func TestBootstrapService_Initialize_DisabledAI_AllowsMissingKey(t *testing.T) {
	svc := NewBootstrapService(genkit.ProviderConfig{
		Enabled:      false,
		ProviderName: "gemini",
	})

	err := svc.Initialize(context.Background())

	require.NoError(t, err)
	require.False(t, svc.Enabled())
	require.True(t, svc.Ready())
}

func TestBootstrapService_Initialize_EnabledAI_RequiresGeminiKey(t *testing.T) {
	svc := NewBootstrapService(genkit.ProviderConfig{
		Enabled:      true,
		ProviderName: "gemini",
	})

	err := svc.Initialize(context.Background())

	require.Error(t, err)
	require.ErrorContains(t, err, "GEMINI_API_KEY")
	require.False(t, svc.Ready())
}

func TestBootstrapService_Initialize_NilProviderFails(t *testing.T) {
	svc := NewBootstrapServiceWithProvider(nil)

	err := svc.Initialize(context.Background())

	require.ErrorContains(t, err, "provider is not configured")
	require.False(t, svc.Ready())
}
