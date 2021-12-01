" vim: foldmethod=marker
set nocompatible
set term=alacritty

" dirs {{{
set undofile
set swapfile
set writebackup
set viminfo     ='100,/50,:100
set viminfofile =$XDG_DATA_HOME/vim/info
set undodir     =$XDG_DATA_HOME/vim/undo//   | call mkdir(&undodir,   'p')
set directory   =$XDG_DATA_HOME/vim/swap//   | call mkdir(&directory, 'p')
set backupdir   =$XDG_DATA_HOME/vim/backup// | call mkdir(&backupdir, 'p')
set viewdir     =$XDG_DATA_HOME/vim/view//   | call mkdir(&viewdir,   'p')
set runtimepath^=$XDG_DATA_HOME/vim
set runtimepath^=$XDG_CONFIG_HOME/vim
set runtimepath+=$VIMRUNTIME
" }}}

" set {{{
set autochdir
set encoding=utf-8 fileencoding=utf-8
set viewoptions-=options sessionoptions-=options
set shortmess+=AFI shortmess-=S
set clipboard=unnamed
set hidden
set nostartofline
set switchbuf=usetab
set lazyredraw updatetime=300
set signcolumn=yes cursorline colorcolumn=79
set laststatus=2 showtabline=2
set conceallevel=3
set foldclose=
set foldopen+=insert,jump foldopen-=block
set foldmethod=syntax
set foldminlines=3
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
set list listchars=tab:\|\ ,trail:~
set fillchars=fold:\ 
" }}}

" let {{{
let g:xml_syntax_folding=1
let g:tex_flavor = "latex"
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"
" }}}

" autocmd {{{
augroup vimrc
	autocmd!
	autocmd FileType pandoc,markdown,tex set textwidth=80
	autocmd FileType       python        set et fdm=indent fdl=1 fdn=2
	autocmd FileType       zsh           set filetype=sh
	autocmd FileType    scss,css         set foldminlines=0
	autocmd FileType      xml            set foldlevel=1
	autocmd VimLeave       *.tex         !cleantex %
	autocmd BufRead        *             set noreadonly
	autocmd BufWrite       *             mkview
	autocmd BufWinEnter    *             if &ft == 'help' | wincmd L | endif
	autocmd FileType       *             silent! loadview
	autocmd InsertEnter    *             set nolist
	autocmd InsertLeave    *             set list
	autocmd CmdlineLeave   :             echo ''
augroup END
" }}}

runtime plugins.vim
runtime netrw.vim
runtime functions.vim
runtime maps.vim
runtime highlighting.vim
runtime statusline.vim
