local M = {}

-- Git

function M.find_git_root()
  return M.find_git_root_for_path(vim.fn.expand("%"))
end

function M.find_git_root_for_path(path)
  local dir = vim.fn.fnamemodify(vim.fn.expand(path), ":h")
  local result = vim.fn.system('cd "' .. dir .. '" && git rev-parse --show-toplevel 2>/dev/null')
  return vim.fn.expand(result:gsub("\n$", ""))
end

-- Visual selection utils

-- Why is this not a built-in Vim script function?!
function M.get_visual_selection()
  local line_start, column_start = unpack(vim.fn.getpos("'<"), 2, 3)
  local line_end, column_end = unpack(vim.fn.getpos("'>"), 2, 3)
  local lines = vim.fn.getline(line_start, line_end)
  if #lines == 0 then
    return lines
  end
  local inclusive = vim.o.selection == "inclusive" and 1 or 2
  lines[#lines] = lines[#lines]:sub(1, column_end - inclusive + 1)
  lines[1] = lines[1]:sub(column_start)
  return lines
end

return M
