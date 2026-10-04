package genkit

import (
	"context"
	"testing"

	firebasegenkit "github.com/firebase/genkit/go/genkit"
	"github.com/stretchr/testify/require"
)

func TestProviderInitialize_DisabledDoesNotCreateRuntime(t *testing.T) {
	called := false
	provider := newProvider(ProviderConfig{}, func(context.Context, string) *firebasegenkit.Genkit {
		called = true
		return firebasegenkit.Init(context.Background())
	})

	err := provider.Initialize(context.Background())

	require.NoError(t, err)
	require.False(t, called)
	require.True(t, provider.Ready())
	require.Nil(t, provider.Runtime())
}

func TestProviderInitialize_EnabledCreatesGeminiRuntime(t *testing.T) {
	var receivedKey string
	runtime := firebasegenkit.Init(context.Background())
	provider := newProvider(ProviderConfig{
		Enabled:      true,
		ProviderName: " GEMINI ",
		GeminiAPIKey: " test-key ",
	}, func(_ context.Context, apiKey string) *firebasegenkit.Genkit {
		receivedKey = apiKey
		return runtime
	})

	err := provider.Initialize(context.Background())

	require.NoError(t, err)
	require.Equal(t, "test-key", receivedKey)
	require.Equal(t, GeminiProvider, provider.Name())
	require.Same(t, runtime, provider.Runtime())
	require.True(t, provider.Ready())
}

func TestProviderInitialize_EnabledRejectsUnsupportedProvider(t *testing.T) {
	provider := NewProvider(ProviderConfig{
		Enabled:      true,
		ProviderName: "other",
		GeminiAPIKey: "test-key",
	})

	err := provider.Initialize(context.Background())

	require.ErrorContains(t, err, "unsupported ai provider")
	require.False(t, provider.Ready())
}

func TestProviderInitialize_EnabledRejectsBlankGeminiKey(t *testing.T) {
	provider := NewProvider(ProviderConfig{
		Enabled:      true,
		ProviderName: GeminiProvider,
		GeminiAPIKey: "   ",
	})

	err := provider.Initialize(context.Background())

	require.ErrorContains(t, err, "GEMINI_API_KEY")
	require.False(t, provider.Ready())
}

func TestProviderInitialize_NilRuntimeFails(t *testing.T) {
	provider := newProvider(ProviderConfig{
		Enabled:      true,
		ProviderName: GeminiProvider,
		GeminiAPIKey: "test-key",
	}, func(context.Context, string) *firebasegenkit.Genkit { return nil })

	err := provider.Initialize(context.Background())

	require.ErrorContains(t, err, "returned no runtime")
	require.False(t, provider.Ready())
}
