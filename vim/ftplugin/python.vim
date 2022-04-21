setlocal expandtab
setlocal noautochdir
setlocal foldlevel=1
setlocal foldnestmax=2

noremap <F4> :silent vert term ipython -i %<CR>
