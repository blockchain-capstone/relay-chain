package keeper

import (
	"relay-chain/x/topic/types"
)

var _ types.QueryServer = Keeper{}
