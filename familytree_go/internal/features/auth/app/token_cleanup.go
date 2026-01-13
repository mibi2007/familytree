package app

import (
	"context"
	"log"
	"time"

	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/domain"
)

type TokenCleanupJob struct {
	repo domain.TokenRepository
}

func NewTokenCleanupJob(repo domain.TokenRepository) *TokenCleanupJob {
	return &TokenCleanupJob{repo: repo}
}

func (j *TokenCleanupJob) Start(ctx context.Context, interval time.Duration) {
	ticker := time.NewTicker(interval)
	defer ticker.Stop()

	log.Printf("Token cleanup job started (interval: %v)", interval)

	for {
		select {
		case <-ctx.Done():
			log.Println("Token cleanup job stopping...")
			return
		case <-ticker.C:
			count, err := j.repo.DeleteExpired(ctx)
			if err != nil {
				log.Printf("Error during token cleanup: %v", err)
			} else if count > 0 {
				log.Printf("Cleaned up %d expired tokens", count)
			}
		}
	}
}
