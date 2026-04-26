package gateway

import (
	"testing"

	"go.uber.org/zap"
)

func TestRemoveSkipsStaleConnection(t *testing.T) {
	manager := NewConnManager(zap.NewNop())

	current := &Conn{UserID: 1}
	stale := &Conn{UserID: 1}
	manager.conns[1] = current

	if manager.Remove(stale) {
		t.Fatal("stale connection should not be removed")
	}
	if got := manager.Get(1); got != current {
		t.Fatal("current connection was removed by stale connection")
	}
	if !manager.Remove(current) {
		t.Fatal("current connection should be removed")
	}
	if got := manager.Get(1); got != nil {
		t.Fatal("connection still exists after removing current connection")
	}
}
