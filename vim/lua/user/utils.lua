local M = {}


---function to create a closure with a specific options table
---@param opts table
---@return function
M.keymap_with = function(opts)
	return function(mode, key, map)
		vim.keymap.set(mode, key, map, opts)
	end
end


---alias for the nvim api that will follow links recursively
---@param name string
---@return table
M.get_hl = function(name)
	local hl = vim.api.nvim_get_hl(0, { name = name })

	if hl.link then
		return M.get_hl(hl.link)
	end

	return hl
end


M.set_hl = function(name, val)
	return vim.api.nvim_set_hl(0, name, val)
end


M.link_hl = function(name, link)
	return M.set_hl(name, { link = link })
end


M.update_hl = function(name, val)
	local current = M.get_hl(name)

	local new = M.merge(current, val)

	return M.set_hl(name, new)
end


M.copy = function(original)
	local shallow = {}
	for key, value in pairs(original) do
		shallow[key] = value
	end
	return shallow
end


---shallow merge two tables returning a new one
---@param t table
---@param u table
---@return table
M.merge = function(t, u)
	local new = {}
	t = t or {}
	u = u or {}
	for _, tbl in ipairs({t, u}) do
		for k, v in pairs(tbl) do
			new[k] = v
		end
	end
	return new
end


return M
