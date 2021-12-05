" bookmark {{{
let g:bookmark_auto_save = 0
" }}}

" coc {{{
command! UpdateCache call CocRequestAsync("bigquery", "bq/updateCache")
inoremap <silent><expr> <tab> coc#expandableOrJumpable() ? "\<c-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<cr>" : "\<tab>"
vmap <tab> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
nnoremap <leader>s :CocCommand snippets.openSnippetFiles<cr>
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <silent> K :call <SID>show_documentation()<CR>
inoremap <silent><expr> <c-space> coc#refresh()
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
    nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
" }}}

" indentLine {{{
"autocmd Filetype markdown,json,tex IndentLinesDisable
let g:indentLine_setConceal = 0
" }}}

" neoterm {{{
let g:neoterm_default_mod = 'vertical'
let g:neoterm_autoscroll = 1
let g:neoterm_auto_repl_cmd = 0
tnoremap jk <c-\><c-n>
nnoremap <expr><leader>r g:myrepl_current_status == "none" ?
    \ MyRepl() : ":TREPLSendLine\<cr>\<down>0"
"nnoremap :: q:iT<space>
vnoremap <expr><leader>r g:myrepl_current_status == "none" ?
    \ MyRepl() : ":\<c-u>TREPLSendSelection\<cr>:T\<space>\<c-v>\<cr>\<cr>`>"
autocmd Filetype javascript vnoremap <buffer> <expr><leader>r g:myrepl_current_status == "none" ?
    \ MyRepl() : ":\<c-u>T\<space>.editor\<cr>:TREPLSendSelection\<cr>:T\<space>\<c-v>\<c-d>\<cr>`>"
nnoremap <expr><leader>t MyRepl()
let g:myrepl_current_status = "none"
function! MyRepl()
    if g:myrepl_current_status == "none"
        if &filetype == "python"
            let g:myrepl_exit_command = ":T \<c-v>\<c-c>exit()\<cr>"
            let g:myrepl_current_status = &filetype
            return ":T ipython --no-autoindent\<cr>"
        elseif &filetype == "javascriptreact" || &filetype == "javascript"
            let g:myrepl_exit_command = ":T \<c-v>\<c-c>.exit\<cr>"
            let g:myrepl_current_status = &filetype
            return ":T node\<cr>"
        else
            let g:myrepl_exit_command = ":T \<c-v>\<c-a>\<c-v>\<c-k>exit\<cr>"
            let g:myrepl_current_status = "shell"
            return ":T echo 'using common repl!'\<cr>"
        endif
    else
        if g:myrepl_current_status == "shell"
            let g:myrepl_exit_command = ":T \<c-v>\<c-a>\<c-v>\<c-k>exit\<cr>"
            let g:myrepl_current_status = "none"
            return g:myrepl_exit_command
        else
            let g:myrepl_current_status = "shell"
            return g:myrepl_exit_command
        endif
    endif
endfunction
nnoremap <expr><leader>w g:myrepl_current_status == "none" ? MyRepl() : ":Ttoggle\<cr>"
" }}}

" NERDTree {{{
let g:NERDTreeCustomOpenArgs = {'file': {'reuse': 'all', 'where': 't'}, 'dir': {}}
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden = 1
nnoremap <leader>n :NERDTreeFocus<cr>
" }}}

