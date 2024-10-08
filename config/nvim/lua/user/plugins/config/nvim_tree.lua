vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local api = require('nvim-tree.api')
local nvim_tree = require("nvim-tree")
local nvim_tree_utils = require("nvim-tree.utils")


vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and nvim_tree_utils.is_nvim_tree_buf() then
			vim.cmd("quit")
		end
	end
})

local open_nvim_tree = function(data)
	-- buffer is a [No Name]
	local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

	if no_name then
		-- open the tree, find the file but don't focus it
		api.tree.toggle({ focus = false, find_file = true, })
	end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })


local on_attach = function(bufnr)
	local keymap = vim.keymap.set

	local opts = function(desc)
		return {
			desc = 'nvim-tree: ' .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true
		}
	end

	keymap( 'n',   '<CR>'   , api.node.open.edit               , opts('Open')                   )
	keymap( 'n',   'o'      , api.node.open.edit               , opts('Open')                   )
	keymap( 'n',   'h'      , api.node.navigate.parent_close   , opts('Close Directory')        )
	keymap( 'n',   'l'      , api.node.open.edit               , opts('Open')                   )
	keymap( 'n',   'O'      , api.node.open.horizontal         , opts('Open: Horizontal Split') )
	keymap( 'n',   'H'      , api.tree.collapse_all            , opts('Close Dirs recursively '))
	keymap( 'n',   'L'      , api.tree.expand_all              , opts('Open Dirs recursively ') )
	keymap( 'n',   's'      , api.node.open.vertical           , opts('Open: Vertical Split')   )
	keymap( 'n',   'u'      , api.tree.change_root_to_parent   , opts('Up')                     )
	keymap( 'n',   'U'      , api.tree.change_root_to_parent   , opts('Up')                     )
	keymap( 'n',   'C'      , api.tree.change_root_to_node     , opts('CD')                     )
	keymap( 'n',   '<C-k>'  , api.node.navigate.sibling.prev   , opts('Previous Sibling')       )
	keymap( 'n',   '<C-j>'  , api.node.navigate.sibling.next   , opts('Next Sibling')           )
	keymap( 'n',   'p'      , api.node.navigate.parent         , opts('Parent Directory')       )
	keymap( 'n',   't'      , api.node.open.tab                , opts('Open: New Tab')          )
	keymap( 'n',   '?'      , api.tree.toggle_help             , opts('Help')                   )
	keymap( 'n',   'K'      , api.node.navigate.sibling.first  , opts('First Sibling')          )
	keymap( 'n',   'a'      , api.fs.create                    , opts('Create')                 )
	keymap( 'n',   'J'      , api.node.navigate.sibling.last   , opts('Last Sibling')           )
	keymap( 'n',   'r'      , api.fs.rename                    , opts('Rename')                 )
	keymap( 'n',   'R'      , api.tree.reload                  , opts('Refresh')                )
	keymap( 'n',   'x'      , api.fs.cut                       , opts('Cut')                    )
	keymap( 'n',   'c'      , api.fs.copy.node                 , opts('Copy')                   )
	keymap( 'n',   'P'      , api.fs.paste                     , opts('Paste')                  )
	keymap( 'n',   'y'      , api.fs.copy.filename             , opts('Copy Name')              )
	keymap( 'n',   'Y'      , api.fs.copy.relative_path        , opts('Copy Relative Path')     )
	keymap( 'n',   'q'      , api.tree.close                   , opts('Close')                  )
	keymap( 'n',   'T'      , api.tree.toggle_custom_filter    , opts('Toggle Hidden')          )
	keymap( 'n',   'I'      , api.tree.toggle_gitignore_filter , opts('Toggle Git Ignore')      )
	keymap( 'n',   'i'      , api.tree.toggle_hidden_filter    , opts('Toggle Dotfiles')        )
	keymap( 'n',   'S'      , api.node.run.cmd                 , opts('Run Command')            )
end


nvim_tree.setup({
	on_attach = on_attach,
	auto_reload_on_write = true,
	disable_netrw = true,
	hijack_cursor = true,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	open_on_tab = false,
	respect_buf_cwd = false,
	sort_by = "name",
	update_cwd = false,
	view = {
		width = 30,
		side = "left",
		preserve_window_proportions = false,
		signcolumn = "yes",
		number = false,
		relativenumber = false,
	},
	renderer = {
		root_folder_label = false,
		root_folder_modifier = ':h',
		icons = {
			padding = '  ',
			webdev_colors = true,
			glyphs = {
				folder = {
					symlink_open = "",
				}
			},
		},
		highlight_opened_files = 'icon',
		group_empty = true,
		indent_markers = {
			enable = true,
		},
	},
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	update_focused_file = {
		enable = false,
		update_cwd = false,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	filters = {
		dotfiles = true,
		custom = {},
		exclude = {'.gitignore'},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	actions = {
		change_dir = {
			enable = false,
			global = false,
		},
		open_file = {
			quit_on_open = false,
			resize_window = false,
			window_picker = {
				enable = false,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		}
	},
	trash = {
		cmd = "trash-cli",
		require_confirm = true,
	},
	log = {
		enable = false,
		truncate = false,
		types = {
			all = false,
			config = false,
			git = false,
		},
	},
})
