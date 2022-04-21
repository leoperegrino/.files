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

function! g:ShowDoc() abort
	if (index(['vim','help'], &filetype) >= 0)
		execute 'help' expand('<cword>')
	elseif (index(['','text'], &filetype) >= 0)
		silent! execute 'TranslateW' getline('.')
	elseif &filetype == 'tex'
		VimtexDocPackage
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

function! g:SmoothScroll(direction) abort
	let s:lines = line('w$') - line('w0') + 1
	let s:middle = (line('w0') + round(s:lines / 2) - 1)

	if a:direction == 'down'
		normal j
		if line('.') == s:middle + 1
			normal zz
		elseif line('.') > s:middle + 1
			exe "normal! 2\<c-e>"
		endif
	elseif a:direction == 'up'
		normal k
		if line('.') == s:middle - 1
			normal zz
		elseif line('.') < s:middle - 1
			exe "normal! 2\<c-y>"
		endif
	endif
endfunction

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
