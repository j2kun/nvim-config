-- Go to header file for the current cc file
vim.keymap.set('n', '<leader>eh', function()
  -- expand("%:p:h") gets the current filepath
  local path = vim.fn.expand("%:p:h")
  -- expand("%:t:r") gets the current filename without suffix
  local filename = vim.fn.expand("%:t:r") .. ".h"
  vim.api.nvim_command("botright vsplit " .. path .. "/" .. filename)
end,
  {noremap = true})

-- Go to cc file for the current header file
vim.keymap.set('n', '<leader>ec', function()
  -- expand("%:p:h") gets the current filepath
  local path = vim.fn.expand("%:p:h")
  -- expand("%:t:r") gets the current filename without suffix
  local filename = vim.fn.expand("%:t:r") .. ".cc"
  vim.api.nvim_command("botright vsplit " .. path .. "/" .. filename)
end,
  {noremap = true})
