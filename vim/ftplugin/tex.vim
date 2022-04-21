setlocal textwidth=80
autocmd VimLeave *.tex !cleantex %

noremap <F3> :LLPStartPreview<CR>
noremap <F4> :CocCommand latex.ForwardSearch<CR>
noremap <F5> :CocCommand workspace.showOutput<CR>
noremap <F6> :CocCommand latex.Build<CR>
noremap <F7> :exec 'VimtexCompile' <bar> vert copen 60<bar> wincmd h<CR>
noremap <F8> :exec 'VimtexTocToggle' <bar> wincmd l<CR>
