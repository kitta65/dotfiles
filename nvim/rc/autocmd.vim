" bigquery {{{
augroup bigquery
  autocmd!
  autocmd FileType bigquery setlocal foldmethod=indent
  autocmd FileType bigquery nnoremap <buffer> <leader>f :call CocAction('format')<cr>
augroup END
" }}}

" javascript {{{
augroup javascript
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
augroup END
" }}}

" go {{{
augroup go
  autocmd!
  autocmd FileType go setlocal noexpandtab
augroup END
" }}}
