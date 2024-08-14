local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require('lspkind')

require("luasnip.loaders.from_vscode").lazy_load()


local function tab_fn(fallback)
	if cmp.visible() then
		cmp.select_next_item()
	elseif luasnip.locally_jumpable(1) then
		luasnip.jump(1)
	else
		fallback()
	end
end

local function shift_tab_fn(fallback)
	if cmp.visible() then
		cmp.select_prev_item()
	elseif luasnip.locally_jumpable(-1) then
		luasnip.jump(-1)
	else
		fallback()
	end
end

local function control_space_fn(fallback)
	if cmp.visible() then
		cmp.confirm({ select = true })
	elseif luasnip.expandable() then
		luasnip.expand()
	else
		-- fallback()
	end
end


cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = { border = 'rounded' },
		documentation = { border = 'rounded' },
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"]     = cmp.mapping(tab_fn, { "i", "s", }),
		['<S-Tab>']   = cmp.mapping(shift_tab_fn, { "i", "s", }),

		['<C-Space>'] = cmp.mapping(control_space_fn),
		['<C-e>']     = cmp.mapping.abort(),

		["<C-b>"]     = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"]     = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "buffer" },
		{ name = "path" },
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
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
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = lspkind.cmp_format({
			menu = ({
				nvim_lsp = "[lsp]",
				nvim_lua = "[lua]",
				cmdline  = "[cmd]",
				luasnip  = "[luasnip]",
				buffer   = "[buffer]",
				path     = "[path]",
			}),
			mode = 'symbol',
			maxwidth = 50,
			ellipsis_char = '...',
			show_labelDetails = true,
		})
	},
	experimental = {
		ghost_text = true,
	},
})
