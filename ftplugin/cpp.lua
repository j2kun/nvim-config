local try_open_in_telescope = function(filename)
  local status, ts_builtin = pcall(require, "telescope.builtin")
  if(status) then
    ts_builtin.find_files({search_file = filename})
  else
    -- fall back if telescope is not installed: just search in current cwd
    -- expand("%:p:h") gets the current filepath
    local path = vim.fn.expand("%:p:h")
    vim.api.nvim_command("botright vsplit " .. path .. "/" .. filename)
  end
end

-- Go to header file for the current cc file
vim.keymap.set('n', '<leader>eh', function()
  -- expand("%:t:r") gets the current filename without suffix
  local filename = vim.fn.expand("%:t:r") .. ".h"
  try_open_in_telescope(filename)
end,
  {noremap = true})

-- Go to cc file for the current header file
vim.keymap.set('n', '<leader>ec', function()
  -- expand("%:t:r") gets the current filename without suffix
  local filename = vim.fn.expand("%:t:r") .. ".cc"
  try_open_in_telescope(filename)
end,
  {noremap = true})
