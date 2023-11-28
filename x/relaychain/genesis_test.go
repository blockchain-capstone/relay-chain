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

		PostList: []types.Post{
		{
			Id: 0,
		},
		{
			Id: 1,
		},
	},
	PostCount: 2,
	// this line is used by starport scaffolding # genesis/test/state
	}

	k, ctx := keepertest.RelaychainKeeper(t)
	relaychain.InitGenesis(ctx, *k, genesisState)
	got := relaychain.ExportGenesis(ctx, *k)
	require.NotNil(t, got)

	nullify.Fill(&genesisState)
	nullify.Fill(got)

	require.ElementsMatch(t, genesisState.PostList, got.PostList)
require.Equal(t, genesisState.PostCount, got.PostCount)
// this line is used by starport scaffolding # genesis/test/assert
}
