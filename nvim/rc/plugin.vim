" bookmark {{{
let g:bookmark_auto_save = 0
" }}}

" coc {{{
" See https://github.com/neoclide/coc-snippets .
inoremap <silent><expr> <tab> coc#expandableOrJumpable() ? "\<c-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<cr>" : "\<tab>"
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
" vmap <tab> <Plug>(coc-snippets-select)

" See https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources .
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
  nnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
  inoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
  vnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
endif

nnoremap <leader>s :CocCommand snippets.openSnippetFiles<cr>
inoremap <silent><expr> <c-space> coc#refresh()
command! UpdateCache call CocRequestAsync("bigquery", "bq/updateCache")
" }}}

" indentLine {{{
let g:indentLine_fileTypeExclude = ["nerdtree", "json", "help", "markdown", "csv"]
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
" }}}

" vim-prettier {{{
nnoremap <leader>f :PrettierAsync<cr>
" }}}
