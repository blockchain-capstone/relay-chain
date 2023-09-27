package relaychain_test

import (
	"testing"

	"github.com/stretchr/testify/require"
	keepertest "relay-chain/testutil/keeper"
	"relay-chain/testutil/nullify"
	"relay-chain/x/relaychain"
	"relay-chain/x/relaychain/types"
)

func TestGenesis(t *testing.T) {
	genesisState := types.GenesisState{
		Params: types.DefaultParams(),

		// this line is used by starport scaffolding # genesis/test/state
	}

	k, ctx := keepertest.RelaychainKeeper(t)
	relaychain.InitGenesis(ctx, *k, genesisState)
	got := relaychain.ExportGenesis(ctx, *k)
	require.NotNil(t, got)

	nullify.Fill(&genesisState)
	nullify.Fill(got)

	// this line is used by starport scaffolding # genesis/test/assert
}
