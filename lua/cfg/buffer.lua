local map = vim.keymap.set

map("n", "<Leader>bd", ":bd<CR>")
map("n", "<Leader>e", ":execute('e ' . expand('%'))<CR>")
