" bookmark {{{
let g:bookmark_auto_save = 0
" }}}

" indentLine {{{
let g:indentLine_fileTypeExclude = ["nerdtree", "json", "help", "markdown", "csv", "dockerfile"]
" }}}

" neoterm {{{
let g:neoterm_default_mod = 'vertical'
let g:neoterm_autoscroll = 1
let g:neoterm_auto_repl_cmd = 0

nnoremap <expr> <leader>t <SID>MyRepl()
nnoremap <expr><leader>w g:myrepl_current_status ==# "none" ? <SID>MyRepl() : ":Ttoggle\<cr>"
nnoremap <expr> <leader>r g:myrepl_current_status ==# "none" ?
  \ <SID>MyRepl() : ":TREPLSendLine\<cr>\<down>0"
vnoremap <expr> <leader>r g:myrepl_current_status ==# "none" ?
  \ <SID>MyRepl() : ":\<c-u>TREPLSendSelection\<cr>:T \<c-v>\<cr>\<cr>`>"
augroup myrepl
  autocmd!
  autocmd Filetype javascript vnoremap <buffer><expr> <leader>r g:myrepl_current_status ==# "none" ?
    \ <SID>MyRepl() : ":\<c-u>T .editor\<cr>:TREPLSendSelection\<cr>:T \<c-v>\<c-d>\<cr>`>"
augroup END

let g:myrepl_current_status = "none"
function! s:MyRepl()
  if g:myrepl_current_status ==# "none"
    " when NOT active
    if &filetype ==# "python"
      let g:myrepl_exit_command = ":T \<c-v>\<c-c>exit()\<cr>"
      let g:myrepl_current_status = &filetype
      return ":T ipython --no-autoindent\<cr>"
    elseif &filetype ==# "javascriptreact" || &filetype ==# "javascript"
      let g:myrepl_exit_command = ":T \<c-v>\<c-c>.exit\<cr>"
      let g:myrepl_current_status = &filetype
      return ":T node\<cr>"
    else
      let g:myrepl_exit_command = ":T \<c-v>\<c-a>\<c-v>\<c-k>exit\<cr>"
      let g:myrepl_current_status = "shell"
      return ":T echo 'using common repl!'\<cr>"
    endif
  else
    " when active
    if g:myrepl_current_status ==# "shell"
      let g:myrepl_exit_command = ":T \<c-v>\<c-a>\<c-v>\<c-k>exit\<cr>"
      let g:myrepl_current_status = "none"
      return g:myrepl_exit_command
    else
      let g:myrepl_current_status = "shell"
      return g:myrepl_exit_command
    endif
  endif
endfunction
" }}}

" NERDTree {{{
let g:NERDTreeCustomOpenArgs = {'file': {'reuse': 'all', 'where': 't'}, 'dir': {}}
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden = 1
nnoremap <leader>e :NERDTreeFocus<cr>
augroup nerdtree
  autocmd!
  " NOTE <nowait> is added to the default mapping.
  autocmd FileType nerdtree nnoremap <buffer><nowait> m :call nerdtree#ui_glue#invokeKeyMap("m")<cr>
augroup END
" }}}

" vim-prettier {{{
nnoremap <leader>f :PrettierAsync<cr>
" }}}
