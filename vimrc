set nocompatible

" dir options
set path+=~/bin,~/.files/**
set undofile
set undodir=$XDG_DATA_HOME/vim/undo
set directory=$XDG_DATA_HOME/vim/swap
set backupdir=$XDG_DATA_HOME/vim/backup
set viewdir=$XDG_DATA_HOME/vim/view
set viminfo='10,/50,:100,n$XDG_DATA_HOME/vim/viminfo/info
set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after

" plugins options

" vundle options
filetype off
set rtp+=~/.local/share/vim/bundle/Vundle.vim
call vundle#begin('~/.local/share/vim/bundle')
Plugin 'VundleVim/Vundle.vim'

Plugin 'ycm-core/YouCompleteMe'
Plugin 'dense-analysis/ale'
Plugin 'mbbill/undotree'
Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-fugitive'

"Plugin 'vim-latex/vim-latex'
"Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'mboughaba/i3config.vim'
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'dkarter/bullets.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ryanoasis/vim-devicons'
call vundle#end()
filetype plugin indent on

" vimplug options
call plug#begin('~/.local/share/vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'junegunn/seoul256.vim'
call plug#end()

" plugins variables
"let g:pandoc#modules#disabled = ["spell"]
let g:pandoc#syntax#conceal#urls = 1
let g:instant_markdown_autostart = 0
let g:instant_markdown_browser = "brave --new-window"

let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
"
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_section_y = ''
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#whitespace#enabled = 0

let g:goyo_width = "50%"
let g:goyo_height = "100%"
so $BIN/vim/goyo.vim

" au options

" editor options
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained * set relativenumber
  autocmd BufLeave,FocusLost   * set norelativenumber
augroup END
augroup pandoc_syntax
	au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
autocmd BufWrite * mkview
autocmd BufRead * silent loadview
autocmd BufRead * normal Mzz

" plugins au
autocmd BufWritePost *xresources silent !xrdb %
autocmd BufRead *.i3config set filetype=i3config
autocmd FileType * AirlineTheme bubblegum
autocmd BufRead *.md set foldmethod=manual | norm zM
autocmd! User GoyoLeave nested call Goyo_leave()

" view options

syntax on
hi folded ctermbg=NONE ctermfg=11
hi visual ctermbg=1
hi Conceal ctermbg=NONE
hi foldcolumn ctermbg=NONE
set foldtext=foldtext()
set foldmethod=manual
set foldclose=all
set foldopen=all
set conceallevel=2
set encoding=utf-8
set fileencoding=utf-8
set smartcase
set wildmenu
set autoindent
set nu rnu
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
set fillchars=fold:\ 
set list

" map options

" leader options
let mapleader = " "
noremap <leader><leader> :

nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>B :.!$SHELL<CR>
nnoremap <leader>WW :silent w ! sudo tee >/dev/null  % <CR>

nnoremap <leader>r :redraw!<CR>
nnoremap <leader>C :setlocal spell! spelllang=en_us<CR>
nnoremap <leader>c :setlocal spell! spelllang=pt_br<CR>
nnoremap <leader>H :noh<CR>

nnoremap <leader>g :Goyo \| set nu rnu \| redraw!<CR>
nnoremap <leader>p :!python -i %<CR>
nnoremap <leader>N :NERDTreeToggle<CR>
nnoremap <leader>u :UndotreeToggle<CR>

nnoremap <leader>tm :TableModeEnable<CR>
nnoremap <leader>i :InstantMarkdownPreview<CR>
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
vmap <C-y> c<ESC>"+P
imap <C-y> <ESC>"+pa
nmap <C-y> "+p<ESC>

noremap <C-p> <C-e>j
noremap <C-e> <C-y>k

let g:BASH_Ctrl_j = 'off'
let g:BASH_Ctrl_k = 'off'
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-i> :vert res -5<CR>
noremap <C-o> :vert res +5<CR>
noremap <C-n> :res -5<CR>
noremap <C-m> :res +5<CR>

nmap < <<
nmap > >>
vnoremap < <gv
vnoremap > >gv
