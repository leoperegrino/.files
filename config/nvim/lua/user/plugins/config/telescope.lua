-- pyright messages with line breaks fix
local entry_slicer = function(entry)
	local make_entry = require('telescope.make_entry')
	local default_entry = make_entry.gen_from_quickfix()(entry)

	local original_display = default_entry.display

	default_entry.display = function(_entry)
		local display_text = original_display(_entry)
		return tostring(display_text:gsub("[\r\n]", " "))
	end

	return default_entry
end


return {
	{ "nvim-lua/plenary.nvim",
		lazy = true,
	},

	{ 'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		opts = {
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
						['q'] = function() require("telescope.actions").close() end
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
		},
		keys = function()
			local telescope = require('telescope.builtin')
			local telescope_utils = require('telescope.utils')

			local function cwd_git_files()
				telescope.git_files( { cwd = telescope_utils.buffer_dir() } )
			end
			local function cwd_files()
				telescope.find_files( { cwd = telescope_utils.buffer_dir() } )
			end

			return {
				{"<leader>b", telescope.buffers        , desc = "telescope: buffers" },
				{"<leader>g", cwd_git_files            , desc = "telescope: git files" },
				{"<leader>f", cwd_files                , desc = "telescope: find files" },
				{"<leader>F", telescope.find_files     , desc = "telescope: find files" },
				{"<leader>G", telescope.live_grep      , desc = "telescope: live grep" },
				{"<leader>t", telescope.help_tags      , desc = "telescope: help tags" },
				{"tb"       , telescope.buffers        , desc = "telescope: buffers" },
				{"tg"       , telescope.git_files      , desc = "telescope: git files" },
				{"tf"       , telescope.find_files     , desc = "telescope: find files" },
				{"tg"       , telescope.live_grep      , desc = "telescope: live grep" },
				{"tH"       , telescope.help_tags      , desc = "telescope: help tags" },
				{"th"       , telescope.git_commits    , desc = "telescope: git commits" },
				{"tj"       , telescope.git_bcommits   , desc = "telescope: git buffer commits" },
				{"tt"       , telescope.builtin        , desc = "telescope: builtins" },
				{"ts"       , telescope.git_status     , desc = "telescope: git status" },
				{"tS"       , telescope.spell_suggest  , desc = "telescope: spell suggest" },
				{"tc"       , telescope.commands       , desc = "telescope: commands" },
				{"tk"       , telescope.keymaps        , desc = "telescope: keymaps" },
				{"tr"       , telescope.oldfiles       , desc = "telescope: recent files"},
			}
		end,
	},

	{ 'debugloop/telescope-undo.nvim',
		dependencies = {
			{ "nvim-telescope/telescope.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
		},
		opts = function(_, _)
			local undo_actions = require("telescope-undo.actions")
			return {
				extensions = {
					undo = {
						mappings = {
							n = { ["<cr>"] = undo_actions.restore, },
							i = { ["<cr>"] = undo_actions.restore, },
						},
					},
				},
			}
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("undo")
		end,
		keys = {
			{ "tu", "<cmd>Telescope undo<cr>", desc = "telescope: undo" },
		},
	},

	{ 'nvim-telescope/telescope-symbols.nvim' },
}
