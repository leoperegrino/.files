" plugins

" vundle
filetype off
set rtp+=~/.config/vim/bundle/Vundle.vim
call vundle#begin('~/.config/vim/bundle')
Plugin 'VundleVim/Vundle.vim'
"
"Plugin 'mbbill/undotree'
"Plugin 'preservim/nerdtree'
"Plugin 'preservim/nerdcommenter'
"Plugin 'mg979/vim-visual-multi'
"
"Plugin 'mboughaba/i3config.vim'
"Plugin 'baskerville/vim-sxhkdrc'
"Plugin 'lervag/vimtex'
"Plugin 'xuhdev/vim-latex-live-preview'
"Plugin 'vim-pandoc/vim-pandoc-syntax'
"Plugin 'dkarter/bullets.vim'
"
"Plugin 'lilydjwg/colorizer'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'challenger-deep-theme/vim', {'name': 'challenger-deep-theme'}
call vundle#end()
filetype plugin indent on

" vimplug
"call plug#begin('~/.config/vim/plugged')
"Plug 'ojroques/vim-scrollstatus'
"Plug 'junegunn/goyo.vim'
"Plug 'neoclide/coc.nvim'
"call plug#end()

" variables

" airline
let g:airline_powerline_fonts = 1
"let g:airline_section_x = '%{ScrollStatus()}'
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
autocmd BufNewFile * AirlineTheme deus
autocmd BufReadPre * AirlineTheme deus

" pandoc/md/tex
"let g:pandoc#modules#disabled = ["spell"]
"let g:tex_flavor = 'latex'
"let g:vimtex_fold_enabled=1
"let g:vimtex_complete_enabled=0
"let g:instant_markdown_autostart = 0
"let g:livepreview_previewer = 'zathura'
"let g:pandoc#syntax#conceal#urls = 1
"autocmd! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
"autocmd FileType tex noremap <F5> :LLPStartPreview<CR>
"autocmd BufRead *.i3config set filetype=i3config

" jupyter
"let g:slime_paste_file = "$XDG_CACHE_HOME/slime_paste"
"let g:jupyter_mapkeys=0

" coc
"let g:coc_config_home = '$XDG_CONFIG_HOME/coc'
"set updatetime=300
""
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>" "
""
"if has('nvim')
"	inoremap <silent><expr> <c-space> coc#refresh()
"	inoremap <expr> <c-space> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"	inoremap <silent><expr> <c-space> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
"else
"	inoremap <silent><expr> <c-@> coc#refresh()
"	inoremap <expr> <c-@> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"	inoremap <silent><expr> <c-@> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
"endif
"autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
"nmap <F2> <Plug>(coc-rename)

" NERD
"let NERDDefaultAlign='start'
"let NERDCreateDefaultMappings=0
"let NERDTreeShowHidden=1
"let NERDTreeQuitOnOpen=1
"nmap <F1> :call NERDComment('n','toggle')<CR>
"vmap <F1> :call NERDComment('x','toggle')<CR>
"noremap <F10> :NERDTreeToggle<CR>
"noremap <F12> :UndotreeToggle<CR>

" goyo
"let g:limelight_conceal_ctermfg=1
"let g:goyo_width = "50%"
"let g:goyo_height = "100%"
"so $HOME/bin/vim/goyo.vim
"autocmd! User GoyoLeave nested call Goyo_leave()
"noremap <F11> :Goyo \| set nu rnu \| redraw!<CR>
