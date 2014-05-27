export EDITOR='vim'
export PATH="$HOME/bin:$HOME/opt/bin:$PATH"
export LANG=en_US.UTF-8
export TERM=xterm-256color

# Predictable SSH authentication socket location.
SOCK="$HOME/.ssh/ssh-auth-sock"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f $SOCK
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi
