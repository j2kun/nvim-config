local api = vim.api

-- Clear empty space at the end of lines
-- Individual files that want to omit this behvaior can re-define and clear the augroup
-- in the corresponding ftplugin/<filetype>.lua
local trimGroup = api.nvim_create_augroup("TrimEndOfLineWhitespace", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
  command = ":%s/\\s\\+$//e",
  group = trimGroup,
})

-- "sticky yank" keep the cursor at the same position after yanking
-- https://nanotipsforvim.prose.sh/sticky-yank
local cursorPreYank
vim.keymap.set({ "n", "x" }, "y", function()
	cursorPreYank = vim.api.nvim_win_get_cursor(0)
	return "y"
end, { expr = true })
vim.keymap.set("n", "Y", function()
	cursorPreYank = vim.api.nvim_win_get_cursor(0)
	return "y$"
end, { expr = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		if vim.v.event.operator == "y" and cursorPreYank then
			vim.api.nvim_win_set_cursor(0, cursorPreYank)
		end
	end,
})
