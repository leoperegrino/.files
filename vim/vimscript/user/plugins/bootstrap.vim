const plug_path = $XDG_DATA_HOME . '/vim/autoload/plug.vim'
const plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if empty(glob(plug_path))
	echomsg 'clonning plug.vim'
	silent execute '!curl -fLo --create-dirs ' . plug_path . plug_url
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
