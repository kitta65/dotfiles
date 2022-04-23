" common {{{
augroup common
  autocmd!
  autocmd FileType * syntax sync minlines=10000
augroup END
" }}}

" bigquery {{{
augroup bigquery
  autocmd!
  autocmd FileType bigquery setlocal foldmethod=indent
  autocmd FileType bigquery nnoremap <buffer> <leader>f :call CocAction('format')<cr>
augroup END
" }}}

" vim {{{
augroup vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim iabbrev <buffer> == ==#
  " do not quote!
  autocmd FileType vim inoremap <buffer> "<space> "<space>
augroup END
" }}}

" go {{{
augroup go
  autocmd!
  autocmd FileType go setlocal noexpandtab
augroup END
" }}}

" markdown {{{
augroup markdown
  autocmd!
  autocmd FileType markdown setlocal conceallevel=1
  autocmd FileType markdown setlocal concealcursor=
  " overwrite markdwonUrl
  autocmd FileType markdown syntax match markdownUrl "\S\+" nextgroup=markdownUrlTitle skipwhite contained conceal cchar=∞
augroup END
" }}}