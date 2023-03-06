" vim: foldmethod=marker

" leader maps {{{
noremap           <leader><leader> :
nnoremap <silent> <leader>s :w<CR>
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>Q :q!<CR>
nnoremap <silent> <leader>wq :wq<CR>
nnoremap <silent> <leader>WW :silent w ! sudo tee >/dev/null  % <CR>
nnoremap <silent> <leader>C :setlocal spell! spelllang=en_us<CR>
nnoremap <silent> <leader>c :setlocal spell! spelllang=pt_br<CR>
nnoremap <silent> <leader>H :noh<CR>
noremap  <silent> <leader>1 :tabp<CR>
noremap  <silent> <leader>2 :tabn<CR>
nnoremap          <leader>T :tabedit 
nnoremap          <leader>S :vsplit 
nnoremap <silent> <leader>p :bp<CR>
nnoremap <silent> <leader>n :bn<CR>
nnoremap          <leader>vb :vert sb 
noremap  <silent> <leader>h <C-w>H
noremap  <silent> <leader>j <C-w>J
noremap  <silent> <leader>k <C-w>K
noremap  <silent> <leader>l <C-w>L
nnoremap <silent> <leader>8 ]s
nnoremap <silent> <leader>9 1z=
nnoremap <silent> <leader>0 [s
vnoremap <silent> <leader>f zfk2j
nnoremap <silent> <leader>F vipzf}j
noremap  <silent> <leader>P "0p
" }}}

" ctrl maps {{{
vnoremap <C-c> "+y
vnoremap <C-x> "+c<ESC>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-e> <ESC>A
inoremap <C-a> <ESC>I
noremap  <C-r> <Nop>
noremap  <C-p> kzz
noremap  <C-n> jzz
noremap  <C-h> :wincmd h<CR>
noremap  <C-j> :wincmd j<CR>
noremap  <C-k> :wincmd k<CR>
noremap  <C-l> :wincmd l<CR>
noremap  <C-f> :vert res -5<CR>
noremap  <C-b> :vert res +5<CR>
noremap  <C-s> :res -5<CR>
noremap  <C-g> :res +5<CR>
tnoremap  <C-j> <C-\><C-N><C-w>j
tnoremap  <C-k> <C-\><C-N><C-w>k
tnoremap  <C-l> <C-\><C-N><C-w>l
tnoremap  <C-w><C-w> <C-\><C-N>
" }}}

" maps {{{
nmap     <  <<
nmap     >  >>
vnoremap < <gv
vnoremap > >gv
nnoremap _ -
nnoremap r <C-r>
vnoremap J dp1V
nnoremap Y  y$
nnoremap K :execute 'vert' &keywordprg expand('<cword>')<CR>
nnoremap H :execute 'match DiffAdd /'.expand('<cword>').'/'<CR>
noremap  gf :e <cfile><CR>
noremap  gF :vsplit <cfile><CR>
nnoremap yu :let @/='\<' . expand('<cword>') . '\>' <BAR> set hlsearch<CR>
nnoremap yU :let @/= expand('<cword>') <BAR> set hlsearch<CR>
nnoremap <silent><esc> :noh <bar> match none<CR><esc>
nnoremap <esc>^[ <esc>^[
" }}}

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

command! -nargs=1 -complete=highlight FH exec 'filter /\c.*' . substitute('<args>', ' ', '\\\&\.\*', '') . '/ hi'
command! -nargs=1 -complete=command H vert help <args>
