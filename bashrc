[[ $- == *i* ]] && [[ -r "$HOME/.zshrc" ]] && [[ "$0" != "-l" ]] && exec zsh

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

source "$HOME/.environment.sh"

[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config
[ -f "$HOME/.z.sh" ] && source "$HOME/.z.sh"
