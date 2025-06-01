local M = {}

M.setup = function()
	vim.filetype.add({
		extension = {
			tf = 'terraform',
		},
		filename = {
			['docker-compose.yaml'] = 'yaml.docker-compose',
			['docker-compose.yml'] = 'yaml.docker-compose',
		}
	})
end

return M
