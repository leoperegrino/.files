if not _G.tab_names then
  _G.tab_names = {}
end

return {
	{ 'nvim-lualine/lualine.nvim',
		dependencies = {
			'Mofiqul/vscode.nvim'
		},
		opts = {
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
				lualine_z = { { 'tabs', mode = 1,
					fmt = function(name, context)
						local tabnr = context.tabnr

						-- If we don't have a stored name for this tab, capture it now
						if not _G.tab_names[tabnr] then
							local buflist = vim.fn.tabpagebuflist(tabnr)
							local winnr = vim.fn.tabpagewinnr(tabnr)
							local bufnr = buflist[winnr]
							local bufname = vim.api.nvim_buf_get_name(bufnr)

							if bufname ~= "" then
								local path_parts = vim.split(bufname, "/")
								if #path_parts > 1 then
									_G.tab_names[tabnr] = path_parts[#path_parts - 1] or name
								else
									_G.tab_names[tabnr] = name
								end
							else
								_G.tab_names[tabnr] = vim.fn.expand('%:p:h:t')
							end
						end

						return _G.tab_names[tabnr]
					end
				} },
			},
			extensions = {},
		},
	},
}
