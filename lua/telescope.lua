-- Configuration for Telescope picker UI

local telescope = require("telescope")

-- Setup telescope-ui-select, which allows telescope to use nvim builtins
-- like `lua vim.lsp.buf.code_action()`, which was removed from Telescope.
telescope.load_extension("ui-select")
