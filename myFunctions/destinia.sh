function sshdes(){
	COMMANDS='cd /usr/local/global_local/logs/; export GREP_OPTIONS='--color=always'; bash'
	echo "ssh -t \"$COMMANDS\" $1"

	ssh $1 -t "$COMMANDS"
}