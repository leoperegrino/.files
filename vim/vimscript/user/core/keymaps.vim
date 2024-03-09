" vim: foldmethod=marker

" leader maps {{{
noremap           <leader><leader> :
nnoremap <silent> <leader>s <cmd>w<CR>
nnoremap <silent> <leader>q <cmd>q<CR>
nnoremap <silent> <leader>Q <cmd>q!<CR>
nnoremap <silent> <leader>wq <cmd>wq<CR>
nnoremap <silent> <leader>WW <cmd>silent w ! sudo tee >/dev/null  % <CR>
nnoremap <silent> <leader>C <cmd>setlocal spell! spelllang=en_us<CR>
nnoremap <silent> <leader>c <cmd>setlocal spell! spelllang=pt_br<CR>
nnoremap <silent> <leader>H <cmd>noh<CR>
noremap  <silent> <leader>1 <cmd>tabp<CR>
noremap  <silent> <leader>2 <cmd>tabn<CR>
nnoremap          <leader>T :tabedit 
nnoremap          <leader>S :vsplit 
nnoremap <silent> <leader>p <cmd>bp<CR>
nnoremap <silent> <leader>n <cmd>bn<CR>
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
noremap  <C-h> <cmd>wincmd h<CR>
noremap  <C-j> <cmd>wincmd j<CR>
noremap  <C-k> <cmd>wincmd k<CR>
noremap  <C-l> <cmd>wincmd l<CR>
noremap  <C-f> <cmd>vert res -5<CR>
noremap  <C-b> <cmd>vert res +5<CR>
noremap  <C-s> <cmd>res -5<CR>
noremap  <C-g> <cmd>res +5<CR>
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
nnoremap K <cmd>execute 'vert' &keywordprg expand('<cword>')<CR>
nnoremap H <cmd>execute 'match DiffAdd /'.expand('<cword>').'/'<CR>
noremap  gf <cmd>e <cfile><CR>
noremap  gF <cmd>vsplit <cfile><CR>
nnoremap yu <cmd>let @/='\<' . expand('<cword>') . '\>' <BAR> set hlsearch<CR>
nnoremap yU <cmd>let @/= expand('<cword>') <BAR> set hlsearch<CR>
nnoremap <silent><esc> <cmd>noh <bar> match none<CR><esc>
nnoremap <esc>^[ <esc>^[
" }}}

command! -nargs=1 -complete=highlight FH exec 'filter /\c.*' . substitute('<args>', ' ', '\\\&\.\*', '') . '/ hi'
command! -nargs=1 -complete=command H vert help <args>
