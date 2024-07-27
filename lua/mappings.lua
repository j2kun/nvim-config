-- Jump to vim config
vim.keymap.set('n', '<leader>ve', ':vsp $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>vs', ':source $MYVIMRC<CR>')

-- faster ESC from insert mode
vim.keymap.set('i', 'jk', '<ESC>')

-- move vertically by visual line
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Align/wrap current paragraph
vim.keymap.set('n', '<leader>gq', 'vipgq')

-- Sort and dedupe current paragraph by line
vim.keymap.set('n', '<leader>s', 'vip:sort u<CR>')

-- from johmsalas/text-case.nvim
vim.keymap.set('n', '<leader>cC', ":lua require('textcase').current_word('to_pascal_case')<CR>")
vim.keymap.set('n', '<leader>ca', ":lua require('textcase').current_word('to_camel_case')<CR>")
vim.keymap.set('n', '<leader>c-', ":lua require('textcase').current_word('to_dash_case')<CR>")
vim.keymap.set('n', '<leader>c.', ":lua require('textcase').current_word('to_dot_case')<CR>")
vim.keymap.set('n', '<leader>c/', ":lua require('textcase').current_word('to_path_case')<CR>")
vim.keymap.set('n', '<leader>c_', ":lua require('textcase').current_word('to_snake_case')<CR>")
vim.keymap.set('n', '<leader>ct', ":lua require('textcase').current_word('to_title_case')<CR>")
vim.keymap.set('n', '<leader>cu', ":lua require('textcase').current_word('to_constant_case')<CR>")
vim.keymap.set('v', '<leader>cC', ":lua require('textcase').visual('to_pascal_case')<CR>")
vim.keymap.set('v', '<leader>ca', ":lua require('textcase').visual('to_camel_case')<CR>")
vim.keymap.set('v', '<leader>c-', ":lua require('textcase').visual('to_dash_case')<CR>")
vim.keymap.set('v', '<leader>c.', ":lua require('textcase').visual('to_dot_case')<CR>")
vim.keymap.set('v', '<leader>c/', ":lua require('textcase').visual('to_path_case')<CR>")
vim.keymap.set('v', '<leader>c_', ":lua require('textcase').visual('to_snake_case')<CR>")
vim.keymap.set('v', '<leader>ct', ":lua require('textcase').visual('to_title_case')<CR>")
vim.keymap.set('v', '<leader>cu', ":lua require('textcase').visual('to_constant_case')<CR>")

-- Open any file in the same directory in a vsplit,
-- but where you can type and auto-complete the filename
-- also works for creating new files, whereas the corresponding
-- telescope command would not :(
vim.keymap.set('n', '<leader>ev', ':vsplit <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set('n', '<leader>es', ':split <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set('n', '<leader>ee', ':edit <C-R>=expand("%:p:h") . "/" <CR>')

-- Toggle code outline
vim.keymap.set('n', '<leader>o', ':SymbolsOutline<CR>')


-- navigate to bazel build target for current file
vim.keymap.set('n', '<leader>eb', function()
  -- expand("%:p:h") gets the current filepath
  local buildfile = vim.fn.expand("%:p:h") .. "/BUILD"
  -- expand("%:t") gets the current filename with suffix.
  local target = vim.fn.expand("%:t")
  vim.api.nvim_command("botright vsplit " .. buildfile)
  vim.cmd("normal /" .. target .. vim.api.nvim_replace_termcodes("<CR>", true, true, true))
  vim.cmd("normal zz")
end,
  { noremap = true })


local function build_include_guard()
  -- project relative filepath
  local abs_path = vim.fn.expand("%")
  local rel_path = vim.fn.fnamemodify(abs_path, ":~:.")

  -- screaming case
  local upper = string.upper(rel_path)
  -- underscore separated
  local underscored = string.gsub(upper, "[./]", "_")
  -- trailing underscore
  return underscored .. "_"
end


-- Fix include guards according to HEIR style guide
vim.keymap.set('n', '<leader>fi', function()
  local buf = vim.api.nvim_get_current_buf()
  local include_guard = build_include_guard()
  local ifndef = "#ifndef " .. include_guard
  local define = "#define " .. include_guard
  local endif = "#endif  // " .. include_guard

  vim.api.nvim_buf_set_lines(buf, 0, 2, false, { ifndef, define })
  vim.api.nvim_buf_set_lines(buf, -2, -1, false, { endif })
end, { noremap = true })


-- insert the iso date, 2023-07-18T10:36:11-07:00
-- :r !date --iso-8601=seconds , but smaerter
vim.keymap.set('i', '<c-t>', function()
  -- expand("%:p:h") gets the current filepath
  local datetime = os.date("%Y-%m-%dT%H:%M:%S%z")
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { datetime })
end,
  { noremap = true })


-- From https://buttondown.email/hillelwayne/archive/keep-perfecting-your-config/
-- use `vim.b.local_task` to store a task to run in the current buffer
-- Run `:LoadLocal foo` to set the task to `foo`, then `gxl` to run it
function LoadLocal(local_task)
  vim.b.local_task = local_task
end

function RunLocalHelper()
  local filepath = vim.api.nvim_buf_get_name(0)
  local cmd = vim.b.local_task .. " " .. filepath
  local handle = io.popen(cmd, "r")
  -- Read the output of the command into a string
  if handle == nil then
    print("Error running local task")
    return nil
  end
  local result = handle:read("*a")
  handle:close()
  return result
end

function RunLocal()
  local result = RunLocalHelper()
  if result == nil then
    return nil
  end
  print(result)  -- prints to messages
end

function RunAndReplaceLocal()
  local result = RunLocalHelper()
  if result == nil then
    return nil
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { result })
end

function RunAndNewTabLocal()
  local result = RunLocalHelper()
  if result == nil then
    return nil
  end
  vim.cmd [[tabnew]]
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { result })
end

vim.cmd [[command! -nargs=1 LoadLocal call v:lua.LoadLocal(<f-args>)]]
vim.keymap.set('n', '<leader>xr', RunLocal, {desc="Run vim.b.local_task"})
vim.keymap.set('n', '<leader>xe', RunAndReplaceLocal, {desc="Run vim.b.local_task and replace current buffer contents with result"})
vim.keymap.set('n', '<leader>xt', RunAndNewTabLocal, {desc="Run vim.b.local_task and create a new tab with results"})
