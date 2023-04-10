require("tokyonight").setup({
  style = "night",
  dim_inactive = false,

  on_colors = function(colors)
    colors.bg = "#101010"
    colors.bg_dark = "#101010"
  end
})

vim.cmd[[colorscheme tokyonight-night]]
vim.opt.background = "dark"
vim.opt.cursorline = true      -- highlight current line
vim.opt.hlsearch = false       -- don't highlight searches after done
