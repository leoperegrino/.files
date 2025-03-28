local M = {}

local group = vim.api.nvim_create_augroup('init.lua', { clear = true })
local autocmd = function(event, pattern, callback)
	vim.api.nvim_create_autocmd(event, {
		pattern = pattern,
		callback = callback,
		group = group,
	})
end


M.setup = function()
	autocmd('FileType'    ,  '*'   ,  function() vim.opt.formatoptions:remove({'c', 'r', 'o'})                        end )
	autocmd('FileType'    ,  'qf'  ,  function() vim.cmd[[nnoremap <buffer> <CR> <CR><cmd>lclose<CR><cmd>cclose<CR>]] end )
	autocmd('FileType'    , 'xml'  ,  function() vim.cmd[[set foldmethod=syntax]]                                     end )
	autocmd('FileType'    ,  '*'   ,  function() vim.cmd[[silent! loadview]]                                          end )
	autocmd('BufWrite'    ,  '*'   ,  function() vim.cmd[[mkview]]                                                    end )
	autocmd('BufWritePre' ,  '*'   ,  function() vim.cmd[[call mkdir(expand("<afile>:p:h"), "p")]]                    end )
	autocmd('BufEnter'    ,  '*'   ,  function() vim.cmd[[set noreadonly]]                                            end )
	autocmd('InsertEnter' ,  '*'   ,  function() vim.cmd[[set nolist]]                                                end )
	autocmd('InsertLeave' ,  '*'   ,  function() vim.cmd[[set list]]                                                  end )
	autocmd('CmdlineLeave',  '*'   ,  function() vim.cmd[[echo '']]                                                   end )
	autocmd('ModeChanged' ,  '*:V' ,  function() vim.cmd[[set showcmd]]                                               end )
	autocmd('ModeChanged' ,  'V:*' ,  function() vim.cmd[[set noshowcmd]]                                             end )
end

return M
