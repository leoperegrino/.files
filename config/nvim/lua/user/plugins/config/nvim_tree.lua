local function on_attach(buffer)

	local api = require('nvim-tree.api')

	local function bufmap(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, {
			buffer = buffer,
			desc = 'nvim-tree: ' .. desc,
			noremap = true,
			silent = true,
			nowait = true,
		})
	end

	bufmap( 'n',   '<CR>'   , api.node.open.edit               , 'Open'                   )
	bufmap( 'n',   'o'      , api.node.open.edit               , 'Open'                   )
	bufmap( 'n',   'h'      , api.node.navigate.parent_close   , 'Close Directory'        )
	bufmap( 'n',   'l'      , api.node.open.edit               , 'Open'                   )
	bufmap( 'n',   'O'      , api.node.open.horizontal         , 'Open: Horizontal Split' )
	bufmap( 'n',   'H'      , api.tree.collapse_all            , 'Close Dirs recursively ')
	bufmap( 'n',   'L'      , api.tree.expand_all              , 'Open Dirs recursively ' )
	bufmap( 'n',   's'      , api.node.open.vertical           , 'Open: Vertical Split'   )
	bufmap( 'n',   'u'      , api.tree.change_root_to_parent   , 'Up'                     )
	bufmap( 'n',   'U'      , api.tree.change_root_to_parent   , 'Up'                     )
	bufmap( 'n',   'C'      , api.tree.change_root_to_node     , 'CD'                     )
	bufmap( 'n',   '<C-k>'  , api.node.navigate.sibling.prev   , 'Previous Sibling'       )
	bufmap( 'n',   '<C-j>'  , api.node.navigate.sibling.next   , 'Next Sibling'           )
	bufmap( 'n',   'p'      , api.node.navigate.parent         , 'Parent Directory'       )
	bufmap( 'n',   't'      , api.node.open.tab                , 'Open: New Tab'          )
	bufmap( 'n',   '?'      , api.tree.toggle_help             , 'Help'                   )
	bufmap( 'n',   'K'      , api.node.navigate.sibling.first  , 'First Sibling'          )
	bufmap( 'n',   'a'      , api.fs.create                    , 'Create'                 )
	bufmap( 'n',   'J'      , api.node.navigate.sibling.last   , 'Last Sibling'           )
	bufmap( 'n',   'r'      , api.fs.rename                    , 'Rename'                 )
	bufmap( 'n',   'R'      , api.tree.reload                  , 'Refresh'                )
	bufmap( 'n',   'x'      , api.fs.cut                       , 'Cut'                    )
	bufmap( 'n',   'c'      , api.fs.copy.node                 , 'Copy'                   )
	bufmap( 'n',   'P'      , api.fs.paste                     , 'Paste'                  )
	bufmap( 'n',   'y'      , api.fs.copy.filename             , 'Copy Name'              )
	bufmap( 'n',   'Y'      , api.fs.copy.relative_path        , 'Copy Relative Path'     )
	bufmap( 'n',   'q'      , api.tree.close                   , 'Close'                  )
	bufmap( 'n',   'T'      , api.tree.toggle_custom_filter    , 'Toggle Hidden'          )
	bufmap( 'n',   'I'      , api.tree.toggle_gitignore_filter , 'Toggle Git Ignore'      )
	bufmap( 'n',   'i'      , api.tree.toggle_hidden_filter    , 'Toggle Dotfiles'        )
	bufmap( 'n',   'S'      , api.node.run.cmd                 , 'Run Command'            )
end


return {
	{ 'nvim-tree/nvim-web-devicons' },

	{ 's1n7ax/nvim-window-picker',
		name = 'window-picker',
		event = 'VeryLazy',
		version = '2.*',
		opts = {
			hint = 'floating-big-letter',
			show_prompt = false,
			picker_config = { handle_mouse_click = true, },
		},
	},

	{ 'nvim-tree/nvim-tree.lua',
		dependencies = {
			's1n7ax/nvim-window-picker',
			'nvim-tree/nvim-web-devicons',
		},
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.opt.termguicolors = true

			vim.api.nvim_create_autocmd("BufEnter", {
				nested = true,
				callback = function()
					local utils = require("nvim-tree.utils")

					if #vim.api.nvim_list_wins() == 1 and utils.is_nvim_tree_buf() then
						vim.cmd("quit")
					end
				end
			})

			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function(data)
					local api = require('nvim-tree.api')
					-- buffer is a [No Name]
					local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

					if no_name then
						-- open the tree, find the file but don't focus it
						api.tree.toggle({ focus = false, find_file = true, })
					end
				end
			})
		end,
		opts = function() return {
			on_attach = on_attach,
			disable_netrw = true,
			hijack_cursor = true,
			open_on_tab = false,
			tab = { sync = { open = true, close = true, }, },
			renderer = {
				root_folder_label = false,
				icons = { padding = '  ', },
				highlight_opened_files = 'icon',
				group_empty = true,
			},
			update_focused_file = { enable = false, },
			diagnostics = { enable = true, },
			filters = {
				dotfiles = true,
				exclude = { '.gitignore' },
			},
			actions = {
				change_dir = {
					enable = false,
				},
				open_file = {
					quit_on_open = false,
					resize_window = true,
					window_picker = {
						enable = true,
						picker = require('window-picker').pick_window,
					},
				}
			},
			trash = { cmd = "trash-cli", },
		} end,
		config = function(_, opts)
			local api = require('nvim-tree.api')
			local nvim_tree = require("nvim-tree")

			local Event = api.events.Event

			api.events.subscribe(
				Event.TreeOpen,
				function(_) vim.wo.sidescrolloff = 0 end
			)

			nvim_tree.setup(opts)
		end,
		keys = {
			{"<c-t>", function()
				local api = require('nvim-tree.api')
				api.tree.toggle({
					path = vim.fn.expand('%:p:h'),
					find_file = true,
				})
			end, "nvim-tree: open in cwd" },
		},
	},
}
