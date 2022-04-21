local opts = { noremap=true, silent=true }
local keymap = vim.api.nvim_set_keymap
local buf_keymap = vim.api.nvim_buf_set_keymap
local buf_set_option = vim.api.nvim_buf_set_option
local telescope = ":lua require('telescope.builtin')"
local diagnostic = ":lua vim.diagnostic"
local lsp_buf = ":lua vim.lsp.buf"
local M = {}


M.lsp = function(bufnr)
	buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	if vim.bo.filetype == "vim" or vim.bo.filetype == "sh" then
	else
		buf_keymap(bufnr, "n", "K"      , ":lua vim.lsp.buf.hover()<CR>" , opts)
	end

	buf_keymap(bufnr, "n", "gL"  , diagnostic .. ".setloclist({open=false})<cr>" .. telescope .. ".loclist()<cr>", opts)
	buf_keymap(bufnr, "n", "gQ"  , diagnostic .. ".setqflist({open=false})<cr>" .. telescope .. ".quickfix()<cr>", opts)
	buf_keymap(bufnr, "n", "gd"  , telescope .. ".lsp_definitions()<cr>"       , opts)
	buf_keymap(bufnr, "n", "gI"  , telescope .. ".lsp_implementations()<cr>"   , opts)
	buf_keymap(bufnr, "n", "gt"  , telescope .. ".lsp_type_definitions()<cr>"  , opts)
	buf_keymap(bufnr, "n", "gr"  , telescope .. ".lsp_references()<cr>"        , opts)
	buf_keymap(bufnr, "n", "glr" , lsp_buf .. ".rename()<CR>"                  , opts)
	buf_keymap(bufnr, "n", "gld" , lsp_buf .. ".declaration()<CR>"             , opts)
	buf_keymap(bufnr, "n", "gls" , lsp_buf .. ".signature_help()<CR>"          , opts)
	buf_keymap(bufnr, "n", "glc" , lsp_buf .. ".code_action()<CR>"             , opts)
	buf_keymap(bufnr, "n", "glw" , lsp_buf .. ".add_workspace_folder()<CR>"    , opts)
	buf_keymap(bufnr, "n", "glW" , lsp_buf .. ".remove_workspace_folder()<CR>" , opts)
	buf_keymap(bufnr, "n", "glf" , lsp_buf .. ".formatting()<CR>"              , opts)
	buf_keymap(bufnr, "n", "gll" , ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
end


M.plugins = function()
	keymap("n", "gh"         , diagnostic .. ".open_float()<CR>", opts)
	keymap("n", "[d"         , diagnostic .. ".goto_prev()<CR>" , opts)
	keymap("n", "Ç"          , diagnostic .. ".goto_prev()<CR>" , opts)
	keymap("n", "]d"         , diagnostic .. ".goto_next()<CR>" , opts)
	keymap("n", "ç"          , diagnostic .. ".goto_next()<CR>" , opts)
	keymap("n", "<leader>eq" , diagnostic .. ".setloclist()<CR>", opts)

	keymap("n", "<leader>tt" , ":lua _TERM_TOGGLE()<cr>"    , opts)
	keymap("n", "<leader>tg" , ":lua _LAZYGIT_TOGGLE()<cr>" , opts)
	keymap("n", "<leader>tp" , ":lua _IPYTHON_TOGGLE()<cr>" , opts)
	keymap("n", "<leader>th" , ":lua _HTOP_TOGGLE()<cr>"    , opts)
	keymap("n", "<leader>tsl", ":ToggleTermSendCurrentLine 3<cr>i"    , opts)
	keymap("v", "<leader>tsL", ":ToggleTermSendVisualLines 3<cr>i"    , opts)
	keymap("v", "<leader>tsv", ":ToggleTermSendVisualSelection 3<cr>i", opts)

	keymap("n", "<leader>b"  , telescope .. ".buffers()<cr>"     , opts)
	keymap("n", "<leader>g"  , telescope .. ".git_files()<cr>"   , opts)
	keymap("n", "<leader>ff" , telescope .. ".find_files()<cr>"  , opts)
	keymap("n", "<leader>fg" , telescope .. ".live_grep()<cr>"   , opts)
	keymap("n", "<leader>fh" , telescope .. ".help_tags()<cr>"   , opts)
	keymap("n", "<leader>fb" , telescope .. ".builtin()<cr>"     , opts)

	keymap("n", "<F1>"       , ":lua _COMMENT()<CR>"           , opts)
	keymap("v", "<F1>"       , ":lua _VCOMMENT()<CR>"          , opts)
	keymap("n", "<F2>"       , ":lua vim.lsp.buf.rename()<CR>" , opts)
	keymap("n", "<F8>"       , ":ToggleTerm<cr>"               , opts)
	keymap("n", "<F9>"       , ":NvimTreeToggle<cr>"           , opts)
	keymap("n", "<F12>"      , ":SymbolsOutline<cr>"           , opts)
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
	keymap('n', '<leader>8'       , ']s'         , opts)
	keymap('n', '<leader>9'       , '1z='        , opts)
	keymap('n', '<leader>0'       , '[s'         , opts)
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
	keymap('n', '<C-p>'     , 'jzz'               , opts)
	keymap('n', '<C-e>'     , 'kzz'               , opts)
	keymap('n', '<C-h>'     , ':wincmd h<CR>'     , opts)
	keymap('n', '<C-j>'     , ':wincmd j<CR>'     , opts)
	keymap('n', '<C-k>'     , ':wincmd k<CR>'     , opts)
	keymap('n', '<C-l>'     , ':wincmd l<CR>'     , opts)
	keymap('n', '<C-f>'     , ':vert res -5<CR>'  , opts)
	keymap('n', '<C-b>'     , ':vert res +5<CR>'  , opts)
	keymap('n', '<C-s>'     , ':res -5<CR>'       , opts)
	keymap('n', '<C-g>'     , ':res +5<CR>'       , opts)
	keymap('n', '<C-p>'     , 'jzz'               , opts)
	keymap('n', '<C-e>'     , 'kzz'               , opts)
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
	vim.cmd[[command! -nargs=1 -complete=highlight FH exec 'filter /\c.*' . substitute('<args>', ' ', '\\\&\.\*', '') . '/ hi']]
	vim.cmd[[command! -nargs=1 -complete=command H vert help <args>]]
	vim.cmd[[cnoreabbrev help vert help]]
end


M.non_buf = function()
	M.plugins()
	M.leader()
	M.ctrl()
	M.etc()
	M.commands()
end


return M
