local Plug = vim.fn['plug#']

vim.call('plug#begin', vim.fn.stdpath("data") .. '/plugged')

Plug('folke/tokyonight.nvim', { ['branch'] = 'main' })

-- testing out new rooter plugin
-- Plug 'notjedi/nvim-rooter.lua'
Plug 'ahmedkhalf/project.nvim'

Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'lervag/vimtex'

-- Set up treesitter (see treesitter.lua)
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
-- Plugins for treesitter
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'mechatroner/rainbow_csv'
Plug 'overcache/NeoSolarized'
Plug 'preservim/nerdtree'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'

-- conver between various programming cases
Plug 'johmsalas/text-case.nvim'

Plug 'neovim/nvim-lspconfig'

-- autocompletion, with spearate plugins for each source
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-calc'
Plug 'kdheepak/cmp-latex-symbols'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

-- Formatting for file types and languages that don't have LSPs
Plug 'sbdchd/neoformat'

-- nvim-cmp menu appearance
Plug 'onsails/lspkind.nvim'

-- vsnip snippets for lots of languages
Plug 'rafamadriz/friendly-snippets'

-- Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
-- Allows Telescope to use neovim builtins, like `vim.lsp.buf.code_action()`
Plug 'nvim-telescope/telescope-ui-select.nvim'
-- Set up custom mappings from a file to "related" files
Plug 'otavioschwanck/telescope-alternate.nvim'

-- Code outline
Plug 'simrat39/symbols-outline.nvim'

-- Swapping text objects using treesitter nodes
Plug 'mizlan/iswap.nvim'

-- Experimental changes to UI for cmdline and notifications
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'folke/noice.nvim'
Plug 'smjonas/inc-rename.nvim'

-- displays a popup with possible key bindings of the command you started
-- typing
Plug 'folke/which-key.nvim'

-- On first usage, run
-- :Copilot setup
Plug 'github/copilot.vim'

vim.call('plug#end')


-- Plugins that require no special config,
-- but must have their setup called to function.
-- require('nvim-rooter').setup()
require('symbols-outline').setup()
require('inc_rename').setup()
require('textcase').setup()
require('which-key').setup()

require("project_nvim").setup {
  show_hidden = true,
  silent_chdir = true, -- for debugging, this will tell you the cwd it set
  patterns = { ".git", ".hg", "Makefile", "package.json", "venv", "WORKSPACE" },
  -- For whatever reason, texlab has bad root finding behavior
  ignore_lsp = { "texlab" },
}

-- if this works out, move it to a settings or UI.lua file
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  messages = {
    enabled = true, -- enables the Noice messages UI
    view = "mini", -- default view for messages
    view_error = "mini", -- view for errors
    view_warn = "mini", -- view for warnings
    view_history = "messages", -- view for :messages
    view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
  },
  routes = {
    {
      view = "mini",
      filter = {
        event = "msg_showmode"
      },
      any = {
        { find = "recording" },
      },
    },
  },
})
