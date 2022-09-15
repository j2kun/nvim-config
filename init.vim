let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

" Lua modules loaded by require('FOO') are in lua/FOO.lua
lua << EOF
-- Load all plugins first
require('plugins')
-- Set basic settings like mapleader used by later includes
require('settings')

require('autocommands')
require('cmp_config')
require('gitgutter')
require('language_server')
require('mappings')
require('snippets')
require('telescope_config')
require('treesitter')

EOF

" TODO: see :help api-autocmd
" relative numbers for focus + normal mode, absolute for all others
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" NERDtree
nnoremap <leader>t :NERDTreeToggle %<CR>
nnoremap <C-t> :NERDTreeToggle %<CR>

" Highlight LSP matches for variable names
autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
