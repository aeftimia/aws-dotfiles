set nomodeline
set encoding=utf8

" WTF is up with vim defaults?!
set timeoutlen=1000 ttimeoutlen=0

" Don't overwrite buffer when pasting
xnoremap <expr> p 'pgv"'.v:register.'y`>'

" Stop word wrapping
set nowrap
" Except... on Makrdown. That's good stuff.
autocmd FileType markdown setlocal wrap
" Adjust system undo levels
set undolevels=100

" source the ~.bashrc
set shell=bash\ --login

" Use system clipboard
set clipboard=unnamed

" Set tab width and convert tabs to spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Don't let Vim hide characters or make loud dings
set conceallevel=1

" Number gutter with relative line numbers
" Relative lines encourage smarter movements in vim
set number
set relativenumber
let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

" Use search highlighting
set hlsearch

syntax on

" Space above/beside cursor from screen edges
set scrolloff=1
set sidescrolloff=5

" Enable mouse support
set mouse=a

" Filetype indent
filetype indent on

" Configuration 
" indentLine
let g:indentLine_enabled = 1
let g:indentLine_char = "⟩"

" yank to clipboard
if has("clipboard")
   set clipboard=unnamed " copy to the system clipboard
endif

" Auto resize panes
autocmd WinEnter * wincmd =
autocmd VimResized * wincmd =

"
" Wrap window-move-cursor
"
function! s:GotoNextWindow( direction, count )
    let l:prevWinNr = winnr()
    execute a:count . 'wincmd' a:direction
    return winnr() != l:prevWinNr
endfunction

function! s:JumpWithWrap( direction, opposite )
    if ! s:GotoNextWindow(a:direction, v:count1)
        while s:GotoNextWindow(a:opposite, v:count1)
        endwhile
    endif
endfunction

nnoremap <silent> <C-w>h :<C-u>call <SID>JumpWithWrap('h', 'l')<CR>
nnoremap <silent> <C-w>j :<C-u>call <SID>JumpWithWrap('j', 'k')<CR>
nnoremap <silent> <C-w>k :<C-u>call <SID>JumpWithWrap('k', 'j')<CR>
nnoremap <silent> <C-w>l :<C-u>call <SID>JumpWithWrap('l', 'h')<CR>
nnoremap <silent> <C-w><Left> :<C-u>call <SID>JumpWithWrap('h', 'l')<CR>
nnoremap <silent> <C-w><Down> :<C-u>call <SID>JumpWithWrap('j', 'k')<CR>
nnoremap <silent> <C-w><Up> :<C-u>call <SID>JumpWithWrap('k', 'j')<CR>
nnoremap <silent> <C-w><Right> :<C-u>call <SID>JumpWithWrap('l', 'h')<CR>

" Just enough terminal emulation
vnoremap <CR> ypo<CR><ESC>mz2kV :'<,'>!bash<CR>`z

" Interactive shell to load aliases and such
set shell=/bin/bash\ -i
