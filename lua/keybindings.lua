vim.cmd([[
"==========================================================
" Return to previous buffer with Tab
"==========================================================
nnoremap <special> <Tab> <C-^>

"==========================================================
" Swap backtic and single quote
"==========================================================
nnoremap ' `
nnoremap ` '

"==========================================================
" Resize panes with arrow keys and shift
"==========================================================
nnoremap <Left> :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>

nnoremap <S-Left> :vertical resize -10<CR>
nnoremap <S-Right> :vertical resize +10<CR>
nnoremap <S-Up> :resize -10<CR>
nnoremap <S-Down> :resize +10<CR>

"==========================================================
" Alternate escape sequences terminal emulator (terminal-emulator-input)
"==========================================================
" tnoremap <Esc><Esc> <C-\><C-n>
" tnoremap <C-c> <C-\><C-n>
tnoremap ก <C-\><C-n>
" tnoremap <Leader>x :close< CR>

"==========================================================
" Make escape fancy ( :/ )
"==========================================================
nnoremap <C-\><C-n> <Esc>
nnoremap <silent><Esc> :call ConditionalEscape()<CR>

let g:kzsh#term_prime_delete = 0

function! ConditionalCtrlC()
  if bufname('%') =~# '^term:\/\/'
    normal! <C-\><C-n>
  endif
endfunction

function! ConditionalEscape()
  if bufname('%') ==? '[Command Line]'
    if mode()==? 'n'
      close
    endif
  " elseif bufname('%') =~# '^term:\/\/'
  "   try
  "     close
  "   catch /.*/
  "     if g:kzsh#term_prime_delete == 1
  "       let g:kzsh#term_prime_delete = 0
  "       bd!
  "     else
  "       let g:kzsh#term_prime_delete = 1
  "     endif
  "   endtry
  else
    normal! <C-\><C-n>
  endif
endfunction

"==========================================================
" Open quickfix window
"==========================================================
nnoremap <Leader>fq :copen \| silent grep!<Space>

"==========================================================
" Restart LSP
"==========================================================
nnoremap <Leader><Leader>r :LspRestart<CR>
]])
