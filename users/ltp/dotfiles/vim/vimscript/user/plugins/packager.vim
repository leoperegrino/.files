let plug_path = $XDG_DATA_HOME . '/vim/autoload/plug.vim'
let plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if empty(glob(plug_path))
	echomsg 'clonning plug.vim'
	silent execute '!curl --create-dirs -sfLo ' . plug_path . ' ' . plug_url
endif

call plug#begin($XDG_DATA_HOME . '/vim/plugged')
Plug 'preservim/nerdtree'
Plug 'mbbill/undotree'
Plug 'tpope/vim-commentary'
Plug 'chrisbra/Colorizer'
Plug 'sheerun/vim-polyglot'
call plug#end()
