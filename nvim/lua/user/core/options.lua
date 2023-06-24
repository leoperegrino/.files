local M = {}

local o = vim.opt
local g = vim.g


M.setup = function()
	o.undofile = true
	o.swapfile = true
	o.backup = true
	o.writebackup = true
	o.backupdir:remove({ '.' })

	o.autochdir = true
	o.clipboard = 'unnamed'

	o.fileencoding = 'utf-8'
	o.fileformat = 'unix'

	o.shortmess:append('AFI')
	o.completeopt = { 'menu', 'menuone', 'noselect' }
	o.formatoptions:remove({ 'c' })

	-- o.startofline = true
	o.updatetime = 300

	o.signcolumn = 'yes:2'
	o.cursorline = true
	o.colorcolumn = '79'

	o.wrap = false
	o.laststatus = 3
	o.showtabline = 2
	o.showmode = false
	o.showcmd = false
	o.conceallevel = 3

	o.foldmethod = 'syntax'
	o.foldopen:append({ 'insert', 'jump' })
	o.foldopen:remove({ 'block' })
	o.foldminlines = 1
	o.foldlevelstart = 99

	o.shiftwidth = 4
	o.tabstop = 4
	o.softtabstop = 4

	o.scrolloff = 7
	o.sidescrolloff = 15

	o.number = true
	-- o.relativenumber = false

	o.smartindent = true

	o.splitbelow = true
	o.splitright = true

	o.ignorecase = true
	o.smartcase = true
	o.infercase = true

	o.wildmode:prepend({ 'longest' })
	o.wildignorecase = true
	o.wildignore:append({ '*.pyc', '*pycache*' })

	o.matchpairs:append({ '<:>' })

	o.list = true
	o.listchars:append({ tab = '  ', trail = '~' })
	o.fillchars:append({ fold = ' ', eob = ' ' })

	g.mapleader = ' '
	g.xml_syntax_folding = 1
	g.tex_flavor = 'latex'
end


return M
