export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="my"
POWERLINE_HIDE_USER_NAME=1

function dir_name {
	[ -f $PWD/.dir-name ] && cat $PWD/.dir-name || echo "${PWD/#$HOME/~}"
}

plugins=(git screen tmux)
source "$HOME/.environment.sh"
source $ZSH/oh-my-zsh.sh

[[ -r "$HOME/.smartcd_config" ]] && source ~/.smartcd_config

[ -f "$HOME/.z.sh" ] && source "$HOME/.z.sh"
