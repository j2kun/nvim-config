let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

" Lua modules loaded by require('FOO') are in lua/FOO.lua
lua << EOF
require('plugins')
require('settings')
require('treesitter')
require('telescope')
require('language_server')
require('gitgutter')
require('mappings')
require('snippets')
require('autocommands')
EOF

" TODO: see :help api-autocmd
" relative numbers for focus + normal mode, absolute for all others
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" telescope/fuzzy finder
nnoremap <c-p> <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr>
nnoremap <leader>fj <cmd>Telescope jump_list<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fm <cmd>Telescope marks<cr>
" to explore picker options, list them all in the fuzzy finder window
nnoremap <leader>fl <cmd>Telescope builtin<cr>

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
