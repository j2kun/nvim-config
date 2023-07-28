augroup AutoFormat
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat buildifier
augroup END
