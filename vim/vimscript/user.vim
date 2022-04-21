runtime plugins.vim
silent! colorscheme deus

runtime user/init.vim

let g:fzf_action = {'ctrl-x': 'tab split', 'ctrl-v': 'vsplit'}
let g:colorizer_auto_filetype='css,html'
let g:bullets_enabled_file_types = ['tex', 'markdown', 'pandoc', 'text', 'gitcommit']

nnoremap <silent> K :call ShowDoc()<CR>
nnoremap <silent> <leader>b :Buffers<CR>
noremap  <silent> <leader>g :GFiles<CR>
noremap  <silent> <leader>t :ToggleTerm<CR>
nnoremap <F1>  :Commentary<CR>
nnoremap <F2>  :call CocActionAsync('rename')<CR>
nnoremap <F9>  :NERDTreeToggle<CR>
nnoremap <F10> :Goyo<CR>
nnoremap <F11> :UndotreeToggle<CR>
nnoremap <F12> :exec 'TagbarToggle' <bar> wincmd l<CR>
