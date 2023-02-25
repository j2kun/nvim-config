-- Settings specific to tex and latex files

-- .wo is a buffer-local option
vim.wo.spell = true

-- Go to the bib file
--
-- Could be improved: walk up the directory tree until you find
-- the first file ending in .bib
--
-- Could be improved: if the cursor is currently on a citation,
-- then go to that citation in the bib file with something like
--
--   vim.cmd("normal /" .. citation .. vim.api.nvim_replace_termcodes("<CR>", true, true, true))
--
vim.keymap.set('n', '<leader>eb', function()
  -- expand("%:p:h") gets the current filepath's directory
  -- expand("%:p:h:h") gets the parent directory
  local bibfile = vim.fn.expand("%:p:h:h") .. "/book.bib"
  vim.api.nvim_command("botright split " .. bibfile)
  vim.api.nvim_command("resize 15")
  vim.cmd("normal G")
end,
  {noremap = true})
