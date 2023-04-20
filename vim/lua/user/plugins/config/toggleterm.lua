local toggleterm = require("toggleterm")

toggleterm.setup({
	size = 20,
	open_mapping = nil,
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = false,
	shading_factor = 0,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _TERM_TOGGLE(args, size)
	local Terminal = require("toggleterm.terminal").Terminal
	Terminal:new(args):toggle(size)
end

function _LAZYGIT_TOGGLE()
	local args = { cmd = "lazygit", hidden = true, count = 1 }
	_TERM_TOGGLE(args)
end

function _HTOP_TOGGLE()
	local args = { cmd = "htop", hidden = true, count = 2 }
	_TERM_TOGGLE(args)
end

function _IPYTHON_TOGGLE()
	local args = {
		cmd = "ipython",
		direction = "vertical",
		hidden = true,
		count = 3 }
	_TERM_TOGGLE(args, 60)
end
