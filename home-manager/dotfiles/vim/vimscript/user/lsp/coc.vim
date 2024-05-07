" coc
set updatetime=300
let g:coc_config_home = '$XDG_CONFIG_HOME/coc'
let g:coc_data_home = '$XDG_DATA_HOME/coc'
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
let g:coc_global_extensions = [
			\ 'coc-clangd',
			\ 'coc-jedi',
			\ 'coc-json',
			\ 'coc-rust-analyzer',
			\ 'coc-snippets',
			\ 'coc-texlab',
			\ 'coc-vimlsp'
			\ ]

" autocmd
augroup coc
	autocmd!
	" autocmd User CocStatusChange redraws
	autocmd CursorHold           *          silent! call CocActionAsync('highlight')
	autocmd CompleteDone         *          if pumvisible() == 0 | silent! pclose | endif
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
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>" "

if has('nvim')| inoremap <expr><silent> <C-Space> pumvisible() ? coc#_select_confirm() : coc#refresh()
         else | inoremap <expr><silent> <C-@>     pumvisible() ? coc#_select_confirm() : coc#refresh()
endif

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :vsplit<CR> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gI <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> Ç  <Plug>(coc-diagnostic-prev)
nmap <silent> ç  <Plug>(coc-diagnostic-next)
nmap <silent><nowait> gA  :<C-u>CocList diagnostics<cr>

hi! link CocGitChangedSign diffChanged
hi! link CocGitAddedSign   diffAdded
hi! link CocGitRemovedSign diffRemoved
