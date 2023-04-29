vim.cmd([[
"==========================================================
" Add shortcut to edit init.vim/vimrc
"==========================================================
command! INIT tabedit $MYVIMRC


"==========================================================
" vim-cd to top-level of git repo
"==========================================================
function! Cdg()
  let l:root = FindGitRoot()
  cd `=l:root`
endfunction

command! Cdg :call Cdg()
cnoreabbrev <expr> cdg ((getcmdtype() is# ':' && getcmdline() is# 'cdg')?('Cdg'):('cdg'))

"==========================================================
" Remove trailing whitespaces
"==========================================================
let g:skip_whitespace = ['markdown']

function! StripTrailingWhitespaces()
  if index(g:skip_whitespace, &ft) < 0
    let l:l = line('.')
    let l:c = col('.')
    %s/\s\+$//e
    call cursor(l:l, l:c)
  endif

endfunction

"when saving, remove all trailing spaces from the file.
augroup StripWhitespaceOnSave
  autocmd FileType * autocmd BufWritePre <buffer> :call StripTrailingWhitespaces()
augroup END

"==========================================================
" Remove consecutive empty lines
"==========================================================
function! RemoveExtraEmptyLines()
  :%g/^$\n\n/d
endfunction

"==========================================================
" Copy search matches to register e.g. :CopyMatches a
"==========================================================
function! CopyMatches(reg)
  let l:hits = []
  let l:reg = ""
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let l:reg = empty(l:reg) ? '+' : l:reg
  execute 'let @' . l:reg . ' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END


]])
