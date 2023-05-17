local M = {}

local keymap_with = require('user.utils').keymap_with


M.on_attach = function(_, bufnr)
	local bufmap = keymap_with({
		buffer = bufnr,
		noremap = true,
	})

	if vim.bo.filetype ~= "vim" and vim.bo.filetype ~= "sh" then
		bufmap("n", "K"   , vim.lsp.buf.hover)
	end

	bufmap("n", "glr" , vim.lsp.buf.rename                 )
	bufmap("n", "gld" , vim.lsp.buf.declaration            )
	bufmap("n", "gls" , vim.lsp.buf.signature_help         )
	bufmap("n", "glc" , vim.lsp.buf.code_action            )
	bufmap("n", "glw" , vim.lsp.buf.add_workspace_folder   )
	bufmap("n", "glW" , vim.lsp.buf.remove_workspace_folder)
	bufmap("n", "glf" , vim.lsp.buf.format                 )
	bufmap("n", "gll" , "<Cmd>= vim.lsp.buf.list_workspace_folders()<CR>")
end


M.setup = function()
	local keymap = keymap_with({
		noremap = true,
	})

	keymap("n", "[d"         , vim.diagnostic.goto_prev )
	keymap("n", "Ç"          , vim.diagnostic.goto_prev )
	keymap("n", "]d"         , vim.diagnostic.goto_next )
	keymap("n", "ç"          , vim.diagnostic.goto_next )
	keymap("n", "<leader>eq" , vim.diagnostic.setloclist)

	keymap('' , '<leader><leader>', ':'         )
	keymap('n', '<leader>H'       , ':H '       )
	keymap('n', '<leader>L'       , ':lua '     )
	keymap('n', '<leader>='       , ':= '       )
	keymap('n', '<leader>m'       , ':vert Man ')
	keymap('n', '<leader>T'       , ':tabedit ' )
	keymap('n', '<leader>S'       , ':vsplit '  )
	keymap('n', '<leader>vb'      , ':vert sb ' )

	keymap('n', '<leader>s'       , '<Cmd>w<CR>'   )
	keymap('n', '<leader>q'       , '<Cmd>q<CR>'   )
	keymap('n', '<leader>Q'       , '<Cmd>q!<CR>'  )
	keymap('n', '<leader>wq'      , '<Cmd>wq<CR>'  )
	keymap('n', '<leader>1'       , '<Cmd>tabp<CR>')
	keymap('n', '<leader>2'       , '<Cmd>tabn<CR>')
	keymap('n', '<leader>p'       , '<Cmd>bp<CR>'  )
	keymap('n', '<leader>n'       , '<Cmd>bn<CR>'  )
	keymap('n', '<leader>B'       , '<Cmd>Bd<CR>'  )
	keymap('n', '<leader>h'       , '<C-w>H'       )
	keymap('n', '<leader>j'       , '<C-w>J'       )
	keymap('n', '<leader>k'       , '<C-w>K'       )
	keymap('n', '<leader>l'       , '<C-w>L'       )
	keymap('n', '<leader>8'       , '[s'           )
	keymap('n', '<leader>9'       , '1z='          )
	keymap('n', '<leader>0'       , ']s'           )
	keymap('' , '<leader>P'       , '"0p'          )
	keymap('n', '<leader>C'       , '<Cmd>setlocal spell! spelllang=en_us<CR>')
	keymap('n', '<leader>c'       , '<Cmd>setlocal spell! spelllang=pt_br<CR>')
	keymap('n', '<leader>WW'      , '<Cmd>silent w ! sudo tee >/dev/null  % <CR>')

	keymap('c', '<C-d>'     , '<c-f>'             )
	keymap('c', '<C-f>'     , '<Right>'           )
	keymap('c', '<C-b>'     , '<Left>'            )
	keymap('v', '<C-c>'     , '"+y'               )
	keymap('i', '<C-f>'     , '<Right>'           )
	keymap('i', '<C-b>'     , '<Left>'            )
	keymap('i', '<C-e>'     , '<ESC>A'            )
	keymap('i', '<C-a>'     , '<ESC>I'            )
	keymap('' , '<C-r>'     , '<Nop>'             )
	keymap('n', '<C-p>'     , 'kzz'               )
	keymap('n', '<C-n>'     , 'jzz'               )
	keymap('n', '<C-h>'     , '<Cmd>wincmd h<CR>' )
	keymap('n', '<C-j>'     , '<Cmd>wincmd j<CR>' )
	keymap('n', '<C-k>'     , '<Cmd>wincmd k<CR>' )
	keymap('n', '<C-l>'     , '<Cmd>wincmd l<CR>' )
	keymap('n', '<C-f>'     , '<Cmd>vert res -5<CR>')
	keymap('n', '<C-b>'     , '<Cmd>vert res +5<CR>')
	keymap('n', '<C-s>'     , '<Cmd>res -5<CR>'     )
	keymap('n', '<C-g>'     , '<Cmd>res +5<CR>'     )
	keymap('t', '<C-h>'     , [[<C-\><C-N><C-w>h]]  )
	keymap('t', '<C-j>'     , [[<C-\><C-N><C-w>j]]  )
	keymap('t', '<C-k>'     , [[<C-\><C-N><C-w>k]]  )
	keymap('t', '<C-l>'     , [[<C-\><C-N><C-w>l]]  )
	keymap('t', '<C-w><C-w>', [[<C-\><C-N>]]        )

	local remap = keymap_with({ })
	remap('n' , '<'  , '<<')
	remap('n' , '>'  , '>>')

	keymap('v' , '<'     , '<gv'  )
	keymap('v' , '>'     , '>gv'  )

	keymap('n' , '_'     , '-'    )
	keymap('n' , 'r'     , '<C-r>')
	keymap('n' , 'Y'     , 'y$'   )
	keymap(''  , 'gf'    , "<Cmd>e <cfile><CR>"                                       )
	keymap('n' , 'gh'    , "<Cmd>= vim.treesitter.get_captures_at_cursor(0)<CR>"      )
	keymap(''  , 'gF'    , "<Cmd>vsplit <cfile><CR>"                                  )
	keymap('n' , 'K'     , "<Cmd>execute 'vert' &keywordprg expand('<cword>')<CR>"    )
	keymap('n' , 'H'     , "<Cmd>execute 'match DiffAdd /'.expand('<cword>').'/'<CR>" )
	keymap('n' , 'yU'    , "<Cmd>let @/= expand('<cword>') <BAR> set hlsearch<CR>"    )
	keymap('n' , '<esc>' , '<Cmd>noh <bar> match none<CR><esc>'                       )
	keymap('n' , 'gH'    , [[<Cmd>echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')<CR>]])
	keymap('n' , 'yu'    , [[<Cmd>let @/='\<' . expand('<cword>') . '\>' <BAR> set hlsearch<CR>]])

	vim.cmd[[command! -nargs=0 Bd bn | bd #]]
	vim.cmd[[command! -nargs=0 Format execute 'lua vim.lsp.buf.format()']]
	vim.cmd[[command! -nargs=0 Untrail execute '%s/\s\+$//g']]
	vim.cmd[[command! -nargs=1 -complete=highlight FH exec 'filter /\c.*' . substitute('<args>', ' ', '\\\&\.\*', '') . '/ hi']]
	vim.cmd[[command! -nargs=1 -complete=command H vert help <args>]]
end


return M
