vim.cmd([[
"==========================================================
" Start terminal in insert mode
"==========================================================
autocmd TermOpen * startinsert
autocmd TermLeave * setlocal number
autocmd TermEnter * setlocal nonumber

let g:terminal_scrollback_buffer_size = 100000
]])
