local telescope = require("telescope")
local actions = require("telescope.actions")
local undo_actions = require("telescope-undo.actions")

vim.cmd[[autocmd User TelescopePreviewerLoaded setlocal number]]


-- pyright messages with line breaks fix
local entry_slicer = function(entry)
	local default_entry = require('telescope.make_entry').gen_from_quickfix()(entry)

	local original_display = default_entry.display

	default_entry.display = function(_entry)
		local display_text = original_display(_entry)
		return tostring(display_text:gsub("[\r\n]", " "))
	end

	return default_entry
end


telescope.load_extension('undo')
telescope.setup({
	extensions = {
		undo = {
			mappings = {
				n = {
					["<cr>"] = undo_actions.restore,
				};
				i = {
					["<cr>"] = undo_actions.restore,
				};
			},
		},
	},
	pickers = {
		git_commits = {
			initial_mode = 'normal',
		},
		git_bcommits = {
			initial_mode = 'normal',
		},
		git_status = {
			initial_mode = 'normal',
		},
		colorscheme = {
			initial_mode = 'normal',
			enable_preview = true
		},
		lsp_definitions = {
			initial_mode = 'normal',
		},
		lsp_references = {
			initial_mode = 'normal',
		},
		loclist = {
			entry_maker = entry_slicer,
			initial_mode = 'normal',
			path_display = { 'hidden' },
		},
		quickfix = {
			entry_maker = entry_slicer,
			initial_mode = 'normal',
			layout_config = {
				horizontal = {
					preview_width = 0.5
				}
			},
			fname_width = 20,
			wrap_results = true,
			path_display = {
				'tail'
			},
		}
	},
	defaults = {
		dynamic_preview_title = true,
		mappings = {
			n = {
				['q'] = actions.close
			}
		},
		initial_mode = 'insert',
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
})
