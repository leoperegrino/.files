runtime user/plugins/bootstrap.vim

" let g:polyglot_disabled = ['tex']

call plug#begin('~/.local/share/vim/plugged')
Plug 'preservim/tagbar'
Plug 'preservim/nerdtree'
Plug 'mbbill/undotree'
Plug 'ryanoasis/vim-devicons'
" Plug 'junegunn/vim-peekaboo'
" Plug 'junegunn/limelight.vim'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'dkarter/bullets.vim'
" Plug 'xuhdev/vim-latex-live-preview'
" Plug 'lervag/vimtex'
Plug 'chrisbra/Colorizer'
Plug 'sheerun/vim-polyglot'
Plug 'ajmwagar/vim-deus'
Plug 'neoclide/coc.nvim'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
call plug#end()

autocmd BufWritePost */user/plugins/init.vim execute 'source <afile> | PlugInstall'
