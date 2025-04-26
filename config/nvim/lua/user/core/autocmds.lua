local M = {}

local group = vim.api.nvim_create_augroup('user autocmds', { clear = true })
local autocmd = function(event, pattern, callback)
	vim.api.nvim_create_autocmd(event, {
		pattern = pattern,
		callback = callback,
		group = group,
	})
end


M.setup = function()
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
end

return M
