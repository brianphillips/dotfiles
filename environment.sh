export EDITOR='vim'
export PATH="$HOME/bin:$HOME/opt/bin:/opt/git/bin:$PATH"
export LANG=en_US.UTF-8
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

# Predictable SSH authentication socket location.
SOCK="$HOME/.ssh/ssh-auth-sock"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f $SOCK
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi

if [ -z "$SSH_TTY" ]; then
	GREP=/bin/grep
	agent_pid=`/bin/ps -ef | $GREP ssh-agent | $GREP -v grep | /usr/bin/awk '{print $2}' | xargs`

	if [ "$agent_pid" = "" ]; then
		 # there is no agent running
		 if [ -e "$HOME/agent.sh" ]; then
				# remove the old file
				/bin/rm -f $HOME/agent.sh
		 fi
		 # start a new agent
		 /usr/bin/ssh-agent | $GREP -v echo >&$HOME/agent.sh
	fi

	if [ ! -e $HOME/agent.sh ]; then
		# an agent is running, but started through some other means...
		#	echo "export SSH_AUTH_SOCK=$(ls /tmp/ssh-*/agent.*)" > ~/agent.sh
		#	echo "export SSH_AGENT_PID=$agent_pid" > ~/agent.sh
	fi

	test -e $HOME/agent.sh && source $HOME/agent.sh
	if ! ssh-add -L | $GREP --quiet ssh; then
		ssh-add
	fi
fi
