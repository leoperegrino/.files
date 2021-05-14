" plugins

" vimplug
call plug#begin('~/.config/vim/plugged')
	Plug 'VundleVim/Vundle.vim'
	Plug 'neoclide/coc.nvim'
	"
	Plug 'preservim/tagbar'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'xuhdev/vim-latex-live-preview'
	"Plun 'mg979/vim-visual-multi'
	"
	Plug 'dkarter/bullets.vim'
	Plug 'junegunn/limelight.vim'
	Plug 'junegunn/goyo.vim'
	Plug 'vim-pandoc/vim-pandoc-syntax'
	Plug 'sheerun/vim-polyglot'
	"
	Plug 'ajmwagar/vim-deus'
	Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
call plug#end()

runtime coc.vim
runtime goyo.vim

let g:livepreview_previewer = 'zathura'
let g:colorizer_maxlines = 100
let g:limelight_priority = -1
let g:limelight_paragraph_span = 1
let g:limelight_conceal_ctermfg = 240
let g:goyo_width = "50%"
let g:goyo_height = "100%"
autocmd! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
