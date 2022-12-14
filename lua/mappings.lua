-- Jump to vim config
vim.keymap.set('n', '<leader>ve', ':vsp $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>vs', ':source $MYVIMRC<CR>')

-- faster ESC from insert mode
vim.keymap.set('i', 'jk', '<ESC>')

-- move vertically by visual line
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Align/wrap current paragraph
vim.keymap.set('n', '<leader>gq', 'vipgq')

-- Sort and dedupe current paragraph by line
vim.keymap.set('n', '<leader>s', 'vip:sort u<CR>')

-- make word upper/lower case
vim.keymap.set('n', '<leader>U', 'viwU')
vim.keymap.set('n', '<leader>u', 'viwu')

-- Open any file in the same directory in a vsplit,
-- but where you can type and auto-complete the filename
vim.keymap.set('n', '<leader>ev', ':vsplit <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set('n', '<leader>es', ':split <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set('n', '<leader>ee', ':edit <C-R>=expand("%:p:h") . "/" <CR>')
