package genkit

import (
	"context"
	"testing"

	"github.com/firebase/genkit/go/ai"
	firebasegenkit "github.com/firebase/genkit/go/genkit"
	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/domain"
	"github.com/stretchr/testify/require"
)

func TestAgentGenerate_DisabledProviderIsUnavailable(t *testing.T) {
	provider := NewProvider(ProviderConfig{})
	require.NoError(t, provider.Initialize(context.Background()))

	_, err := NewAgent(provider).Generate(context.Background(), &domain.AIPrompt{Question: "hello"})

	require.ErrorIs(t, err, domain.ErrAIUnavailable)
}

func TestAgentGenerate_ReturnsProviderResponse(t *testing.T) {
	runtime := firebasegenkit.Init(context.Background())
	provider := newProvider(ProviderConfig{Enabled: true, ProviderName: GeminiProvider, GeminiAPIKey: "key"}, func(context.Context, string) *firebasegenkit.Genkit {
		return runtime
	})
	require.NoError(t, provider.Initialize(context.Background()))
	agent := NewAgent(provider)
	agent.generate = func(_ context.Context, received *firebasegenkit.Genkit, _ ...ai.GenerateOption) (string, error) {
		require.Same(t, runtime, received)
		return "answer", nil
	}

	result, err := agent.Generate(context.Background(), &domain.AIPrompt{Question: "hello"})

	require.NoError(t, err)
	require.Equal(t, &domain.AIRecommendation{Answer: "answer", Provider: GeminiProvider}, result)
}
