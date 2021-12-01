" vim: foldmethod=marker
"
" leader maps {{{
let mapleader = " "
noremap  <leader><leader> :
nnoremap <leader>s  :w<CR>
nnoremap <leader>q  :q<CR>
nnoremap <leader>Q  :q!<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>WW :silent w ! sudo tee >/dev/null  % <CR>
nnoremap <leader>C  :setlocal spell! spelllang=en_us<CR>
nnoremap <leader>c  :setlocal spell! spelllang=pt_br<CR>
noremap  <leader>G  :tab term ++close lazygit<CR>
noremap  <leader>P  "0p
noremap  <leader>h  <C-w>H
noremap  <leader>j  <C-w>J
noremap  <leader>k  <C-w>K
noremap  <leader>l  <C-w>L
noremap  <leader>1  :tabp<CR>
noremap  <leader>2  :tabn<CR>
nnoremap <leader>T  :tabedit 
nnoremap <leader>S  :vsplit 
nnoremap <leader>vb :vert sb 
nnoremap <leader>b  :Buffers<CR>
nnoremap <leader>p  :bp<CR>
nnoremap <leader>n  :bn<CR>
nnoremap <leader>8  [s
nnoremap <leader>9  1z=
nnoremap <leader>0  ]s
vnoremap <leader>f  zfk2j
nnoremap <leader>F  vipzf}j
" }}}

" F maps {{{
nnoremap  <F1>  :Commentary<CR>
nnoremap  <F2>  :call CocActionAsync('rename')<CR>
nnoremap  <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
nnoremap  <F9>  :NERDTreeToggle<CR>
nnoremap  <F10> :Goyo<CR>
nnoremap  <F11> :UndotreeToggle<CR>
nnoremap  <F12> :exec 'TagbarToggle' <bar> wincmd l<CR>
autocmd  FileType python           noremap <F4> :silent vert term ipython -i %<CR>
autocmd  FileType sh               noremap <F4> :silent vert term %<CR>
autocmd  FileType pandoc,markdown* noremap <F5> :call pandoc#toc#Show()<CR>
autocmd  FileType tex              noremap <F3> :LLPStartPreview<CR>
autocmd  FileType tex              noremap <F4> :CocCommand latex.ForwardSearch<CR>
autocmd  FileType tex              noremap <F5> :CocCommand workspace.showOutput<CR>
autocmd  FileType tex              noremap <F6> :CocCommand latex.Build<CR>
autocmd  FileType tex              noremap <F7> :exec 'VimtexCompile' <bar> vert copen 60<bar> wincmd h<CR>
autocmd  FileType tex              noremap <F8> :exec 'VimtexTocToggle' <bar> wincmd l<CR>
" }}}

" ctrl maps {{{
vmap     <C-c> "+y
inoremap <C-v> <ESC>"+pa
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-e> <ESC>A
inoremap <C-a> <ESC>I
nnoremap  <C-p> :call SmoothScroll('down')<CR>
nnoremap  <C-e> :call SmoothScroll('up')<CR>
nnoremap  <C-h> :wincmd h<CR>
nnoremap  <C-j> :wincmd j<CR>
nnoremap  <C-k> :wincmd k<CR>
nnoremap  <C-l> :wincmd l<CR>
nnoremap  <C-b> :vert res -5<CR>
nnoremap  <C-f> :vert res +5<CR>
nnoremap  <C-y> :res -5<CR>
nnoremap  <C-r> :res +5<CR>
" }}}

" maps {{{
noremap  gf :e <cfile><CR>
noremap  gF :vsplit <cfile><CR>
nmap     Y  y$
nmap     <  <<
nmap     >  >>
nnoremap r <C-r>
vnoremap J dp1V=gv
vnoremap K dkP1V=gv
vnoremap L lolo
vnoremap H hoho
vnoremap < <gv
vnoremap > >gv
nnoremap H :execute 'match DiffAdd /'.expand('<cword>').'/'<CR>
nnoremap <silent> K :call ShowDoc()<CR>
nnoremap <silent><esc> :noh <bar> match none<CR><esc>
nnoremap <esc>^[ <esc>^[
" }}}

command! -nargs=1 -complete=highlight FH exec 'filter /\c.*' . substitute('<args>', ' ', '\\\&\.\*', '') . '/ hi'
command! -nargs=1 -complete=option HP :vert help <args>
cabbrev help HP
cabbrev hp HP
