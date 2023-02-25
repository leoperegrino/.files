local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
	return
end

vim.cmd[[autocmd User TelescopePreviewerLoaded setlocal number]]

-- telescope.load_extension('dap')
telescope.load_extension('undo')
telescope.setup{
	-- extensions = {
 --        undo = {
 --          -- telescope-undo.nvim config, see below
 --        },
 --    },
	defaults = {
		scroll_strategy = "limit",
		layout_config = {
			width = 0.95,
			height = 0.85,
			prompt_position = "top",
			horizontal = {
				preview_width = function(_, cols, _)
				if cols > 200 then
						return math.floor(cols * 0.4)
					else
						return math.floor(cols * 0.6)
					end
				end,
			},
			vertical = {
				width = 0.9,
				height = 0.95,
				preview_height = 0.5,
			},
		},
	}
}
