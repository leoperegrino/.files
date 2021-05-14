function! g:SetLinenr(enter) abort
	let blacklist = ['netrw', 'tagbar']
	if index(blacklist, &ft) < 0
		if a:enter == 1
			set number relativenumber
		else
			set norelativenumber
		endif
	endif
endfunction

function! g:ShowDoc()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

function! g:DualScreen() abort
	set lazyredraw
	normal zR
	mark m
	0
	vsplit %
	set scrolloff=0 scrollbind
	normal zRLzt
	wincmd h
	set scrolloff=7 scrollbind
	normal 'm
	normal zz
	set nolazyredraw
endfunction

function! g:ToggleNetrw() abort
	let s:wiped = 0
	for i in range(1, bufnr("$"))
		if getbufvar(i, '&filetype') == "netrw"
			silent exe 'bwipeout ' . i
			let s:wiped = 1
		endif
	endfor
	if s:wiped | return | endif
	Lexplore
	wincmd =
	vertical resize 38
	nmap <buffer>L <CR>
	nnoremap <buffer>z :pclose<CR>
	nnoremap <buffer><C-l> :wincmd l<CR>
	nnoremap <buffer>o :call netrw#Call('NetrwSplit', 5) <bar> wincmd K<CR>
	nnoremap <buffer>v :call netrw#Call('NetrwSplit', 5) <bar> wincmd =<CR>
	setlocal bufhidden=wipe
	setlocal winfixwidth
endfunction
