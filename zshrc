export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="my"
#POWERLINE_SHOW_GIT_ON_RIGHT=1
POWERLINE_HIDE_USER_NAME=1

plugins=(git screen tmux)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
export LANG=en_US.UTF-8

[[ -r "$HOME/.smartcd_config" ]] && source ~/.smartcd_config
