local map = vim.keymap.set

local function open_github_url_for_current_line()
  vim.fn.system(
    "/usr/local/bin/hub browse -- blob/$(git rev-parse HEAD)/" .. vim.fn.expand("%") .. "/#L" .. vim.fn.line(".")
  )
end

local function copy_github_url_for_current_line()
  local base = require("utils").find_git_root_for_path(vim.fn.expand("%:p:h"))

  if base == "" then
    base = "."
  end

  local current = vim.fn.expand("%:p")
  local relative = vim.fn.system("realpath --relative-to=" .. base .. " " .. current):gsub("\n$", "")
  local base_url = vim.fn.system("gh repo view -b master --json url -q '.url'"):gsub("\n$", "")

  -- Trim newlines from the end of the command
  local commit_hash = vim.fn.system("git rev-parse HEAD"):gsub("\n$", "")
  local full_url = table.concat({ base_url, "blob", commit_hash, relative }, "/")
  local full_link = full_url .. "#L" .. vim.fn.line(".")
  vim.fn.setreg("+", full_link)
end

local function copy_github_branch_url_for_current_line(branch)
  copy_github_url_for_current_line()
  -- 40 is the length of the full git hash
  local current = vim.fn.getreg("+")
  vim.fn.setreg("+", current:gsub("%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x", branch))
end

local function copy_github_current_branch_url_for_current_line()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n$", "")
  print(branch)
  copy_github_branch_url_for_current_line(branch)
end

map("n", "<Leader>gx", open_github_url_for_current_line, { silent = true })
map("n", "<Leader>ghc", copy_github_url_for_current_line, { silent = true })
map("n", "<Leader>ghi", function() copy_github_branch_url_for_current_line("integration") end, { silent = true })
map("n", "<Leader>ghm", function() copy_github_branch_url_for_current_line("main") end, { silent = true })
map("n", "<Leader>ghb", copy_github_current_branch_url_for_current_line, { silent = true })
