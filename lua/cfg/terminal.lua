local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup("Terminal", { clear = true })

-- Start terminal in insert mode
autocmd("TermOpen", {
  group = augroup,
  pattern = "*",
  command = "startinsert",
})

autocmd("TermLeave", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.opt_local.number = true
  end,
})

autocmd("TermEnter", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
  end,
})

vim.g.terminal_scrollback_buffer_size = 100000
