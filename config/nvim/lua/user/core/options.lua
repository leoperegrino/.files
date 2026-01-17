local M = {}

local o = vim.opt
local g = vim.g


function M.global()
	o.backup = true
	o.writebackup = true
	o.backupdir:remove({ '.' })

	o.autochdir = false
	o.clipboard = 'unnamed'

	o.shortmess:append('AFI')

	o.updatetime = 300

	o.laststatus = 3
	o.showtabline = 2
	o.showmode = false
	o.showcmd = false

	o.foldopen:append({ 'insert', 'jump' })
	o.foldopen:remove({ 'block' })

	o.foldlevelstart = 99

	o.splitbelow = true
	o.splitright = true

	o.ignorecase = true
	o.smartcase = true

	o.wildmode:prepend({ 'longest' })
	o.wildignorecase = true
	o.wildignore:append({ '*.pyc', '*pycache*' })
end


function M.global_local()
	o.completeopt = { 'menu', 'menuone', 'noselect' }

	o.scrolloff = 7
	-- o.sidescrolloff = 15

	o.listchars:append({ tab = '  ', trail = '~' })
	o.fillchars:append({ fold = ' ', eob = ' ' })
end


function M.buffer()
	o.undofile = true
	o.swapfile = true

	o.fileencoding = 'utf-8'
	o.fileformat = 'unix'

	o.shiftwidth = 4
	o.tabstop = 4
	o.softtabstop = 4

	o.smartindent = true
	o.cindent = true
	o.cinkeys:remove({'0#'})

	o.infercase = true

	o.matchpairs:append({ '<:>' })
end


function M.window()
	o.signcolumn = 'yes:2'

	o.cursorline = true
	o.colorcolumn = '79'

	o.wrap = false

	o.conceallevel = 3

	o.foldenable = true
	o.foldmethod = 'syntax'

	o.foldminlines = 4

	o.number = true
	o.relativenumber = false

	o.list = true
end


function M.setup()
	M.global()
	M.global_local()
	M.buffer()
	M.window()


	g.mapleader = ' '
	g.xml_syntax_folding = 1
	g.tex_flavor = 'latex'
end


return M
