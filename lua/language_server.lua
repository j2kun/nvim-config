-- Configuration for language server support.
-- Setup lspconfig.
local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Custom language server attach handler configures keymappings
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap = true, silent = true }

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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

  -- Telescope LSP mappings for fuzzy finder
  buf_set_keymap('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', opts)

  -- next diagnostics, like gitgutter ]c
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
end

nvim_lsp.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { os.getenv("HOME") .. "/.config/nvim/venv/bin/pylsp" },
  -- For debugging
  -- cmd = {os.getenv("HOME") .. "/.config/nvim/venv/bin/pylsp", "--log-file=/tmp/pylsp.log" },
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
}

nvim_lsp.texlab.setup {
  on_attach = on_attach,
  capabilities = capabilities,
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
}

nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  -- WORKSPACE to support rust in google3 (when there is no Cargo.toml, like in
  -- writing a binary in experimental)
  root_dir = nvim_lsp.util.root_pattern('Cargo.toml', 'WORKSPACE'),
  settings = {
    ["rust-analyzer"] = {
      procMacro = {
        enable = true
      },
    },
  }
}

-- Only try to configure lua lsp if it is installed in the right location
local lua_ls_root_path = vim.fn.expand('~/.local/lua-language-server')
if vim.fn.isdirectory(lua_ls_root_path) == 1 then
  local lua_ls_binary_path = lua_ls_root_path .. "/bin/lua-language-server"

  require 'lspconfig'.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
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
  }
end

-- For LSP servers that need no special configuration
-- except for the capabilities attachment: just check
-- for the existence of a binary and load the LSP.
-- key = lspconfig name, value = binary name
local configlessLSPs = {
  clangd = "clangd",
  mlir_lsp_server = "heir-lsp",
  tblgen_lsp_server = "tblgen-lsp-server",
  yamlls = "yaml-language-server",
  gopls = "gopls",
}

for lspconfig_name, lsp_binary in pairs(configlessLSPs)
do
  -- Skip clangd if in google3
  local skip = lspconfig_name == "clangd" and string.find(vim.loop.cwd(), "google3")
  if not skip then
    -- fall back to mlir-lsp-server if heir-lsp is not available
    if lspconfig_name == "mlir_lsp_server" and vim.fn.executable("heir-lsp") == 0 then
      lsp_binary = "mlir-lsp-server"
    end
    if vim.fn.executable(lsp_binary) == 1 then
      nvim_lsp[lspconfig_name].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { lsp_binary },
      }
    end
  end
end

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
