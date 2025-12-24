-- Configuration for language server support.
-- Setup lspconfig.
-- vim.lsp.set_log_level("INFO")
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()

local bufnr = 0  -- current buffer
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local opts = { noremap = true, silent = true }

-- set keymappings for interacting with the LSP.
-- They use Telescope so that the results show up in a nice fuzzy-finder popup
buf_set_keymap('n', '<leader>=b', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
buf_set_keymap('n', '<leader>kD', '<cmd>lua require("telescope.builtin").lsp_document_diagnostics()<CR>', opts)
buf_set_keymap('n', '<leader>ka', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', '<leader>kd', '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', opts)
buf_set_keymap('n', '<leader>ki', '<cmd>lua require("telescope.builtin").lsp_implementations()<CR>', opts)
buf_set_keymap('n', '<leader>kn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<leader>kr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
buf_set_keymap('n', '<leader>ks', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', '<leader>kt', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<CR>', opts)
buf_set_keymap('n', '<leader>kK', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)

-- config-less LSPs
local skip = string.find(vim.loop.cwd(), "google3")
if not skip then
  vim.lsp.enable('clangd')
  vim.lsp.enable('pyright')
  vim.lsp.enable('gopls')
  vim.lsp.enable('yamlls')
  vim.lsp.enable('tblgen_lsp_server')
end

vim.lsp.enable('pylsp')
vim.lsp.config('pylsp', {
  -- capabilities = capabilities,
  -- cmd = { os.getenv("HOME") .. "/.config/nvim/venv/bin/pylsp" },
  -- For debugging
  cmd = {os.getenv("HOME") .. "/.config/nvim/venv/bin/pylsp", "--log-file=/tmp/pylsp.log" },
  settings = {
    pylsp = {
      plugins = {
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        black = { enabled = true },
        pycodestyle = { enabled = false },
        flake8 = { enabled = false },
      },
    },
  },
})

vim.lsp.enable('texlab')
vim.lsp.config('texlab', {
  -- capabilities = capabilities,
  cmd = { "texlab" },
  -- For debugging
  -- cmd = {"texlab", "-vvvv", "--log-file=/tmp/texlab.log" },
  settings = {
    texlab = {
      chktex = {
        onEdit = true,
        onOpenAndSave = true
      }
    },
  }
})

vim.lsp.enable('rust_analyzer')
vim.lsp.config('rust_analyzer', {
  -- capabilities = capabilities,
  -- WORKSPACE to support rust in google3 (when there is no Cargo.toml, like in
  -- writing a binary in experimental)
  root_dir = require('lspconfig.util').root_pattern('Cargo.toml', 'WORKSPACE'),
  settings = {
    ["rust-analyzer"] = {
      procMacro = {
        enable = true
      },
    },
  }
})

-- Only try to configure lua lsp if it is installed in the right location
local lua_ls_root_path = vim.fn.expand('~/.local/lua-language-server')
if vim.fn.isdirectory(lua_ls_root_path) == 1 then
  local lua_ls_binary_path = lua_ls_root_path .. "/bin/lua-language-server"

  vim.lsp.enable('lua_ls')
  vim.lsp.config('lua_ls', {
    -- capabilities = capabilities,
    cmd = { lua_ls_binary_path, "-E", lua_ls_root_path .. "/main.lua" },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  })
end

vim.lsp.enable('mlir_lsp_server')
local mlir_lsp_binary = "heir-lsp"
if vim.fn.executable("heir-lsp") == 0 then
  mlir_lsp_binary = "mlir-lsp-server"
end
vim.lsp.config('mlir_lsp_server', {
  -- on_attach = on_attach,
  -- capabilities = capabilities,
  cmd = { mlir_lsp_binary },
})

-- Show diagnostics in the buffer
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = false,
  underline = true,
  update_in_insert = false,
})

vim.cmd [[
  highlight LspDiagnosticsLineNrError guibg=#51202A guifg=#FF0000 gui=bold
  highlight LspDiagnosticsLineNrWarning guibg=#51412A guifg=#FFA500 gui=bold
  highlight LspDiagnosticsLineNrInformation guibg=#1E535D guifg=#00FFFF gui=bold
  highlight LspDiagnosticsLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

  sign define DiagnosticSignError text= texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsLineNrError
  sign define DiagnosticSignWarn text= texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsLineNrWarning
  sign define DiagnosticSignInfo text= texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsLineNrInformation
  sign define DiagnosticSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsLineNrHint
]]
