install: install-vim install-git install-sh install-smartcd

install-vim:
	rm -rf ~/.vim ~/.vimrc
	ln -s `pwd`/vim ~/.vim
	ln -s ~/.vim/vimrc ~/.vimrc

install-git:
	rm -f ~/.gitconfig
	ln -s `pwd`/git/gitconfig ~/.gitconfig
	rm -rf ~/.git_template
	ln -s `pwd`/git/template ~/.git_template

install-sh:
	rm -f ~/.bashrc
	ln -s `pwd`/bashrc ~/.bashrc

install-zsh: install-oh-my-zsh
	rm -f ~/.zshrc
	ln -s `pwd`/zshrc ~/.zshrc

install-smartcd:
	curl -L http://smartcd.org/install | bash

install-oh-my-zsh:
	curl -L http://install.ohmyz.sh | sh
	ln -s `pwd`/zsh/my.zsh-theme ~/.oh-my-zsh/themes/my.zsh-theme
