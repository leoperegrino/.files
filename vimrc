set nocompatible
set foldmethod=manual

" dir options
set undofile 
set undodir=$XDG_DATA_HOME/vim/undo
set directory=$XDG_DATA_HOME/vim/swap
set backupdir=$XDG_DATA_HOME/vim/backup
set viewdir=$XDG_DATA_HOME/vim/view
set viminfo+=n$XDG_DATA_HOME/vim/viminfo
set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after

" plugins options
" vundle options
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
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-latex/vim-latex'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
call vundle#end() 
filetype plugin indent on
let g:instant_markdown_autostart = 0
let g:instant_markdown_browser = "brave --new-window"

" vimplug options
call plug#begin('~/.local/share/vim/plugged')
Plug 'junegunn/vim-emoji'
Plug 'junegunn/goyo.vim'
call plug#end()
set completefunc=emoji#complete

" au options
syntax on
autocmd BufWritePost *Xresources silent !xrdb %
autocmd BufRead *.i3config set filetype=i3config
autocmd BufWrite * mkview
autocmd BufRead * silent loadview
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained * set relativenumber
  autocmd BufLeave,FocusLost   * set norelativenumber
augroup END

" view options
set encoding=utf-8
set fileencoding=utf-8
set nu rnu
set autoindent
set showcmd
set incsearch
set hlsearch
set splitbelow 
set splitright
set colorcolumn=80
set shiftwidth=4
set tabstop=4 
set softtabstop=4
set listchars=tab:°\ ,trail:~
set list

" map options
nnoremap < <<
nnoremap > >>

" leader options
let mapleader = " "
noremap <leader><leader> :

nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>WW :silent w ! sudo tee >/dev/null  % <CR>

nnoremap <leader>r :redraw!<CR>
nnoremap <leader>c :setlocal spell! spelllang=en_us<CR>

nnoremap <leader>g :Goyo<CR>
nnoremap <leader>tm :TableModeEnable<CR>
nnoremap <leader>p :!python -i %<CR>
nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>i :InstantMarkdownPreview<CR>
nnoremap <leader>e :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>
nnoremap <leader>m :silent !pandoc % -o ~/.cache/mdown/%:r.pdf && okular ~/.cache/mdown/%:r.pdf &<CR>:redraw!<CR>

noremap <leader>h <C-w>H
noremap <leader>j <C-w>J
noremap <leader>k <C-w>K
noremap <leader>l <C-w>L
noremap <leader>p :tabp<CR>
noremap <leader>n :tabn<CR>

nnoremap <leader>T :tabedit 
nnoremap <leader>S :vsplit 

" ctrl options
vmap <C-c> "+y
vmap <C-x> "+c<ESC>
vmap <C-p> c<ESC>"+p
imap <C-p> <ESC>"+pa
nmap <C-p> i"+p<ESC>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-i> :vert res -5<CR>
noremap <C-o> :vert res +5<CR>
noremap <C-n> :res -5<CR>
noremap <C-m> :res +5<CR>
