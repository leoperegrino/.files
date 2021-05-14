"
" leader maps
let mapleader = " "
noremap  <leader><leader> :
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>WW :silent w ! sudo tee >/dev/null  % <CR>
nnoremap <leader>C :setlocal spell! spelllang=en_us<CR>
nnoremap <leader>c :setlocal spell! spelllang=pt_br<CR>
nnoremap <leader>H :noh<CR>
noremap  <leader>g :tab term ++close lazygit<CR>
noremap  <leader>P "0p
noremap  <leader>h <C-w>H
noremap  <leader>j <C-w>J
noremap  <leader>k <C-w>K
noremap  <leader>l <C-w>L
noremap  <leader>p :tabp<CR>
noremap  <leader>n :tabn<CR>
nnoremap <leader>T :tabedit 
nnoremap <leader>S :vsplit 
nnoremap <leader>1 :bp<CR>
nnoremap <leader>2 :bn<CR>
nnoremap <leader>8 ]s
nnoremap <leader>9 1z=
nnoremap <leader>0 [s
vnoremap <leader>f zfk2j
nnoremap <leader>F vipzf}j
nnoremap <leader>D :call DualScreen()<CR>

" F maps
noremap  <F1> :Commentary<CR>
noremap  <F2> :call CocActionAsync('rename')<CR>
noremap  <F9> :call ToggleNetrw()<CR>
noremap  <F10> :Limelight!!<CR>
noremap  <F11> :Goyo<CR>
noremap  <F12> :TagbarToggle<CR>
autocmd  FileType python    noremap <F3> :silent !ipython -i %<CR>:redraw!<CR>
autocmd  FileType latex     noremap <F4> :LLPStartPreview<CR>
autocmd  FileType markdown* noremap <F5> :silent! !pandoc --pdf-engine=xelatex % -t pdf 2>/dev/null \| zathura - 2>/dev/null &<CR>:redraw!<CR>

" ctrl maps
vmap     <C-c> "+y
vmap     <C-x> "+c<ESC>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
noremap  <C-r> <Nop>
noremap  <C-p> jzz
noremap  <C-e> kzz
noremap  <C-h> :wincmd h<CR>
noremap  <C-j> :wincmd j<CR>
noremap  <C-k> :wincmd k<CR>
noremap  <C-l> :wincmd l<CR>
noremap  <C-f> :vert res -5<CR>
noremap  <C-b> :vert res +5<CR>
noremap  <C-s> :res -5<CR>
noremap  <C-g> :res +5<CR>

" maps
map      gf :e <cfile><CR>
nmap     Y  y$
nmap     <  <<
nmap     >  >>
lmap     <CR> <CR>
vnoremap J dp1V
nnoremap r <C-r>
nnoremap <silent> K :call ShowDoc()<CR>
vnoremap < <gv
vnoremap > >gv
