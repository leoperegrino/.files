local M = {}


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


M.merge = function(t, u)
	t = t or {}
	u = u or {}
	for k, v in pairs(u) do
		t[k] = v
	end
	return t
end


return M
