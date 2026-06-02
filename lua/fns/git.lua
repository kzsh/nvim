local function diff_upstream_for_changed_files(upstream)
  local result = vim.fn.system("git diff --name-only" .. upstream)
  return vim.fn.expand(result)
end
