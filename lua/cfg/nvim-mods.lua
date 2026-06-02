local map = vim.keymap.set

-- Use buffer ex view by default
map("n", ":", "q:i")
map("n", "<Leader>:", ":")
map("i", "<C-r><C-g>", "<Esc>:echo bufname(bufnr(''))<CR>i")
