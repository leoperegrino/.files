local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local lsp_types = require('cmp.types').lsp
require("luasnip.loaders.from_vscode").lazy_load()

local kinds = {
	Class         = { symbol = "", priority = 5  },
	Color         = { symbol = "", priority = 5  },
	Constant      = { symbol = "", priority = 10 },
	Constructor   = { symbol = "", priority = 1  },
	Enum          = { symbol = "", priority = 10 },
	EnumMember    = { symbol = "", priority = 10 },
	Event         = { symbol = "", priority = 10 },
	Field         = { symbol = "", priority = 11 },
	File          = { symbol = "", priority = 8  },
	Folder        = { symbol = "", priority = 8  },
	Function      = { symbol = "", priority = 10 },
	Interface     = { symbol = "", priority = 1  },
	Keyword       = { symbol = "", priority = 2  },
	Method        = { symbol = "m", priority = 10 },
	Module        = { symbol = "", priority = 5  },
	Operator      = { symbol = "", priority = 10 },
	Property      = { symbol = "", priority = 11 },
	Reference     = { symbol = "", priority = 10 },
	Snippet       = { symbol = "", priority = 4  },
	Struct        = { symbol = "", priority = 10 },
	Text          = { symbol = "", priority = 0  },
	TypeParameter = { symbol = "", priority = 1  },
	Unit          = { symbol = "", priority = 1  },
	Value         = { symbol = "", priority = 1  },
	Variable      = { symbol = "", priority = 9  },
}

local kind_comparator = function(symbols)
	return function(entry1, entry2)
		local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
		local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

		local priority1 = symbols[kind1]["priority"] or 0
		local priority2 = symbols[kind2]["priority"] or 0
		if priority1 == priority2 then
			return nil
		end
		return priority1 > priority2
	end
end

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function feed_termcode(str, mode)
    local termcode = vim.api.nvim_replace_termcodes(str, true, true, true)
	vim.api.nvim_feedkeys(termcode, mode, true)
end

local function tab_function(fallback)
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	elseif cmp.visible() then
		cmp.select_next_item()
	elseif has_words_before() then
		cmp.complete()
	else
		fallback()
	end
end

local function shift_tab_fn(fallback)
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	elseif cmp.visible() then
		cmp.select_prev_item()
	else
		fallback()
	end
end

local function control_space_fn(fallback)
	if cmp.visible() then
		cmp.confirm({ select = true })
	elseif luasnip.expandable() then
		luasnip.expand()
	elseif not has_words_before() then
		cmp.complete()
	else
		-- fallback()
	end
end

local function control_n_fn(fallback)
	if cmp.visible() then
		cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
	else
		-- fallback()
	end
end

local function control_p_fn(fallback)
	if cmp.visible() then
		cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
	else
		-- fallback()
	end
end

local function control_j_fn(fallback)
	if luasnip.jumpable(1) then
		luasnip.jump(1)
	elseif cmp.visible() then
		cmp.close()
	else
		-- fallback()
	end
end

local function control_k_fn(fallback)
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	elseif cmp.visible() then
		cmp.close()
	else
		-- fallback()
	end
end

local function format_fn(entry, vim_item)
	vim_item.kind = string.format("%s ", kinds[vim_item.kind]["symbol"])
	vim_item.menu = ({
			nvim_lsp = "[lsp]",
			nvim_lua = "[lua]",
			cmdline  = "[cmd]",
			luasnip  = "[luasnip]",
			buffer   = "[buffer]",
			path     = "[path]",
		})[entry.source.name]
	return vim_item
end

cmp.setup {
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			kind_comparator( kinds ),
			cmp.config.compare.score,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	completion = {
		keyword_length = 2,
	},
	matching = {
		disallow_prefix_unmatching = true,
		disallow_fuzzy_matching = true,
		disallow_partial_matching = true,
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-j>"]     = cmp.mapping(control_j_fn, { "i", "s", }),
		["<C-k>"]     = cmp.mapping(control_k_fn, { "i", "s", }),
		["<C-b>"]     = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"]     = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		['<C-Space>'] = cmp.mapping(control_space_fn),
		['<C-n>']     = cmp.mapping(control_n_fn, { "i", "s", }),
		['<C-p>']     = cmp.mapping(control_p_fn, { "i", "s", }),
		["<Tab>"]     = cmp.mapping(tab_function, { "i", "s", }),
		['<S-Tab>']   = cmp.mapping(shift_tab_fn, { "i", "s", }),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = format_fn,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "buffer" },
		{ name = 'nvim_lsp_signature_help' },
		{ name = "path" },
	},
	window = {
		completion = { border = 'rounded' },
		documentation = { border = 'rounded' },
	},
	experimental = {
		ghost_text = true,
	},
}
