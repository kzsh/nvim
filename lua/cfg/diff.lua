local map = vim.keymap.set

local function toggle_vim_diff()
  if vim.o.diff then
    vim.cmd("diffoff")
  else
    vim.cmd("diffthis")
  end
end

map("", "<Leader>gg", ":diffget<CR>")
map("", "<Leader>gp", ":diffput<CR>")
map("n", "<Leader>;d", toggle_vim_diff)
