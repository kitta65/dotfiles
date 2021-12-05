" leader {{{
" If you map `<leader>x` and `<localleader>x` differently,
" most recently defined mapping will work.
let mapleader = "\<space>"
let maplocalleader = "\<space>"
" }}}

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

" quote {{{
inoremap ( )<left>(
tnoremap ( )<left>(
inoremap { }<left>{
tnoremap { }<left>{
inoremap [ ]<left>[
tnoremap [ ]<left>[
inoremap < ><left><
inoremap <<space> <<space>
inoremap <= <=
inoremap " "<left>"
tnoremap " "<left>"
inoremap ' '<left>'
tnoremap ' '<left>'
inoremap ` `<left>`
tnoremap ` `<left>`
inoremap (<cr> ()<left><cr><esc><s-o>
inoremap {<cr> {}<left><cr><esc><s-o>
inoremap [<cr> []<left><cr><esc><s-o>
function! s:Quote(left, ...)
  let right = get(a:000, 0, a:left)
  execute "normal! `>"
  execute "normal! a" . right
  execute "normal! `<"
  execute "normal! i" . a:left
endfunction
vnoremap "  :<c-u>call <SID>Quote('"')<cr>
vnoremap '  :<c-u>call <SID>Quote("'")<cr>
vnoremap `  :<c-u>call <SID>Quote("`")<cr>
vnoremap {  :<c-u>call <SID>Quote("{",     "}")<cr>
vnoremap (  :<c-u>call <SID>Quote("(",     ")")<cr>
vnoremap [  :<c-u>call <SID>Quote("[",     "]")<cr>
vnoremap <  :<c-u>call <SID>Quote("<",     ">")<cr>
vnoremap /* :<c-u>call <SID>Quote("/* ",   " */")<cr>
vnoremap <! :<c-u>call <SID>Quote("<!-- ", " -->")<cr>
" }}}

" other {{{
nnoremap / /\v
noremap! jk <esc>
vnoremap v <esc>
inoremap <c-u> <esc>viw<s-u>ea
nnoremap <leader><cr> <c-]>
" }}}
