local M = {}

local function js_callback(ft)
	return function(_, _)
		return ft, function(bufnr)
			vim.bo[bufnr].tabstop = 2
			vim.bo[bufnr].shiftwidth = 2
			vim.bo[bufnr].softtabstop = 2
			vim.bo[bufnr].expandtab = true
		end
	end
end

function M.setup()
	vim.filetype.add({
		extension = {
			tf = 'terraform',
			lock = js_callback('lock'),
			json = js_callback('json'),
			js = js_callback('javascript'),
			ts = js_callback('typescript'),
			jsx = js_callback('javascript'),
			tsx = js_callback('typescript'),
		},
		filename = {
			['docker-compose.yaml'] = 'yaml.docker-compose',
			['docker-compose.yml'] = 'yaml.docker-compose',
		}
	})
end

return M
