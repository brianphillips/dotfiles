" Auto-commands {{{2

" reset autocommands so that they aren't processed twice
autocmd!

au BufNewFile,BufRead *.twig  set ft=html.twig
au BufNewFile,BufRead *.tt2  setf tt2html
au BufNewFile,BufRead *.t  setf perl
au BufNewFile,BufRead *.psgi  setf perl
au BufNewFile,BufRead *.md set ft=markdown
au BufNewFile,BufRead *.mh  set ft=mason
au BufNewFile,BufRead *.mhtml  setf mason
au FileType xml setlocal foldmethod=syntax

au ColorScheme * highlight Normal ctermbg=None
au ColorScheme * highlight NonText ctermbg=None

" see http://stackoverflow.com/questions/4630892/vim-folds-open-up-when-giving-an-unmatched-opening-brace-parenthesis/4654859#4654859
au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
au InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
" }}}2

" Vim Addon Manager Setup {{{2
fun MyPoolFun()
  let d = vam#install#Pool()
  let d['perltest'] = { 'type' : 'git', 'url' : 'git://github.com/threebytesfull/perltest' }
  let d['vim-rubocop']  = { 'type' : 'git', 'url' : 'git://github.com/ngmy/vim-rubocop' }
  let d['vim-mocha'] = { 'type' : 'git', 'url' : 'git://github.com/geekjuice/vim-mocha' }
	let d['floobits-vim'] = { 'type' : 'git', 'url' : 'git://github.com/Floobits/floobits-vim' }
	let d['vim-json'] = { 'type' : 'git', 'url' : 'git://github.com/elzr/vim-json' }
	let d['vim-dragvisuals'] = { 'type' : 'git', 'url' : 'git://github.com/atweiden/vim-dragvisuals' }
  return d
endf
let g:vim_addon_manager = {}
let g:vim_addon_manager.pool_fun = function('MyPoolFun')


fun! EnsureVamIsOnDisk(vam_install_path)
  if !filereadable(a:vam_install_path.'/vim-addon-manager/.git/config')
     \&& 1 == confirm("Clone VAM into ".a:vam_install_path."?","&Y\n&N")
    call mkdir(a:vam_install_path, 'p')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.shellescape(a:vam_install_path, 1).'/vim-addon-manager'
    exec 'helptags '.fnameescape(a:vam_install_path.'/vim-addon-manager/doc')
  endif
endf

fun! SetupVAM()
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  call EnsureVamIsOnDisk(vam_install_path)
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'
  call vam#ActivateAddons([
		\ ], {'auto_install' : 1}
	\ )
endfun

call SetupVAM()
"}}}2

" VIM plugins {{{2
VAMActivate
	\ ctrlp
	\ desert256
	\ fugitive
	\	local_vimrc
	\	nginx
	\	Puppet_Syntax_Highlighting
	\	surround
	\	Syntastic
	\	Tagbar
	\	The_NERD_tree
	\	UltiSnips
	\	vim-airline
	\	vim-gitgutter
	\	vim-json
	\	vim-twig

let ft_addons = {
  \ 'perl': [ 'perltest', 'Perl_MooseXDeclare_Syntax' ],
  \ 'php':  [ 'phpfolding' ],
  \ 'ruby': [ 'Rubytest', 'vim-rubocop', 'vim-ruby' ],
	\ 'javascript': ['vim-mocha', 'Enhanced_Javascript_syntax'],
\ }
au FileType * for l in values(filter(copy(ft_addons), string(expand('<amatch>')).' =~ v:key')) | call vam#ActivateAddons(l, {'force_loading_plugins_now':1}) | endfor
"}}}2

" VIM settings {{{2
set nocompatible
let mapleader = ","
let maplocalleader = ","

syntax enable

set foldmethod=syntax
set foldlevel=1

colorscheme desert256
set t_Co=256
filetype plugin on
set shiftwidth=2
set tabstop=2
set smartindent

set noshowmode
set laststatus=2  " Always show status line
set autoread      " reload a file that has been changed on disk
set pastetoggle=<F2>

set fileencodings=ucs-bom,utf-8,default,latin1,8bit-cp1252
hi CursorLine   cterm=NONE ctermbg=235
hi CursorColumn cterm=NONE ctermbg=235
set hlsearch
" }}}2

" Plugin settings {{{2
"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:ctrlp_max_files = 25000
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']

let g:fugitive_github_domains = ['https://github.shuttercorp.net']

let NERDTreeIgnore=['venv[[dir]]','.pyc$[[file]]']

let g:gitgutter_sign_column_always = 1
let g:gitgutter_realtime = 0

let g:syntastic_ruby_checkers = ['mri', 'rubocop']

let g:airline_powerline_fonts = 1

" }}}2

" Mappings {{{2
noremap <F3> :set hlsearch! hlsearch?<CR>
nmap :Q :q

nmap <leader>e :NERDTreeToggle<CR>
nmap <leader>n :NERDTreeFind<CR>

map <leader>gs :Gstatus<CR>
map <leader>gc :Gcommit<CR>
map <leader>gd :Gdiff<CR>
map <leader>gt :Extradite<CR>
map <leader>gb :Gblame<CR>
"}}}2

" vim: set foldmethod=marker:
