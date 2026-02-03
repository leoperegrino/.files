local M = {}

local group = vim.api.nvim_create_augroup('user autocmds', { clear = true })
local function autocmd(event, pattern, callback)
	vim.api.nvim_create_autocmd(event, {
		pattern = pattern,
		callback = callback,
		group = group,
	})
end

local function two_space(ft)
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
	autocmd('FileType'    ,  'qf'  ,  function() vim.cmd[[nnoremap <buffer> <CR> <CR><cmd>lclose<CR><cmd>cclose<CR>]] end )
	autocmd('FileType'    ,  '*'   ,  function() vim.opt.formatoptions:remove({'c', 'r', 'o'})                        end )
	autocmd('FileType'    ,  '*'   ,  function() vim.cmd[[normal! zX]] vim.cmd[[silent! loadview]]                    end )
	autocmd('BufWrite'    ,  '*'   ,  function() vim.cmd[[mkview!]]                                                   end )
	autocmd('BufWritePre' ,  '*'   ,  function() vim.cmd[[call mkdir(expand("<afile>:p:h"), "p")]]                    end )
	autocmd('BufEnter'    ,  '*'   ,  function() vim.cmd[[set noreadonly]]                                            end )
	autocmd('InsertEnter' ,  '*'   ,  function() vim.cmd[[set nolist]]                                                end )
	autocmd('InsertLeave' ,  '*'   ,  function() vim.cmd[[set list]]                                                  end )
	autocmd('CmdlineLeave',  '*'   ,  function() vim.cmd[[echo '']]                                                   end )
	autocmd('ModeChanged' ,  '*:V' ,  function() vim.cmd[[set showcmd]]                                               end )
	autocmd('ModeChanged' ,  'V:*' ,  function() vim.cmd[[set noshowcmd]]                                             end )

	vim.filetype.add({
		extension = {
			tf = two_space('terraform'),
			lock = two_space('lock'),
			json = two_space('json'),
			js = two_space('javascript'),
			ts = two_space('typescript'),
			jsx = two_space('javascript'),
			tsx = two_space('typescript'),
			nix = two_space('nix'),
		},
		filename = {
			['docker-compose.yaml'] = 'yaml.docker-compose',
			['docker-compose.yml'] = 'yaml.docker-compose',
		}
	})
end

return M
