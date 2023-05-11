local noice = require("noice")


vim.api.nvim_create_autocmd("FileType", {
	pattern = "noice",
	callback = function() vim.wo.wrap = false end
})


noice.setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true
		},
	},
	routes = {
		{
			view = "notify",
			filter = { event = "msg_showmode" },
		},
	},
	views = {
		split = {
			enter = true,
			position = "bottom",
		},
		vsplit = {
			enter = true,
			position = "right",
		}
	},
	-- messages = { enabled = false },
	-- notify = { enabled = false },
	presets = {
		lsp_doc_border = true,
		cmdline_output_to_split = true,
	}
})
