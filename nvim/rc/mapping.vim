" NERDTree {{{
nnoremap <leader>n :NERDTreeFocus<cr>
" }}}

" move {{{
noremap! <c-j> <down>
tnoremap <c-j> <down>
noremap! <c-k> <up>
tnoremap <c-k> <up>
noremap! <c-l> <right>
tnoremap <c-l> <right>
nnoremap <s-g> <s-g>$
vnoremap <s-g> <s-g>g_
nnoremap gg gg0
vnoremap gg gg0
vnoremap $ g_
" }}}

" tab {{{
nnoremap <c-]> :tabn<cr>
nnoremap <c-[> :tabp<cr>
" }}}

" window {{{
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
" }}}

" yank, put {{{
vnoremap <leader>y <esc>:ClipboardYank<cr>
nnoremap <leader>p :ClipboardPut<cr>
" }}}
