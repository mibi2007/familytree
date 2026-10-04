package genkit

import (
	"context"
	"fmt"
	"strings"

	firebasegenkit "github.com/firebase/genkit/go/genkit"
	"github.com/firebase/genkit/go/plugins/googlegenai"
)

const GeminiProvider = "gemini"

// ProviderConfig configures the Gemini-backed Genkit runtime.
type ProviderConfig struct {
	Enabled      bool
	ProviderName string
	GeminiAPIKey string
}

// Validate validates provider configuration for bootstrap.
func (c ProviderConfig) Validate() error {
	if !c.Enabled {
		return nil
	}

	providerName := strings.ToLower(strings.TrimSpace(c.ProviderName))
	if providerName == "" {
		return fmt.Errorf("provider name is required when ai is enabled")
	}
	if providerName != GeminiProvider {
		return fmt.Errorf("unsupported ai provider: %s", c.ProviderName)
	}
	if strings.TrimSpace(c.GeminiAPIKey) == "" {
		return fmt.Errorf("GEMINI_API_KEY is required when ai is enabled")
	}

	return nil
}

type initializer func(context.Context, string) *firebasegenkit.Genkit

// Provider owns the optional Genkit runtime used by the AI module.
type Provider struct {
	cfg     ProviderConfig
	runtime *firebasegenkit.Genkit
	init    initializer
}

func NewProvider(cfg ProviderConfig) *Provider {
	return newProvider(cfg, initializeGemini)
}

func newProvider(cfg ProviderConfig, init initializer) *Provider {
	return &Provider{cfg: cfg, init: init}
}

// Initialize validates configuration and creates the Gemini-backed Genkit runtime when enabled.
func (p *Provider) Initialize(ctx context.Context) error {
	if err := p.cfg.Validate(); err != nil {
		return err
	}
	if !p.cfg.Enabled {
		return nil
	}
	if p.init == nil {
		return fmt.Errorf("genkit initializer is not configured")
	}

	p.runtime = p.init(ctx, strings.TrimSpace(p.cfg.GeminiAPIKey))
	if p.runtime == nil {
		return fmt.Errorf("genkit initializer returned no runtime")
	}
	return nil
}

func (p *Provider) Enabled() bool {
	return p.cfg.Enabled
}

func (p *Provider) Name() string {
	if !p.cfg.Enabled {
		return ""
	}
	return strings.ToLower(strings.TrimSpace(p.cfg.ProviderName))
}

func (p *Provider) Ready() bool {
	return !p.cfg.Enabled || p.runtime != nil
}

func (p *Provider) Runtime() *firebasegenkit.Genkit {
	return p.runtime
}

func initializeGemini(ctx context.Context, apiKey string) *firebasegenkit.Genkit {
	return firebasegenkit.Init(ctx,
		firebasegenkit.WithPlugins(&googlegenai.GoogleAI{APIKey: apiKey}),
	)
}
