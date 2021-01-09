set nocompatible

" dir
set undofile
set shortmess+=A
set path+=$HOME/bin/vim
set path+=$HOME/.files/vim
set undodir=$XDG_CONFIG_HOME/vim/undo//
set directory=$XDG_CONFIG_HOME/vim/swap//
set backupdir=$XDG_CONFIG_HOME/vim/backup//
set runtimepath+=$VIMRUNTIME
set runtimepath+=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after
set runtimepath+=$HOME/.files/vim,$HOME/bin/vim
if !has('nvim')
	set viewdir=$XDG_CONFIG_HOME/vim/view/vim//
	set viminfo='100,/50,:100,n$XDG_CONFIG_HOME/vim/viminfo/info
else
	set viewdir=$XDG_CONFIG_HOME/vim/view/nvim/
endif

" set
"set colorcolumn=80
"set viewoptions-=options
set foldmethod=manual
set conceallevel=2
set foldtext=foldtext()
set foldclose=all
set foldopen=all
set encoding=utf-8
set fileencoding=utf-8
set ignorecase
set smartcase
set wildmenu
set autoindent
set nu rnu
set showcmd
set incsearch
set hlsearch
set splitbelow
set splitright
set scrolloff=7
set shiftwidth=4
set tabstop=4
set softtabstop=4
set listchars=tab:\|\ ,trail:~
set fillchars=fold:\ 
set list

" autocmd
autocmd! FileType help wincmd L
autocmd! FileType man wincmd L
autocmd! BufWrite * mkview
autocmd! FileType * silent! loadview
autocmd! BufRead * set noreadonly
autocmd! BufWrite xresources silent! !xrdb -merge %
autocmd! BufEnter,FocusGained * set relativenumber
autocmd! BufLeave,FocusLost   * set norelativenumber
autocmd! BufNewFile,BufFilePre,BufRead *.tex set updatetime=700
autocmd! BufNewFile,BufFilePre,BufRead *.java set expandtab

runtime plugins.vim

" highlight
syntax on
colorscheme challenger_deep
hi conceal ctermbg=NONE
hi normal ctermbg=NONE
hi folded ctermbg=NONE
hi linenr ctermbg=NONE
hi linenr ctermfg=228
hi comment ctermfg=245
hi folded ctermfg=228
hi pmenu ctermbg=236
hi pmenu ctermfg=228
hi visual ctermbg=240
hi nontext ctermfg=238
hi specialkey ctermfg=238
hi! link cursorlinenr linenr
"hi cursorlinenr ctermbg=NONE
"hi cursorlinenr ctermfg=228
"hi ColorColumn ctermbg=NONE

" leader maps
let mapleader = " "
noremap <leader><leader> :
"
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>aq :qa<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>WW :silent w ! sudo tee >/dev/null  % <CR>
"
nnoremap <leader>C :setlocal spell! spelllang=en_us<CR>
nnoremap <leader>c :setlocal spell! spelllang=pt_br<CR>
nnoremap <leader>H :noh<CR>
noremap <leader>P "0p
"
noremap <leader>h <C-w>H
noremap <leader>j <C-w>J
noremap <leader>k <C-w>K
noremap <leader>l <C-w>L
noremap <leader>p :tabp<CR>
noremap <leader>n :tabn<CR>
nnoremap <leader>T :tabedit 
nnoremap <leader>S :vsplit 
nnoremap <leader>1 :bp<CR>
nnoremap <leader>2 :bn<CR>
"
nnoremap <leader>F vipzf}j
nnoremap <leader>D mmgg:vsplit %<CR>
			\:set so=0<CR>
			\zRLzt
			\:set scb<CR>
			\<C-w><C-h>:set scb<CR>
			\'mzz

" F maps
nnoremap <F3> :!python -i %<CR>

" ctrl maps
vmap <C-c> "+y
vmap <C-x> "+c<ESC>
"
nnoremap r <C-r>
noremap <C-p> jzz
noremap <C-e> kzz
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-f> :vert res -5<CR>
noremap <C-b> :vert res +5<CR>
noremap <C-n> :res -5<CR>
noremap <C-m> :res +5<CR>

nmap Y y$
nmap < <<
nmap > >>
vnoremap < <gv
vnoremap > >gv
