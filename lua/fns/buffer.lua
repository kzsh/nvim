vim.cmd([[
"==========================================================
" Buffer functions
"==========================================================
function! GitRootsForAllBuffers()
  return Filtered(function('len'), Mapped(function('FindGitRootForPath'), AllBufferFileNames()))
endfunction

function! AllBufferFileNames()
  return map(filter(range(0,bufnr('$')), 'buflisted(v:val)'), "fnamemodify(bufname(v:val), ':p')")
endfunction
]])
