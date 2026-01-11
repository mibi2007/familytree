package application

import (
	"sync"

	"github.com/mibi2007/familytree/familytree_go/internal/features/chat/domain"
)

type MemoryChatPublisher struct {
	mu          sync.RWMutex
	subscribers map[string][]chan *domain.Message
}

func NewMemoryChatPublisher() *MemoryChatPublisher {
	return &MemoryChatPublisher{
		subscribers: make(map[string][]chan *domain.Message),
	}
}

func (p *MemoryChatPublisher) Publish(msg *domain.Message) {
	p.mu.RLock()
	defer p.mu.RUnlock()

	subs, ok := p.subscribers[msg.FamilyID]
	if !ok {
		return
	}

	for _, ch := range subs {
		// Non-blocking send
		select {
		case ch <- msg:
		default:
		}
	}
}

func (p *MemoryChatPublisher) Subscribe(familyID string) (<-chan *domain.Message, func()) {
	p.mu.Lock()
	defer p.mu.Unlock()

	ch := make(chan *domain.Message, 10)
	p.subscribers[familyID] = append(p.subscribers[familyID], ch)

	cleanup := func() {
		p.mu.Lock()
		defer p.mu.Unlock()

		subs := p.subscribers[familyID]
		for i, s := range subs {
			if s == ch {
				p.subscribers[familyID] = append(subs[:i], subs[i+1:]...)
				close(ch)
				break
			}
		}
	}

	return ch, cleanup
}
