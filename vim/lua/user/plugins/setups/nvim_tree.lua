local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end


nvim_tree.setup {
	auto_reload_on_write = true,
	disable_netrw = true,
	hijack_cursor = true,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	ignore_buffer_on_setup = false,
	open_on_setup = false,
	open_on_tab = false,
	respect_buf_cwd = false,
	sort_by = "name",
	update_cwd = false,
	ignore_ft_on_setup = { },
	view = {
		width = 30,
		height = 30,
		hide_root_folder = true,
		side = "left",
		preserve_window_proportions = false,
		signcolumn = "yes",
		number = false,
		relativenumber = false,
		mappings = {
			custom_only = true,
			list = {
				{ key = {"<CR>", "o" }, action = "edit" },
				{ key = "h",            action = "close_node" },
				{ key = "O",            action = "split" },
				{ key = "s",            action = "vsplit" },
				{ key = "U",            action = "dir_up" },
				{ key = "C",            action = "cd" },
				{ key = "<C-k>",        action = "prev_sibling" },
				{ key = "<C-j>",        action = "next_sibling" },
				{ key = "p",            action = "parent_node" },
				{ key = "X",            action = "collapse_all" },
				{ key = "<C-t>",        action = "tabnew" },
				{ key = "?",            action = "toggle_help" },
				{ key = "K",            action = "first_sibling" },
				{ key = "a",            action = "create" },
				{ key = "J",            action = "last_sibling" },
				{ key = "r",            action = "rename" },
				{ key = "R",            action = "refresh" },
				{ key = "x",            action = "cut" },
				{ key = "c",            action = "copy" },
				{ key = "P",            action = "paste" },
				{ key = "y",            action = "copy_name" },
				{ key = "Y",            action = "copy_path" },
				{ key = "q",            action = "close" },
				{ key = "T",            action = "toggle_custom" },
				{ key = "I",            action = "toggle_git_ignored" },
				{ key = "i",            action = "toggle_dotfiles" },
				{ key = "S",            action = "run_file_command" },
			},
		},
	},
	renderer = {
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
}

vim.cmd[[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]]
