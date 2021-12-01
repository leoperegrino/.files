" vim: foldmethod=marker

" cfg_vim_polyglot
let g:polyglot_disabled = ['sh', 'tex']

call plug#begin('~/.local/share/vim/plugged')
	Plug 'preservim/tagbar'              " cfg_tagbar
	Plug 'preservim/nerdtree'            " cfg_nerdtree
	Plug 'mbbill/undotree'               " cfg_undotree
	Plug 'ryanoasis/vim-devicons'        " cfg_vim_devicons
	Plug 'junegunn/vim-peekaboo'         " cfg_vim_peekaboo
	" Plug 'ron89/thesaurus_query.vim'     " cfg_thesaurus_query_vim
	" Plug 'junegunn/limelight.vim'        " cfg_limelight_vim
	Plug 'honza/vim-snippets'            " cfg_vim_snippets
	" Plug 'tpope/vim-surround'            " cfg_vim_surround
	Plug 'tpope/vim-commentary'          " cfg_vim_commentary
	Plug 'junegunn/fzf.vim'              " cfg_fzf_vim
	Plug 'junegunn/goyo.vim'             " cfg_goyo_vim
	Plug 'dkarter/bullets.vim'           " cfg_bullets_vim
	Plug 'xuhdev/vim-latex-live-preview' " cfg_vim_latex_live_preview
	Plug 'lervag/vimtex'                 " cfg_vimtex
	Plug 'chrisbra/Colorizer'            " cfg_Colorizer
	Plug 'sheerun/vim-polyglot'          " cfg_vim_polyglot
	Plug 'ajmwagar/vim-deus'             " cfg_vim_deus
	Plug 'neoclide/coc.nvim'             " cfg_coc_nvim
	" Plug 'vim-pandoc/vim-pandoc'         " cfg_vim_pandoc
	" Plug 'vim-pandoc/vim-pandoc-syntax'  " cfg_vim_pandoc_syntax
call plug#end()

" cfg_vim_deus
colorscheme deus

" cfg_nerdtree
let g:NERDTreeWinSize = 30
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 0
hi NERDTreeFlags ctermfg=2
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" cfg_undotree
let g:undotree_SplitWidth = 40
let g:undotree_DiffAutoOpen = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_HelpLine = 0
let g:undotree_WindowLayout = 4
let g:undotree_DiffpanelHeight = 7

" cfg_thesaurus_query_vim
" let g:tq_map_keys = 0

" cfg_limelight_vim
" let g:limelight_priority = -1
" let g:limelight_paragraph_span = 1
" let g:limelight_conceal_ctermfg = 240

" cfg_fzf_vim
let g:fzf_action = {'ctrl-x': 'tab split', 'ctrl-v': 'vsplit'}

" cfg_goyo_vim
runtime goyo.vim

" cfg_bullets_vim
let g:bullets_enabled_file_types = ['tex', 'markdown', 'pandoc', 'text', 'gitcommit']

" cfg_vim_latex_live_preview
let g:livepreview_previewer = 'zathura'
let g:livepreview_cursorhold_recompile = 0

" cfg_vimtex
" let g:vimtex_mappings_enabled = 0
let g:vimtex_compiler_method = 'arara'
let g:vimtex_view_method = 'zathura'
let g:vimtex_doc_handlers = ['MyHandler']
let g:vimtex_toc_config = {'split_width': 60, 'show_help': 0, 'split_pos': 'vert rightbelow', 'indent_levels': 1}
autocmd InsertEnter,InsertLeave *.tex let &l:textwidth = vimtex#syntax#in_mathzone() ? 0 : 80
autocmd BufRead *.tex set conceallevel=0
autocmd BufRead *.tex set fdm=manual
set wildignore+=*.acn,*.acr,*.alg,*.aux,*.bbl,*.bcf,*.blg,*.glg,*.glo,*.gls,*.ilg
set wildignore+=*.ist,*.lof,*.lot,*.nav,*.nlo,*.nls,*.out,*.run.xml,*.snm,*.tdo,*.toc,*.vrb
autocmd BufRead arara.log set foldmethod=marker
autocmd BufRead arara.log set foldmarker=----------------------\ BEGIN\ OUTPUT\ BUFFER\ ----------------------,\ END\ OUTPUT\ BUFFER\ 
function! MyHandler(context)
	call vimtex#doc#make_selection(a:context)
	if !empty(a:context.selected)
		silent! execute '!vimtexdoc' a:context.selected '&'
		redraw!
	endif
	return 1
endfunction

" cfg_vim_pandoc
" let g:pandoc#keyboard#use_default_mappings = 0
" let g:pandoc#biblio#bibs = ['/home/leop/documents/tex/master.bib']
" let g:pandoc#modules#disabled = ["hypertext", "formatting", "folding", "metadata", "keyboard", "spell"]
" let g:pandoc#folding#fold_yaml = 1

" cfg_Colorizer
let g:colorizer_auto_filetype='css,html'

" cfg_coc_nvim
runtime coc.vim
