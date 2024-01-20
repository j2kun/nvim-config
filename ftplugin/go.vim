augroup AutoFormat
  autocmd!
  autocmd BufWritePre :lua vim.lsp.buf.format({async = false})
augroup END

