local M = {}

local command = vim.api.nvim_create_user_command

local keymap_with = require('user.utils').keymap_with


M.setup = function()
	local keymap = keymap_with({
		noremap = true,
	})

	keymap('' , '<leader><leader>', ':'         )
	keymap('n', '<leader>H'       , ':H '       )
	keymap('n', '<leader>L'       , ':lua '     )
	keymap('n', '<leader>='       , ':= '       )
	keymap('n', '<leader>m'       , ':vert Man ')
	keymap('n', '<leader>T'       , ':tabedit ' )
	keymap('n', '<leader>S'       , ':vsplit '  )
	keymap('n', '<leader>O'       , ':split '   )
	keymap('n', '<leader>vb'      , ':vert sb ' )
	keymap('n', '<leader>E'       , ':edit ' )

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

	keymap(''  , '<c-p>' , '"0p'  )
	keymap('n' , '_'     , '-'    )
	keymap('n' , 'r'     , '<C-r>')
	keymap('n' , 'Y'     , 'y$'   )
	keymap('n' , 'dL'    , 'd$'   )
	keymap('n' , 'dH'    , 'd^'   )
	keymap(''  , 'gf'    , "<Cmd>e <cfile><CR>"                                       )
	keymap(''  , 'gF'    , "<Cmd>vsplit <cfile><CR>"                                  )
	keymap('n' , 'K'     , "<Cmd>execute 'vert' &keywordprg expand('<cword>')<CR>"    )
	keymap('n' , '<esc>' , [[<Cmd>noh <bar> match none <bar> echo ''<CR><esc>]]       , "make escape disable search highlighting"      )
	keymap('n' , 'yU'    , "<Cmd>let @/= expand('<cword>') <BAR> set hlsearch<CR>"    , "yank word under the cursor to search pattern" )
	keymap('n' , 'yu'    , [[<Cmd>let @/='\<' . expand('<cword>') . '\>' <BAR> set hlsearch<CR>]], "yank word with boundaries under the cursor to search pattern")

	command('Bd',
		function(_) vim.cmd.bnext() vim.cmd.bdelete('#') end,
		{ nargs = 0 }
	)
	command('Untrail',
		function(_) pcall(vim.cmd, [[%s/\s\+$//g]]) end,
		{ nargs = 0 }
	)
	command('H',
		function(opts) vim.cmd('vert help ' .. opts.fargs[1]) end,
		{ nargs = 1, complete = 'command' }
	)
	command('XMLint',
		function(_)
			vim.cmd('normal mm')
			vim.cmd([[%!XMLLINT_INDENT='	' xmllint --format --recover -]])
			vim.cmd('normal `m')
		end,
		{ nargs = 0 }
	)
end


return M
