" automatically download vimplug if not available
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" reload configuration on save
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
  augroup END
endif " has autocmd

" Leader
let mapleader = ";"

" output beautifull colors, but I still do not understand why!
set termguicolors

call plug#begin()

" Essential
" Side bar explorer
Plug 'scrooloose/nerdTree', {'tag': '5.3.1'}
" Language server protocol support (see ./coc-settings.json)
Plug 'neoclide/coc.nvim', {'tag': 'v0.0.74'} 
" Better bar
Plug 'itchyny/lightline.vim'
" Git integration
Plug 'tpope/vim-fugitive', { 'tag': 'v3.0' }
" See git branches just like vs code tree view :GV
Plug 'junegunn/gv.vim'
" Open any file by name :Files or by content :Ag
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" surround txt with what you want
Plug 'tpope/vim-surround', { 'tag':'v2.1' }
" easy comment 
Plug 'scrooloose/nerdcommenter'

" Golang
Plug 'fatih/vim-go', { 'tag': 'v1.20' }
Plug 'sebdah/vim-delve'

" Fish
Plug 'dag/vim-fish'

" Preview Images as ASCII art, requires python Pillow
" Plug 'DougBeney/image.vim'
"

call plug#end()

" open close tree
nmap <C-n> :NERDTreeToggle<CR>

" quick navigation between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Visualization options
set tabstop=4
set shiftwidth=4
set expandtab
set autowrite
set number
syntax enable
filetype plugin indent on

" open autocomplete
"inoremap <leader>s <c-x><c-o><c-o>

" close buffer easily
noremap <leader>q :q<CR>
" save easily
noremap <leader>w :w<CR>

" Find files
nnoremap <C-p> :Files<Cr>

let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [  'gitbranch','cocstatus','readonly', 'filename', 'modified'] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head',
            \   'cocstatus': 'coc#status'
            \ }
            \ }

