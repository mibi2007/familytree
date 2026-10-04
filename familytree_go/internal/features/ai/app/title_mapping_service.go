package app

import "context"

// EmptyTitleMappingService is a safe fallback for isolated tests or deployments without kinship data.
type EmptyTitleMappingService struct{}

func (EmptyTitleMappingService) BuildTitleMapping(context.Context, string, string) (map[string]string, error) {
	return map[string]string{}, nil
}
