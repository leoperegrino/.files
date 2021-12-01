let g:goyo_width = "50%"
let g:goyo_height = "100%"

function! s:goyo_enter()
	let b:quitting = 0
	let b:quitting_bang = 0
	let b:sintaxe=&syntax
	let b:tipo=&filetype
	autocmd QuitPre <buffer> let b:quitting = 1
	cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
	if b:quitting && len(filter(range(1, bufnr('$')),'buflisted(v:val)')) == 1
		if b:quitting_bang
			qa!
		else
			qa
		endif
	endif
	source ~/.files/vim/highlighting.vim
	source ~/.files/vim/statusline.vim
	exec 'set filetype=' . b:tipo
	exec 'set syntax=' . b:sintaxe
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()
