package keeper

import (
	"relay-chain/x/relaychain/types"
)

var _ types.QueryServer = Keeper{}
