-- Configuration for Telescope picker UI

local tsc = require("telescope")

-- Setup telescope-ui-select, which allows telescope to use nvim builtins
-- like `lua vim.lsp.buf.code_action()`, which was removed from Telescope.
tsc.load_extension("ui-select")

-- For project.nvim, enables :Telescope projects for cross-project navigation.
require('telescope').load_extension('projects')

-- For less common options, list all legal Telescope commands to choose from
vim.keymap.set('n', '<leader>fl', ':Telescope builtin<cr>')

-- For more common options, a dedicated keymap
vim.keymap.set('n', '<c-p>', ':Telescope find_files<cr>')
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fs', ':Telescope grep_string<cr>')
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>fr', ':Telescope registers<cr>')
vim.keymap.set('n', '<leader>fj', ':Telescope jump_list<cr>')
vim.keymap.set('n', '<leader>fo', ':Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader>fm', ':Telescope marks<cr>')
vim.keymap.set('n', '<leader>fp', ':Telescope projects<cr>')
