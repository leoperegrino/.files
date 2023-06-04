local lualine = require("lualine")

local ok, noice = pcall(require, 'noice')
local macro
if ok then
	macro = {
		function()
			local mode = noice.api.statusline.mode.get()
			return string.match(mode or '', '^recording @.*') or ''
		end,
		cond = noice.api.statusline.mode.has,
	}
end



lualine.setup {
	options = {
		icons_enabled = true,
		theme = 'vscode',
		section_separators = { left = '', right = ' ' },
		component_separators = { left = '', right = ' ' },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {
			{'branch'},
			{'diff'},
			{'diagnostics'},
			macro
		},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat'},
		lualine_y = {'location', 'progress'},
		lualine_z = {{'filetype', colored = false}}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {
		lualine_a = {'buffers'},
		lualine_b = {''},
		lualine_c = {''},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {'tabs'}
	},
	extensions = {}
}
