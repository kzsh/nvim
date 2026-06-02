-- Tig

local map = vim.keymap.set

local function open_file_history_in_tig()
  local filename = vim.fn.expand("%")
  local git_root = vim.fn.FindGitRootForPath(filename)
  vim.cmd("tabe")
  vim.fn.termopen("cd " .. git_root .. " && /usr/local/bin/tig -- " .. filename)
  vim.cmd("startinsert!")
end

map("n", "<Leader>tig", ":tabe | execute('term tig') | startinsert!<CR>")
map("n", "<Leader>tif", open_file_history_in_tig, { silent = true })
