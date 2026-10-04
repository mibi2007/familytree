package genkit

import (
	"context"
	"encoding/json"
	"fmt"

	"github.com/firebase/genkit/go/ai"
	firebasegenkit "github.com/firebase/genkit/go/genkit"
	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/domain"
)

const defaultGeminiModel = "googleai/gemini-2.5-flash"

type Agent struct {
	provider *Provider
	generate func(context.Context, *firebasegenkit.Genkit, ...ai.GenerateOption) (string, error)
}

func NewAgent(provider *Provider) *Agent {
	return &Agent{provider: provider, generate: firebasegenkit.GenerateText}
}

func (a *Agent) Generate(ctx context.Context, prompt *domain.AIPrompt) (*domain.AIRecommendation, error) {
	if a == nil || a.provider == nil || !a.provider.Enabled() || !a.provider.Ready() || a.provider.Runtime() == nil {
		return nil, domain.ErrAIUnavailable
	}

	payload, err := json.Marshal(prompt)
	if err != nil {
		return nil, fmt.Errorf("encode ai prompt: %w", err)
	}
	answer, err := a.generate(ctx, a.provider.Runtime(),
		ai.WithModelName(defaultGeminiModel),
		ai.WithSystem("Answer only from the supplied selected-family context. If context is insufficient, say so. Do not infer access to other families or chats."),
		ai.WithPrompt(string(payload)),
	)
	if err != nil {
		return nil, fmt.Errorf("generate gemini response: %w", err)
	}
	return &domain.AIRecommendation{Answer: answer, Provider: a.provider.Name()}, nil
}
