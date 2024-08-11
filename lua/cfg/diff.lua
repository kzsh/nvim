vim.cmd([[
"==========================================================
" Diff Shortcuts
"==========================================================
" Toggle Vim diff on/off
function! ToggleVimDiff()
  if &diff
    diffoff
  else
    diffthis
  endif
endfunction

noremap <Leader>gg :diffget<CR>
noremap <Leader>gp :diffput<CR>
nmap <Leader>;d :exe ToggleVimDiff()<CR>

]])
