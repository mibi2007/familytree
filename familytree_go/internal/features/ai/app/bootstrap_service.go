package app

import (
	"context"
	"fmt"

	"github.com/mibi2007/familytree/familytree_go/internal/features/ai/data/genkit"
)

// BootstrapService owns AI foundation initialization and readiness.
type BootstrapService struct {
	provider *genkit.Provider
}

func NewBootstrapService(cfg genkit.ProviderConfig) *BootstrapService {
	return NewBootstrapServiceWithProvider(genkit.NewProvider(cfg))
}

func NewBootstrapServiceWithProvider(provider *genkit.Provider) *BootstrapService {
	return &BootstrapService{provider: provider}
}

// Initialize validates AI config and creates the configured provider runtime.
func (s *BootstrapService) Initialize(ctx context.Context) error {
	if s.provider == nil {
		return fmt.Errorf("ai provider is not configured")
	}
	if err := s.provider.Initialize(ctx); err != nil {
		return fmt.Errorf("ai bootstrap failed: %w", err)
	}
	return nil
}

func (s *BootstrapService) Enabled() bool {
	return s.provider != nil && s.provider.Enabled()
}

func (s *BootstrapService) ProviderName() string {
	if s.provider == nil {
		return ""
	}
	return s.provider.Name()
}

func (s *BootstrapService) Ready() bool {
	return s.provider != nil && s.provider.Ready()
}
