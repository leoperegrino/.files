set nocompatible

" dir options
set path+=~/bin/vim,~/.files/**
set undofile
set shortmess+=A
set undodir=$XDG_CONFIG_HOME/vim/undo//
set directory=$XDG_CONFIG_HOME/vim/swap//
set backupdir=$XDG_CONFIG_HOME/vim/backup//
if !has('nvim')
	set viewdir=$XDG_CONFIG_HOME/vim/view/vim//
	set viminfo='100,/50,:100,n$XDG_CONFIG_HOME/vim/viminfo/info
else
	set viewdir=$XDG_CONFIG_HOME/vim/view/nvim/
endif
set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after

" plugins options
"
" vundle options
filetype off
set rtp+=~/.config/vim/bundle/Vundle.vim
call vundle#begin('~/.config/vim/bundle')
Plugin 'VundleVim/Vundle.vim'
"
Plugin 'mbbill/undotree'
Plugin 'preservim/nerdtree'
Plugin 'preservim/nerdcommenter'
Plugin 'francoiscabrol/ranger.vim'
"Plugin 'ervandew/supertab'
"Plugin 'wmvanvliet/jupyter-vim.git'
"Plugin 'sillybun/vim-repl'
"Plugin 'jpalardy/vim-slime'
"Plugin 'hanschen/vim-ipython-cell'
"
Plugin 'mboughaba/i3config.vim'
Plugin 'baskerville/vim-sxhkdrc'
Plugin 'lervag/vimtex'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'dkarter/bullets.vim'
"
Plugin 'dracula/vim'
Plugin 'vim-airline/vim-airline'
Plugin 'lilydjwg/colorizer'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ryanoasis/vim-devicons'
Plugin 'challenger-deep-theme/vim', {'name': 'challenger-deep-theme'}
call vundle#end()
filetype plugin indent on
"
" vimplug options
call plug#begin('~/.config/vim/plugged')
Plug 'ojroques/vim-scrollstatus'
Plug 'junegunn/goyo.vim'
Plug 'neoclide/coc.nvim'
call plug#end()
"
" plugins variables
"
" pandoc/md/tex
"let g:pandoc#modules#disabled = ["spell"]
let g:tex_flavor = 'latex'
let g:vimtex_fold_enabled=1
let g:vimtex_complete_enabled=0
let g:instant_markdown_autostart = 0
let g:livepreview_previewer = 'zathura'
let g:pandoc#syntax#conceal#urls = 1
"
" jupyter
let g:slime_paste_file = "$XDG_CACHE_HOME/slime_paste"
let g:jupyter_mapkeys=0
"
" coc
let g:coc_config_home = '$XDG_CONFIG_HOME/coc'
set updatetime=300
"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>" "
"
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
	inoremap <expr> <c-space> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	inoremap <silent><expr> <c-space> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
else
	inoremap <silent><expr> <c-@> coc#refresh()
	inoremap <expr> <c-@> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	inoremap <silent><expr> <c-@> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
endif
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
"
" NERD
let NERDDefaultAlign='start'
let NERDCreateDefaultMappings=0
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
"
" airline
let g:airline_powerline_fonts = 1
let g:airline_section_x = '%{ScrollStatus()}'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_section_y = ''
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#fnamemode=':t'
"
" Goyo
"let g:limelight_conceal_ctermfg=1
let g:goyo_width = "50%"
let g:goyo_height = "100%"
so $BIN/vim/goyo.vim

" au options
"
" editor options
autocmd! FileType help wincmd L
autocmd! BufWrite * mkview
autocmd! FileType * silent! loadview
autocmd! BufRead * set noreadonly
autocmd! BufEnter,FocusGained * set relativenumber
autocmd! BufLeave,FocusLost   * set norelativenumber
autocmd! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
autocmd! BufNewFile,BufFilePre,BufRead *.tex set updatetime=700
autocmd! BufNewFile,BufFilePre,BufRead *.java set expandtab
"
" plugins au
autocmd FileType tex noremap <F5> :LLPStartPreview<CR>
autocmd BufRead *.i3config set filetype=i3config
autocmd FileType * AirlineTheme deus
autocmd! User GoyoLeave nested call Goyo_leave()
"
" view options
syntax on
colorscheme challenger_deep
hi conceal ctermbg=NONE
hi normal ctermbg=NONE
hi folded ctermbg=NONE
hi linenr ctermbg=NONE
"hi cursorlinenr ctermbg=NONE
"hi termcursor ctermfg=233
hi comment ctermfg=245
hi linenr ctermfg=228
"hi cursorlinenr ctermfg=228
hi folded ctermfg=228
hi pmenu ctermbg=236
hi pmenu ctermfg=228
hi visual ctermbg=240
hi nontext ctermfg=238
hi specialkey ctermfg=238
hi! link cursorlinenr linenr
"hi ColorColumn ctermbg=NONE
"set colorcolumn=80
set foldmethod=manual
set conceallevel=2
set foldtext=foldtext()
set foldclose=all
set foldopen=all
set encoding=utf-8
set fileencoding=utf-8
set guicursor=i:ver25
set guicursor=a:blinkon25
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

" map options
"
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
nnoremap <leader>D mmgg:vsplit %<CR>
			\:set so=0<CR>
			\zRLzt
			\:set scb<CR>
			\<C-w><C-h>:set scb<CR>
			\'mzz
"
" F maps
nmap <F1> :call NERDComment('n','toggle')<CR>
vmap <F1> :call NERDComment('x','toggle')<CR>
nmap <F2> <Plug>(coc-rename)
nnoremap <F3> :!python -i %<CR>
"
noremap <F10> :NERDTreeToggle<CR>
noremap <F11> :Goyo \| set nu rnu \| redraw!<CR>
noremap <F12> :UndotreeToggle<CR>
"
" ctrl maps
vmap <C-c> "+y
vmap <C-x> "+c<ESC>
"
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
"
nmap Y y$
nmap < <<
nmap > >>
vnoremap < <gv
vnoremap > >gv
