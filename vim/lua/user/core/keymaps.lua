local M = {}

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set


M.diagnostic = function()
	keymap("n", "gh"         , vim.diagnostic.open_float, opts)
	keymap("n", "[d"         , vim.diagnostic.goto_prev , opts)
	keymap("n", "Ç"          , vim.diagnostic.goto_prev , opts)
	keymap("n", "]d"         , vim.diagnostic.goto_next , opts)
	keymap("n", "ç"          , vim.diagnostic.goto_next , opts)
	keymap("n", "<leader>eq" , vim.diagnostic.setloclist, opts)
end


M.leader = function()
	keymap('' , '<leader><leader>', ':'          , { noremap = true })
	keymap('n', '<leader>s'       , ':w<CR>'     , opts)
	keymap('n', '<leader>q'       , ':q<CR>'     , opts)
	keymap('n', '<leader>Q'       , ':q!<CR>'    , opts)
	keymap('n', '<leader>wq'      , ':wq<CR>'    , opts)
	keymap('' , '<leader>H'       , ':noh<CR>'   , opts)
	keymap('n', '<leader>1'       , ':tabp<CR>'  , opts)
	keymap('n', '<leader>2'       , ':tabn<CR>'  , opts)
	keymap('n', '<leader>T'       , ':tabedit '  , { noremap = true })
	keymap('n', '<leader>S'       , ':vsplit '   , { noremap = true })
	keymap('n', '<leader>p'       , ':bp<CR>'    , opts)
	keymap('n', '<leader>n'       , ':bn<CR>'    , opts)
	keymap('n', '<leader>vb'      , ':vert sb '  , { noremap = true })
	keymap('n', '<leader>h'       , '<C-w>H'     , opts)
	keymap('n', '<leader>j'       , '<C-w>J'     , opts)
	keymap('n', '<leader>k'       , '<C-w>K'     , opts)
	keymap('n', '<leader>l'       , '<C-w>L'     , opts)
	keymap('n', '<leader>8'       , '[s'         , opts)
	keymap('n', '<leader>9'       , '1z='        , opts)
	keymap('n', '<leader>0'       , ']s'         , opts)
	keymap('' , '<leader>P'       , '"0p'        , opts)
	keymap('n', '<leader>C'       , ':setlocal spell! spelllang=en_us<CR>', opts)
	keymap('n', '<leader>c'       , ':setlocal spell! spelllang=pt_br<CR>', opts)
	keymap('n', '<leader>WW'      , ':silent w ! sudo tee >/dev/null  % <CR>', opts)
end


M.ctrl = function()
	keymap('v', '<C-c>'     , '"+y'               , opts)
	keymap('i', '<C-f>'     , '<Right>'           , opts)
	keymap('i', '<C-b>'     , '<Left>'            , opts)
	keymap('i', '<C-e>'     , '<ESC>A'            , opts)
	keymap('i', '<C-a>'     , '<ESC>I'            , opts)
	keymap('' , '<C-r>'     , '<Nop>'             , opts)
	keymap('n', '<C-p>'     , 'kzz'               , opts)
	keymap('n', '<C-n>'     , 'jzz'               , opts)
	keymap('n', '<C-h>'     , ':wincmd h<CR>'     , opts)
	keymap('n', '<C-j>'     , ':wincmd j<CR>'     , opts)
	keymap('n', '<C-k>'     , ':wincmd k<CR>'     , opts)
	keymap('n', '<C-l>'     , ':wincmd l<CR>'     , opts)
	keymap('n', '<C-f>'     , ':vert res -5<CR>'  , opts)
	keymap('n', '<C-b>'     , ':vert res +5<CR>'  , opts)
	keymap('n', '<C-s>'     , ':res -5<CR>'       , opts)
	keymap('n', '<C-g>'     , ':res +5<CR>'       , opts)
	keymap('t', '<C-h>'     , [[<C-\><C-N><C-w>h]], opts)
	keymap('t', '<C-j>'     , [[<C-\><C-N><C-w>j]], opts)
	keymap('t', '<C-k>'     , [[<C-\><C-N><C-w>k]], opts)
	keymap('t', '<C-l>'     , [[<C-\><C-N><C-w>l]], opts)
	keymap('t', '<C-w><C-w>', [[<C-\><C-N>]]      , opts)
end


M.etc = function()
	keymap('n' , '<'     , '<<'     , { silent = true })
	keymap('n' , '>'     , '>>'     , { silent = true })
	keymap('v' , '<'     , '<gv'    , opts)
	keymap('v' , '>'     , '>gv'    , opts)
	keymap('n' , '_'     , '-'      , opts)
	keymap('n' , 'r'     , '<C-r>'  , opts)
	keymap('v' , 'J'     , 'dp1V'   , opts)
	keymap('n' , 'Y'     , 'y$'     , opts)
	keymap(''  , 'gf'    , ":e <cfile><CR>"                                       , opts)
	keymap(''  , 'gF'    , ":vsplit <cfile><CR>"                                  , opts)
	keymap('n' , 'K'     , ":execute 'vert' &keywordprg expand('<cword>')<CR>"    , opts)
	keymap('n' , 'H'     , ":execute 'match DiffAdd /'.expand('<cword>').'/'<CR>" , opts)
	keymap('n' , 'yU'    , ":let @/= expand('<cword>') <BAR> set hlsearch<CR>"    , opts)
	keymap('n' , '<esc>' , ':noh <bar> match none<CR><esc>'                       , opts)
	keymap('n' , 'yu'    , [[:let @/='\<' . expand('<cword>') . '\>' <BAR> set hlsearch<CR>]], opts)
end


M.commands = function()
	vim.cmd[[command! Format execute 'lua vim.lsp.buf.format({async=true})']]
	vim.cmd[[command! -nargs=1 -complete=highlight FH exec 'filter /\c.*' . substitute('<args>', ' ', '\\\&\.\*', '') . '/ hi']]
	vim.cmd[[command! -nargs=1 -complete=command H vert help <args>]]
	vim.cmd[[cnoreabbrev help vert help]]
end


M.setup = function()
	M.diagnostic()
	M.leader()
	M.ctrl()
	M.etc()
	M.commands()
end


return M
