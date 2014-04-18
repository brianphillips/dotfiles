install: install-vim install-git install-sh install-smartcd
	git config user.email brian@thephillips.info

install-vim:
	ln -fs `pwd`/vim ~/.vim
	ln -fs ~/.vim/vimrc ~/.vimrc

install-git:
	ln -fs `pwd`/git/gitconfig ~/.gitconfig
	ln -fs `pwd`/git/template ~/.git_template

install-sh:
	ln -fs `pwd`/bashrc ~/.bashrc

install-zsh: install-oh-my-zsh
	ln -fs `pwd`/zshrc ~/.zshrc

install-smartcd: 
	@curl --silent -L http://smartcd.org/install | bash
	ln -fs `pwd`/smartcd/templates ~/.smartcd/templates

install-oh-my-zsh:
	@if [ ! -d ~/.oh-my-zsh ]; then curl --silent -L http://install.ohmyz.sh | sh; fi
	ln -fs `pwd`/zsh/my.zsh-theme ~/.oh-my-zsh/themes/my.zsh-theme
	echo Oh My ZSH installed!
