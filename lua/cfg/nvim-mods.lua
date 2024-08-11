vim.cmd([[
"=========================================================m
" Use buffer ex view by default
"==========================================================
nnoremap : q:i
nnoremap <Leader>: :

inoremap <C-r><C-g> <Esc>:echo bufname(bufnr(''))<CR>i
]])
