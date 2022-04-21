" vim: foldmethod=marker
set nocompatible

" dirs {{{
set undofile
set swapfile
set writebackup
set runtimepath^=$XDG_DATA_HOME/vim
set runtimepath^=$XDG_CONFIG_HOME/vim
set runtimepath^=$XDG_CONFIG_HOME/vim/vimscript
set runtimepath^=$XDG_CONFIG_HOME/vim/vimscript/user
if ! has('nvim')
	set term=alacritty
	set viminfo     ='100,/50,:100
	set viminfofile =$XDG_DATA_HOME/vim/info
	set undodir     =$XDG_DATA_HOME/vim/undo/    | call mkdir(&undodir,   'p')
	set directory   =$XDG_DATA_HOME/vim/swap//   | call mkdir(&directory, 'p')
	set backupdir   =$XDG_DATA_HOME/vim/backup// | call mkdir(&backupdir, 'p')
	set viewdir     =$XDG_DATA_HOME/vim/view//   | call mkdir(&viewdir,   'p')
endif
" }}}

" set {{{
set autochdir
set nowrap
set encoding=utf-8 fileencoding=utf-8 fileformat=unix
set viewoptions-=options sessionoptions-=options
set shortmess+=AFI shortmess-=S
set formatoptions-=cro
set clipboard=unnamed
set noshowmode
set hidden
set startofline
set switchbuf=usetab
set updatetime=300 lazyredraw
set signcolumn=yes cursorline colorcolumn=79
set laststatus=2 showtabline=2
set conceallevel=3
set foldclose=
set foldopen+=insert,jump foldopen-=block
set foldmethod=syntax
set foldminlines=3 foldlevelstart=1
set shiftwidth=4 tabstop=4 softtabstop=4
set scrolloff=7 sidescrolloff=15
set number relativenumber
set autoindent smartindent
set splitbelow splitright
set ignorecase smartcase infercase
set incsearch hlsearch
set wildmenu wildignorecase
set wildignore+=*.pyc,*pycache*
set matchpairs+=<:>
set list listchars=tab:\▎\ ,trail:~
set fillchars=fold:\ 
" }}}

" let {{{
let mapleader = " "
let g:xml_syntax_folding = 1
let g:tex_flavor = "latex"
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[2 q"
" }}}

" autocmd {{{
augroup vimrc
	autocmd!
	autocmd FileType     *  silent! loadview
	autocmd FileType     qf nnoremap <buffer> <CR> <CR>:lclose<CR>
	autocmd BufWrite     *  mkview
	autocmd BufEnter     *  set formatoptions-=cro
	autocmd BufEnter     *  set noreadonly
	autocmd InsertEnter  *  set nolist
	autocmd InsertLeave  *  set list
	autocmd CmdlineLeave :  echo ''
	autocmd VimEnter     *  exec 'silent! !echo -ne "\e[2 q"' | redraw!
augroup END
" }}}

" neo {{{
if has('nvim')
	lua require("user")
else
	runtime user.vim
endif
" }}}
