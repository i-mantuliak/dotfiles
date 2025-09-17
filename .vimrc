syntax on
set number
set relativenumber 
set nocompatible
filetype off
set tabstop=2
set expandtab
set hlsearch
set updatetime=250
set signcolumn=yes
set clipboard=unnamed

" Set leader key
let g:mapleader=' '

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-fugitive'
call plug#end()

let g:airline_theme='gruvbox'
colorscheme gruvbox
set background=dark

" NerdTree
nnoremap \ :NERDTreeToggle<CR>
nnoremap <leader>s :BLines<CR>
nnoremap <leader>f :Files<CR>
