set nocompatible

set undofile
set undodir=$XDG_DATA_HOME/vim/undo
set directory=$XDG_DATA_HOME/vim/swap
set backupdir=$XDG_DATA_HOME/vim/backup
set viminfo+=n$XDG_DATA_HOME/vim/viminfo
set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after

filetype off                  
set rtp+=~/.local/share/vim/bundle/Vundle.vim
call vundle#begin('~/.local/share/vim/bundle')
Plugin 'VundleVim/Vundle.vim'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
Plugin 'mbbill/undotree'
Plugin 'mboughaba/i3config.vim'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'dense-analysis/ale'
call vundle#end() 
filetype plugin indent on

call plug#begin('~/.local/share/vim/plugged')
Plug 'junegunn/vim-emoji'
call plug#end()
set completefunc=emoji#complete

let g:instant_markdown_autostart = 0
let g:instant_markdown_browser = "brave --new-window"

syntax on
autocmd BufWritePost *Xresources silent !xrdb %
autocmd BufRead *.i3config set filetype=i3config

set encoding=utf-8
set fileencoding=utf-8
set relativenumber
set autoindent
set ignorecase
set showcmd
set incsearch
set hlsearch
set splitbelow 
set splitright
set colorcolumn=80
set shiftwidth=4
set tabstop=4 
set softtabstop=4
 
let mapleader = " "
noremap <leader><leader> :
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>T :q!<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>r :redraw!<CR>
nnoremap <leader>p :!python -i %<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>i :InstantMarkdownPreview<CR>
nnoremap <leader>w!! :silent w ! sudo tee >/dev/null  % <CR>
nnoremap <leader>e :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>
nnoremap <leader>m :silent !pandoc % -o ~/.cache/mdown/%:r.pdf && okular ~/.cache/mdown/%:r.pdf &<CR>:redraw!<CR>

vmap <C-c> "+y
vmap <C-x> "+c<ESC>
vmap <C-p> c<ESC>"+p
imap <C-p> <ESC>"+pa

map <leader>h <C-w>h
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>l <C-w>l

map <leader>H :tabp<CR>
map <leader>J <C-w>j
map <leader>K <C-w>k
map <leader>L :tabn<CR>

nnoremap < <<
nnoremap > >>
