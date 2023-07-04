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

-- Toggle code outline
vim.keymap.set('n', '<leader>o', ':SymbolsOutline<CR>')

-- navigate to bazel build target for current file
vim.keymap.set('n', '<leader>eb', function()
  -- expand("%:p:h") gets the current filepath
  local buildfile = vim.fn.expand("%:p:h") .. "/BUILD"
  -- expand("%:t") gets the current filename with suffix.
  local target = vim.fn.expand("%:t")
  vim.api.nvim_command("botright vsplit " .. buildfile)
  vim.cmd("normal /" .. target .. vim.api.nvim_replace_termcodes("<CR>", true, true, true))
  vim.cmd("normal zz")
end,
{noremap = true})

