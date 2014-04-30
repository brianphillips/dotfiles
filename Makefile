install: install-vim install-git install-sh install-smartcd install-z
	git config user.email brian@thephillips.info

install-vim:
	ln -nfs `pwd`/vim ~/.vim
	ln -fs ~/.vim/vimrc ~/.vimrc

install-git:
	ln -fs `pwd`/git/gitconfig ~/.gitconfig
	ln -nfs `pwd`/git/template ~/.git_template

install-sh:
	ln -fs `pwd`/bashrc ~/.bashrc
	ln -fs `pwd`/environment.sh ~/.environment.sh

install-zsh: install-oh-my-zsh
	ln -fs `pwd`/zshrc ~/.zshrc

install-smartcd: 
	@if [ ! -d ~/.smartcd ]; then curl --silent -L http://smartcd.org/install | bash; fi

install-smartcd-templates: install-smartcd
	ln -nfs `pwd`/smartcd/templates ~/.smartcd/templates

install-oh-my-zsh:
	@if [ ! -d ~/.oh-my-zsh ]; then curl --silent -L http://install.ohmyz.sh | sh; fi
	ln -fs `pwd`/zsh/my.zsh-theme ~/.oh-my-zsh/themes/my.zsh-theme
	echo Oh My ZSH installed!

install-z:
	@if [ ! -d `pwd`/z ]; then git clone git@github.com:rupa/z.git; fi
	ln -fs `pwd`/z/z.sh ~/.z.sh

install-tig:
	@if [ ! -d `pwd`/tig ]; then git clone git@github.com:jonas/tig.git; fi
	cd tig && ./autogen.sh && ./configure --prefix=$$HOME/opt && make && make install

install-vim-binary:
	@if [ ! -d `pwd`/vim74 ]; then wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2 && tar jxf vim-7.4.tar.bz2 && rm vim-7.4.tar.bz2; fi
	cd vim74 && LDFLAGS=-L/home/bphillips/opt/lib ./configure --enable-pythoninterp --enable-cscope --prefix=/home/bphillips/opt && make && make install
