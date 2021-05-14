" vim: foldmethod=manual
set nocompatible

" dirs
set undofile
set swapfile
set writebackup
set viminfo='100,/50,:100,n$XDG_CONFIG_HOME/vim/viminfo/info
set backupdir             =$XDG_CONFIG_HOME/vim/backup//
set undodir               =$XDG_CONFIG_HOME/vim/undo//
set viewdir               =$XDG_CONFIG_HOME/vim/view//
set directory             =$XDG_CONFIG_HOME/vim/swap//
set runtimepath          +=$XDG_CONFIG_HOME/vim
set runtimepath          +=$FILES/vim
set runtimepath          +=$VIMRUNTIME

" set
set autochdir
set encoding=utf-8 fileencoding=utf-8
set viewoptions-=options shortmess+=AF
set clipboard=unnamed
set hidden switchbuf=usetab
set updatetime=300 lazyredraw
set signcolumn=yes cursorline
set laststatus=2 statusline=%f\ \ %y%m%r%h%w%=(%l,%v)\ [%p%%,%L]\ %n
set showtabline=2
set conceallevel=3
set foldclose=all foldopen=hor foldmethod=indent foldminlines=3
set shiftwidth=4 tabstop=4 softtabstop=4
set autoindent smartindent
set number relativenumber
set scrolloff=7 sidescrolloff=7
set ignorecase smartcase
set incsearch hlsearch
set wildmenu
set splitbelow splitright
set matchpairs+=<:>
set list listchars=tab:\|\ ,trail:~
set fillchars=fold:\ 

" let
let g:netrw_home = "$XDG_CONFIG_HOME/vim"
let g:netrw_altv = 1           " splitright
let g:netrw_alto = 0           " splitbelow
let g:netrw_banner = 0         " no banner
let g:netrw_preview = 0        " preview horizontaly
let g:netrw_winsize   = 70     " preview size 70%
let g:netrw_liststyle = 3      " tree style
let g:netrw_list_hide= '^\..*' " hide dot files
let g:netrw_browse_split = 0   " <CR> opens in current window
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"

" autocmd
augroup vimrc
	autocmd!
	autocmd FileType     tex,markdown  set textwidth=80
	autocmd FileType     python,java   set expandtab
	autocmd BufRead      *             set noreadonly
	autocmd BufWrite     *             mkview
	autocmd FileType     *             silent! loadview
	autocmd FileType     help          wincmd L | vertical resize 88
	autocmd CmdlineLeave :             echo ''
	autocmd BufWritePost vimrc.vim     silent source %
augroup END

runtime plugins.vim
runtime highlighting.vim
runtime functions.vim
runtime maps.vim
