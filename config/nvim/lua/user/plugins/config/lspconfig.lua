local function diagnostic_config()
	vim.diagnostic.config({
		virtual_text = false,
		update_in_insert = false,
		underline = false,
		severity_sort = true,
		signs = {
			-- https://github.com/neovim/neovim/issues/33144#issuecomment-2763257650
			text = {
				[vim.diagnostic.severity.ERROR] = '',
				[vim.diagnostic.severity.WARN] = '󰀪',
				[vim.diagnostic.severity.HINT] = '󰌶',
				[vim.diagnostic.severity.INFO] = '󰋽',
			},
		},
		float = {
			focus = false,
			focusable = true,
			border = "rounded",
			source = "always",
			header = "",
		},
	})
end


local function handlers()
	-- nvim >= 0.11
	local hover = vim.lsp.buf.hover
	vim.lsp.buf.hover = function()
		---@diagnostic disable-next-line: redundant-parameter
		return hover({
			border = "rounded",
			focusable = true
		})
	end

	local signature_help = vim.lsp.buf.signature_help
	vim.lsp.buf.signature_help = function()
		---@diagnostic disable-next-line: redundant-parameter
		return signature_help({
			border = "rounded",
		})
	end
end


local function highlight_document(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		local augroup = vim.api.nvim_create_augroup
		local group = "lsp_document_highlight"

		local autocmd = function(event, callback, buffer, pattern)
			vim.api.nvim_create_autocmd(event, {
				pattern = pattern,
				group = group,
				buffer = buffer,
				callback = callback
			})
		end

		augroup(group, {})
		autocmd("TextYankPost", function() vim.hl.on_yank({}) end, nil, '*')
		autocmd("CursorHold", vim.lsp.buf.document_highlight, bufnr)
		autocmd("CursorHoldI", vim.lsp.buf.document_highlight, bufnr)
		autocmd("CursorMoved", vim.lsp.buf.clear_references, bufnr)
	end
end


local function toggle_inlay_hints(client, buffer)
	if vim.g.inlay_hints_visible then
		vim.g.inlay_hints_visible = false
		vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
	else
		if client.server_capabilities.inlayHintProvider then
			vim.g.inlay_hints_visible = true
			vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
		end
	end
end


local function keymaps(_, buffer)
	local function keymap(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { desc = desc, })
	end

	local function bufmap(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = buffer, })
	end

	if vim.bo.filetype ~= "vim" and vim.bo.filetype ~= "sh" then
		bufmap("n", "K"   , vim.lsp.buf.hover)
	end

	keymap("n", "[d"         , vim.diagnostic.goto_prev , "lsp: jumps to previous diagnostic")
	keymap("n", "Ç"          , vim.diagnostic.goto_prev , "lsp: jumps to previous diagnostic")
	keymap("n", "]d"         , vim.diagnostic.goto_next , "lsp: jumps to next diagnostic"    )
	keymap("n", "ç"          , vim.diagnostic.goto_next , "lsp: jumps to next diagnostic"    )
	keymap("n", "<leader>eq" , vim.diagnostic.setloclist, "lsp: add buffer diagnostics to the location list")

	bufmap("n", "glr" , vim.lsp.buf.rename                 , "lsp: renames all references"  )
	bufmap("n", "gld" , vim.lsp.buf.definition             , "lsp: jumps to definition"     )
	bufmap("n", "glD" , vim.lsp.buf.declaration            , "lsp: jumps to declaration"    )
	bufmap("n", "gls" , vim.lsp.buf.signature_help         , "lsp: displays signature help" )
	bufmap("n", "glc" , vim.lsp.buf.code_action            , "lsp: selects a code action"   )
	bufmap("n", "glw" , vim.lsp.buf.add_workspace_folder   , "lsp: add folder to workspace" )
	bufmap("n", "glW" , vim.lsp.buf.remove_workspace_folder, "lsp: rm folder from workspace")
	bufmap("n", "glf" , vim.lsp.buf.format                 , "lsp: formats buffer"          )
	bufmap("n", "gll" , "<Cmd>= vim.lsp.buf.list_workspace_folders()<CR>", "lsp: list folders in workspace")

	local ok, telescope = pcall(require, 'telescope.builtin')
	if ok then
		bufmap("n", "gd"  , telescope.lsp_definitions     , "telescope lsp: lsp definitions")
		bufmap("n", "gD"  , function() telescope.lsp_definitions({ jump_type = 'vsplit' }) end, "telescope lsp: lsp definitions")
		bufmap("n", "gI"  , telescope.lsp_implementations , "telescope lsp: lsp implementations")
		bufmap("n", "gt"  , telescope.lsp_type_definitions, "telescope lsp: lsp type definitions")
		bufmap("n", "gr"  , telescope.lsp_references      , "telescope lsp: lsp references")
		bufmap("n", "gL"  , function() vim.diagnostic.setloclist({ open = false }) telescope.loclist()  end, "telescope lsp: location list")
		bufmap("n", "gQ"  , function() vim.diagnostic.setqflist({ open = false })  telescope.quickfix() end, "telescope lsp: quickfix list")
	end
end


-- TODO: configure this according to lazy spec (keys, opts, buffers, config, etc)
return {
	{ 'neovim/nvim-lspconfig',
		opts = function(_, _)
			local capabilities
			local ok, cmp = pcall(require, 'cmp_nvim_lsp')
			if ok then
				capabilities = cmp.default_capabilities()
			end

			return {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					keymaps(client, bufnr)
					highlight_document(client, bufnr)
					toggle_inlay_hints(client, bufnr)
					-- if client:supports_method('textDocument/documentColor') then
					--   vim.lsp.document_color.enable(true, bufnr)
					-- end
				end
			}

		end,
		config = function(_, opts)
			diagnostic_config()
			handlers()
			local lsp_servers = require('user.plugins.lsp_servers')

			for name, config in pairs(lsp_servers) do

				local final = vim.tbl_deep_extend('force', opts, config)

				vim.lsp.config(name, final)
				vim.lsp.enable(name)
			end
		end,
	},
}
