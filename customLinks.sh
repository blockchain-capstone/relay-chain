#!/bin/zsh

command=$1

init_rpc=26657
init_faucet=4500

alias ignite="~/Desktop/capstone/ignite"

value=`cat ~/Desktop/capstone/chainCounter`

rel_conf() {
	ignite relayer configure -a \
	--source-rpc "http://0.0.0.0:$1" \
	--source-faucet "http://0.0.0.0:$2" \
	--source-port "topic" \
	--source-version "topic-1" \
	--source-account "default" \
	--source-gasprice "0.0000025stake" \
	--source-prefix "cosmos" \
	--source-gaslimit 300000 \
	--target-rpc "http://0.0.0.0:$3" \
	--target-faucet "http://0.0.0.0:$4" \
	--target-port "topic" \
	--target-version "topic-1" \
	--target-account "default" \
	--target-gasprice "0.0000025stake" \
	--target-prefix "cosmos" \
	--target-gaslimit 300000
}

if [ "$command" = "chain-init" ];
then
	if [ "$2" = "relay-1" ];
	then
		echo 1 > ~/Desktop/capstone/chainCounter
	else
		echo $((value+1)) > ~/Desktop/capstone/chainCounter
	fi
	ignite chain serve -c $2.yml && value=`cat ~/Desktop/capstone/chainCounter` && echo $((value-1)) > ~/Desktop/capstone/chainCounter
elif [ "$command" = "relayer-remove" ];
then
	rm -rf ~/.ignite/relayer
elif [ "$command" = "relayer-configure" ];
then
	rel_conf $2 $3 $4 $5
elif [ "$command" = "relayer-connect" ];
then
	ignite relayer connect
elif [ "$command" = "send-message" ];
then
	relay-chaind tx topic send-ibc-post topic channel-$7 $2 $3 --from $4 --chain-id $5 --home ~/.$5 --node tcp://localhost:$6
elif [ "$command" = "rec-list" ];
then
	relay-chaind q topic list-post --node tcp://localhost:$2
elif [ "$command" = "sent-list" ];
then
	relay-chaind q topic list-sent-post --node tcp://localhost:$2
elif [ "$command" = "send-timedout-message" ];
then
	relay-chaind tx topic send-ibc-post topic channel-$7 $2 $3 --from $4 --chain-id $5 --home ~/.$5 --packet-timeout-timestamp $6 --node tcp://localhost:$7
elif [ "$command" = "timedout-list" ];
then
	relay-chaind q topic list-timedout-post --node tcp://localhost:$2
elif [ "$command" = "ibc-configure" ];
	then
		for ((i=1;i<value;i++));
		do
			rel_conf $init_rpc $init_faucet $((init_rpc += 2)) $((++init_faucet))
		done
		init_rpc=26657
		init_faucet=4500
		value=`cat ~/Desktop/capstone/chainCounter`
		if [ $value -gt 9 ] && [ $value -lt 100 ];
		then
			rel_conf $init_rpc $init_faucet $((init_rpc + value/2*2)) $((init_faucet + value/2))

			rel_conf $((init_rpc + (($value/4))*2)) $((init_faucet + ($value/4))) $((init_rpc + (($value*3/4))*2)) $((init_faucet + (($value*3/4))))
		fi
else
	echo "Wrong command"
fi
