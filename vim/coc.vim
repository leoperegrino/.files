" coc

set updatetime=300
set statusline^=%{coc#status()}\ %{get(b:,'coc_current_function','')}\ 
let g:coc_config_home = '$XDG_CONFIG_HOME/coc'
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
let g:coc_global_extensions = [ 
			\ 'coc-clangd',
			\ 'coc-jedi',
			\ 'coc-json',
			\ 'coc-rust-analyzer',
			\ 'coc-sh',
			\ 'coc-snippets',
			\ 'coc-texlab',
			\ 'coc-vimlsp'
			\ ]

" autocmd
augroup coc
	autocmd!
	" autocmd User CocStatusChange redraws
	autocmd CursorHold   *                  silent! call CocActionAsync('highlight')
	autocmd CompleteDone *                  if pumvisible() == 0 | silent! pclose | endif
	autocmd User         CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

" scroll pum
nnoremap <silent><nowait><expr> <C-g> coc#float#has_scroll() ? coc#float#scroll(1,2) : "\<C-g>"
nnoremap <silent><nowait><expr> <C-s> coc#float#has_scroll() ? coc#float#scroll(0,2) : "\<C-s>"
vnoremap <silent><nowait><expr> <C-g> coc#float#has_scroll() ? coc#float#scroll(1,2) : "\<C-g>"
vnoremap <silent><nowait><expr> <C-s> coc#float#has_scroll() ? coc#float#scroll(0,2) : "\<C-s>"
inoremap <silent><nowait><expr> <C-g> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1,1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-s> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0,1)\<cr>" : "\<Left>"

" select pum
inoremap <expr> <Tab>         pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab>       pumvisible() ? "\<C-p>" : "\<S-Tab>" "
inoremap <silent><expr> <C-@> pumvisible() ? coc#_select_confirm() : coc#refresh()

" etc
nmap <silent> çN <Plug>(coc-diagnostic-prev)
nmap <silent> çn <Plug>(coc-diagnostic-next)
