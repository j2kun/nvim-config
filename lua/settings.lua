-- required to allow nvim to work with python3 inside a virtualenv
-- Should be set before plugins are loaded
vim.g.python3_host_prog = "$HOME" .. "/.config/nvim/venv/bin/python3"

vim.g.mapleader = ","

-- Tabs = 2 spaces
vim.opt.expandtab = true -- tabs are spaces
vim.opt.shiftwidth = 2   -- number of visual spaces per shift
vim.opt.softtabstop = 2  -- number of spaces in tab when editing
vim.opt.tabstop = 2      -- number of visual spaces per TAB

-- Misc UI config
vim.opt.clipboard = "unnamed"  -- use system clipboard
vim.opt.number = true          -- enable line numbers in the left margin
vim.opt.relativenumber = true  -- enable relative line numbers in the left margin
vim.opt.splitright = true      -- vsplits open on the right by default

--- Backup preferences
vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand("~/.cache/nvim/backup")
vim.opt.backupskip = vim.fn.expand("~/.cache/*")
vim.opt.directory = vim.fn.expand("~/.cache/nvim/swap")
vim.opt.undodir = vim.fn.expand("~/.cache/nvim/undo")
vim.opt.undofile = true -- Maintain undo history between sessions
vim.opt.writebackup = true

--- Session management
vim.g.session_autosave = 'yes'
vim.g.session_autoload = 'yes'
-- save session silently every minute
vim.g.session_autosave_periodic = 1
vim.g.session_default_to_last = true

-- Spell checker defaults across all filetypes
vim.opt.spelllang = 'en_us'

-- Ensure latex uses ftplugin/tex.vim for all .tex files
vim.g.tex_flavor = 'latex'
