vim.cmd([[
"==========================================================
" Tig
"==========================================================
nnoremap <Leader>tig :tabe \| execute('term tig') \| startinsert!<CR>
" nnoremap <Leader>tif :tabe \| execute('term cd ' . FindGitRootForPath(expand('%')) . ' && tig -- ' . expand('%')) \| startinsert!<CR>
"
nnoremap <Leader>tif :silent! call OpenFileHistoryInTig()<CR>

function! OpenFileHistoryInTig()
  let filename = expand('%')
  tabe
  execute('term cd ' . FindGitRootForPath(l:filename) . ' && /usr/local/bin/tig -- ' . l:filename)
  startinsert!
endfunction
]])
