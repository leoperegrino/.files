local M = {}

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set


M.lsp = function(bufnr)
	local buf_opts = { buffer = bufnr, noremap = true, silent = true }
	local lsp_buf = ":lua vim.lsp.buf"
	local bufmap = function(mode, key, map) keymap(mode, key, map, buf_opts) end

	if vim.bo.filetype ~= "vim" and vim.bo.filetype ~= "sh" then
		bufmap("n", "K"   , lsp_buf .. ".hover()<CR>")
	end
	bufmap("n", "glr" , lsp_buf .. ".rename()<CR>")
	bufmap("n", "gld" , lsp_buf .. ".declaration()<CR>")
	bufmap("n", "gls" , lsp_buf .. ".signature_help()<CR>")
	bufmap("n", "glc" , lsp_buf .. ".code_action()<CR>")
	bufmap("n", "glw" , lsp_buf .. ".add_workspace_folder()<CR>")
	bufmap("n", "glW" , lsp_buf .. ".remove_workspace_folder()<CR>")
	bufmap("n", "glf" , lsp_buf .. ".format({async=true})<CR>")
	bufmap("n", "gll" , ":= vim.lsp.buf.list_workspace_folders()<CR>")
end


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
	keymap('n', '<leader>H'       , ':H '        , { noremap = true })
	keymap('n', '<leader>L'       , ':lua '      , { noremap = true })
	keymap('n', '<leader>='       , ':= '        , { noremap = true })
	keymap('n', '<leader>m'       , ':vert Man ' , { noremap = true })
	keymap('n', '<leader>1'       , ':tabp<CR>'  , opts)
	keymap('n', '<leader>2'       , ':tabn<CR>'  , opts)
	keymap('n', '<leader>T'       , ':tabedit '  , { noremap = true })
	keymap('n', '<leader>S'       , ':vsplit '   , { noremap = true })
	keymap('n', '<leader>p'       , ':bp<CR>'    , opts)
	keymap('n', '<leader>n'       , ':bn<CR>'    , opts)
	keymap('n', '<leader>vb'      , ':vert sb '  , { noremap = true })
	keymap('n', '<leader>B'       , ':Bd<CR>'    , opts)
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
	keymap('c', '<C-d>'     , '<c-f>'             , opts)
	keymap('c', '<C-f>'     , '<Right>'           , opts)
	keymap('c', '<C-b>'     , '<Left>'            , opts)
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
	keymap('n' , 'Y'     , 'y$'     , opts)
	keymap(''  , 'gf'    , ":e <cfile><CR>"                                       , opts)
	keymap('n' , 'gT'    , ":= vim.treesitter.get_captures_at_cursor(0)<CR>"      , opts)
	keymap(''  , 'gF'    , ":vsplit <cfile><CR>"                                  , opts)
	keymap('n' , 'K'     , ":execute 'vert' &keywordprg expand('<cword>')<CR>"    , opts)
	keymap('n' , 'H'     , ":execute 'match DiffAdd /'.expand('<cword>').'/'<CR>" , opts)
	keymap('n' , 'yU'    , ":let @/= expand('<cword>') <BAR> set hlsearch<CR>"    , opts)
	keymap('n' , '<esc>' , ':noh <bar> match none<CR><esc>'                       , opts)
	keymap('n' , 'yu'    , [[:let @/='\<' . expand('<cword>') . '\>' <BAR> set hlsearch<CR>]], opts)
end


M.commands = function()
	vim.cmd[[command! -nargs=0 Bd bn | bd #]]
	vim.cmd[[command! -nargs=0 Format execute 'lua vim.lsp.buf.format({async=true})']]
	vim.cmd[[command! -nargs=0 Untrail execute '%s/\s\+$//g']]
	vim.cmd[[command! -nargs=1 -complete=highlight FH exec 'filter /\c.*' . substitute('<args>', ' ', '\\\&\.\*', '') . '/ hi']]
	vim.cmd[[command! -nargs=1 -complete=command H vert help <args>]]
end


M.on_attach = function(_, bufnr)
	M.lsp(bufnr)
end

M.setup = function()
	M.diagnostic()
	M.leader()
	M.ctrl()
	M.etc()
	M.commands()
end


return M
