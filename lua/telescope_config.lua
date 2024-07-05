-- Configuration for Telescope picker UI

local tsc = require("telescope")

-- Provide custom filepath mappings that navigate to related files
-- from the current buffer's filepath
require('telescope-alternate').setup({
  mappings = {
    {
      pattern = '**/(.*).h',
      targets = {
        { template = '**/[1].cc',       label = 'cc',       enable_new = false },
        { template = '**/[1].cpp',      label = 'cpp',      enable_new = false },
        { template = '**/[1]Test.cc',   label = 'cc Test',  enable_new = false },
        { template = '**/[1]Test.cpp',  label = 'cpp Test', enable_new = false },
        { template = '**/[1]_test.cc',  label = 'cc test',  enable_new = false },
        { template = '**/[1]_test.cpp', label = 'cpp test', enable_new = false },
        { template = '**/[1].td',       label = 'tablegen', enable_new = false },
      }
    },
    {
      pattern = '**/(.*).cc',
      targets = {
        { template = '**/[1].h',        label = 'header',   enable_new = false },
        { template = '**/[1].cpp',      label = 'cpp',      enable_new = false },
        { template = '**/[1]Test.cc',   label = 'cc Test',  enable_new = false },
        { template = '**/[1]Test.cpp',  label = 'cpp Test', enable_new = false },
        { template = '**/[1]_test.cc',  label = 'cc test',  enable_new = false },
        { template = '**/[1]_test.cpp', label = 'cpp test', enable_new = false },
        { template = '**/[1].td',       label = 'tablegen', enable_new = false },
      }
    },
    {
      pattern = '**/(.*).cpp',
      targets = {
        { template = '**/[1].h',        label = 'header',   enable_new = false },
        { template = '**/[1].cc',       label = 'cc',       enable_new = false },
        { template = '**/[1]Test.cc',   label = 'test',     enable_new = false },
        { template = '**/[1]Test.cpp',  label = 'test',     enable_new = false },
        { template = '**/[1]_test.cc',  label = 'test',     enable_new = false },
        { template = '**/[1]_test.cpp', label = 'test',     enable_new = false },
        { template = '**/[1].td',       label = 'tablegen', enable_new = false },
      }
    },
    {
      pattern = '**/(.*).td',
      targets = {
        { template = '**/[1].h',        label = 'header',   enable_new = false },
        { template = '**/[1].cc',       label = 'cc',       enable_new = false },
        { template = '**/[1].cpp',      label = 'cpp',      enable_new = false },
      }
    },
    {
      pattern = '(.*)Test.(.*)',
      targets = {
        { template = '**/[1].[2]', label = 'implementation', enable_new = false },
      }
    },
    {
      pattern = '(.*)_test.(.*)',
      targets = {
        { template = '**/[1].[2]', label = 'implementation', enable_new = false },
      }
    },
  },
  open_only_one_with = 'vertical_split',
  -- custom fns that can be used in mappings above to transform names
  transformers = {},
})
tsc.load_extension('telescope-alternate')

require('telescope').load_extension('textcase')
vim.api.nvim_set_keymap('n', '<leader>cc', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Telescope" })
vim.api.nvim_set_keymap('v', '<leader>cc', '<cmd>TextCaseOpenTelescope<CR>', { desc = "Telescope" })

-- Setup telescope-ui-select, which allows telescope to use nvim builtins
-- like `lua vim.lsp.buf.code_action()`, which was removed from Telescope.
tsc.load_extension("ui-select")

-- For project.nvim, enables :Telescope projects for cross-project navigation.
tsc.load_extension('projects')

-- For less common options, list all legal Telescope commands to choose from
vim.keymap.set('n', '<leader>fl', ':Telescope builtin<cr>')

-- For more common options, a dedicated keymap
vim.keymap.set('n', '<c-p>', ':Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fs', ':Telescope grep_string<cr>')
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>fr', ':Telescope registers<cr>')
vim.keymap.set('n', '<leader>fo', ':Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader>fm', ':Telescope marks<cr>')
vim.keymap.set('n', '<leader>fp', ':Telescope projects<cr>')

-- see lua/mappings.lua for other `<leader>e*` mappings
vim.keymap.set('n', '<leader>er', ':Telescope telescope-alternate alternate_file<cr>')
