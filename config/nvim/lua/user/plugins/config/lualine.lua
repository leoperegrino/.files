local lualine = require("lualine")


lualine.setup({
	options = {
		icons_enabled = true,
		theme = 'codedark',
		section_separators = { left = '', right = '' },
		component_separators = { left = '', right = ' ' },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {
			{'branch'},
			{'lsp_status'},
			{'diagnostics'},
			{'diff'},
		},
		lualine_c = {
			-- function() return vim.b.gitsigns_blame_line or '' end
		},
		lualine_x = {
			{ 'filename', path = 1 },
			'encoding',
			'fileformat',
		},
		lualine_y = {
			'location',
			'progress',
			-- 'searchcount',
		},
		lualine_z = { { 'filetype', colored = false } }
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
		lualine_z = { { 'tabs', mode = 2, } }
	},
	extensions = {}
})
