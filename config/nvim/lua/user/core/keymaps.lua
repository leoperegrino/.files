local M = {}


function M.keymaps()
	local set = vim.keymap.set

	-- basics
	set('', '<leader><leader>', ':')
	set('n', '<leader>H', ':vert help ')
	set('n', '<leader>L', ':lua ')
	set('n', '<leader>=', ':= ')

	-- edits
	set('n', '<leader>T', ':tabedit ')
	set('n', '<leader>S', ':vsplit ')
	set('n', '<leader>O', ':split ')
	set('n', '<leader>E', ':edit ')
	set('n', '<leader>e', ':vert sb ')

	-- save/quit
	set('n', '<leader>s', '<Cmd>w<CR>')
	set('n', '<leader>q', '<Cmd>q<CR>')
	set('n', '<leader>Q', 'ZQ')
	set('n', '<leader>wq', 'ZZ')

	-- tab navigation
	set('n', '<leader>1', 'gT')
	set('n', '<leader>2', 'gt')
	set('n', '<leader>n', ']b', { remap = true })
	set('n', '<leader>p', '[b', { remap = true })

	-- text navigation
	set('c', '<C-d>', '<c-f>')
	set('c', '<C-f>', '<Right>')
	set('c', '<C-b>', '<Left>')
	set('i', '<C-f>', '<Right>')
	set('i', '<C-b>', '<Left>')
	set('i', '<C-e>', '<ESC>A')
	set('i', '<C-a>', '<ESC>I')

	-- window rearrangement
	set('n', '<leader>h', '<C-w>H')
	set('n', '<leader>j', '<C-w>J')
	set('n', '<leader>k', '<C-w>K')
	set('n', '<leader>l', '<C-w>L')

	-- window navigation
	set('n', '<C-h>', '<c-w>h')
	set('n', '<C-j>', '<c-w>j')
	set('n', '<C-k>', '<c-w>k')
	set('n', '<C-l>', '<c-w>l')

	-- window resizing
	set('n', '<C-f>', '<Cmd>vert res -5<CR>')
	set('n', '<C-b>', '<Cmd>vert res +5<CR>')
	set('n', '<C-s>', '<Cmd>res -5<CR>')
	set('n', '<C-g>', '<Cmd>res +5<CR>')

	-- text indentation
	set('n', '<', '<<', { remap = true })
	set('n', '>', '>>', { remap = true })
	set('v', '<', '<gv')
	set('v', '>', '>gv')

	-- text yank/paste
	set('', '<C-p>', '"0p')
	set('v', '<C-c>', '"+y')

	-- use r for redo
	set('', '<C-r>', '<Nop>')
	set('n', 'r', '<C-r>')

	-- force gf to create file
	set('', 'gf', "<Cmd>e <cfile><CR>")
	set('', 'gF', "<Cmd>vsplit <cfile><CR>")

	-- spell
	set('n', '<leader>C', '<Cmd>setlocal spell! spelllang=en_us<CR>')
	set('n', '<leader>c', '<Cmd>setlocal spell! spelllang=pt_br<CR>')

	set('n', '<leader>B',
		function()
			vim.cmd.bnext()
			vim.cmd.bdelete('#')
		end,
		{ desc = 'delete buffer without closing window' }
	)

	set('n', '<esc>',
		function()
			vim.cmd.nohlsearch()
			vim.cmd.echo()
		end,
		{ desc = "disable search highlighting and clear cmdline" }
	)

	set('n', 'yU',
		function()
			local cword = vim.fn.expand('<cword>')
			vim.fn.setreg('/', cword)
			vim.o.hlsearch = true
		end,
		{ desc = "yank cword to search pattern" }
	)

	set('n', 'yu',
		function()
			local cword = vim.fn.expand('<cword>')
			vim.fn.setreg('/', '\\<' .. cword .. '\\>')
			vim.o.hlsearch = true
		end,
		{ desc = "yank cword with boundaries to search pattern" }
	)
end

function M.commands()
	local command = vim.api.nvim_create_user_command

	command('Untrail',
		function(_)
			---@diagnostic disable-next-line: param-type-mismatch
			pcall(vim.cmd, [[%s/\s\+$//g]])
		end,
		{ nargs = 0 }
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

function M.setup()
	M.keymaps()
	M.commands()
end

return M
