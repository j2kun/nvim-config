local M = {}

--- Check if the current working directory (or given path) contains "google3".
--- @param path string|nil Optional path to check; defaults to vim.fn.getcwd()
--- @return boolean
function M.in_google3(path)
  local dir = path or vim.fn.getcwd()
  return string.find(dir, "google3", 1, true) ~= nil
end

M.is_google3 = M.in_google3

return M
