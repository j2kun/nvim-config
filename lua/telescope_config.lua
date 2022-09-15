-- Configuration for Telescope picker UI

local tsc = require("telescope")

-- Setup telescope-ui-select, which allows telescope to use nvim builtins
-- like `lua vim.lsp.buf.code_action()`, which was removed from Telescope.
tsc.load_extension("ui-select")
