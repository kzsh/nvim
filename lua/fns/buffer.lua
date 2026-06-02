-- Buffer functions

local function all_buffer_file_names()
  local names = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.fn.buflisted(buf) == 1 then
      names[#names + 1] = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p")
    end
  end
  return names
end

local function git_roots_for_all_buffers()
  local utils = require("utils")
  local roots = {}
  for _, name in ipairs(all_buffer_file_names()) do
    local root = utils.find_git_root_for_path(name)
    if root ~= "" then
      roots[#roots + 1] = root
    end
  end
  return roots
end
