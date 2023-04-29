vim.cmd([[
"==========================================================
" Function to replace right and left quotes with un-justified quotes
"==========================================================
function! FixQuotes()
  %s/[“”]/"/g
  %s/[‘’]/'/g
endfunction
]])
