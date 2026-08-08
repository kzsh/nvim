return {
  'tpope/vim-fugitive',
  event = 'BufRead',
  config = function()
    vim.cmd([[
    "==========================================================
    " Fugitive
    "==========================================================
    vnoremap <Leader>ll :'<,'>0Gclog<CR>
    nnoremap <Leader>ll :silent! call ToggleFugitive()<CR>

    " nnoremap <Leader>gs :Gstatus<CR>
    " nnoremap <Leader>df

    " command! -range FugitiveRange <line1>,<line2>call ToggleFugitive()

    function! ToggleFugitive()
      if expand('%') =~# 'fugitive'
        execute('Gedit')
      else
        execute(line('.') . 'Gclog')
      end
    endfunction
  ]])
  end
}
