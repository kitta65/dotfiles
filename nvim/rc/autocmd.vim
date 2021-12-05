" bigquery {{{
augroup bigquery
  autocmd!
  autocmd FileType bigquery setlocal foldmethod=indent
  nnoremap <buffer> <leader>f :call CocAction('format')<cr>
augroup END
" }}}

" vim {{{
augroup vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  iabbrev <buffer> == ==#
augroup END
" }}}
