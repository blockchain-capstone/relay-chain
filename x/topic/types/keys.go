package types

const (
	// ModuleName defines the module name
	ModuleName = "topic"

	// StoreKey defines the primary module store key
	StoreKey = ModuleName

	// RouterKey defines the module's message routing key
	RouterKey = ModuleName

	// MemStoreKey defines the in-memory store key
	MemStoreKey = "mem_topic"

	// Version defines the current version the IBC module supports
	Version = "topic-1"

	// PortID is the default port id that module binds to
	PortID = "topic"
)

var (
	// PortKey defines the key to store the port ID in store
	PortKey = KeyPrefix("topic-port-")
)

func KeyPrefix(p string) []byte {
	return []byte(p)
}

const (
	PostKey      = "Post/value/"
	PostCountKey = "Post/count/"
)

const (
	SentPostKey      = "SentPost/value/"
	SentPostCountKey = "SentPost/count/"
)

const (
	TimedoutPostKey      = "TimedoutPost/value/"
	TimedoutPostCountKey = "TimedoutPost/count/"
)
