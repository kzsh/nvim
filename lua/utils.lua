vim.cmd([[
"==========================================================
" Git
"==========================================================
function! FindGitRoot()
  return FindGitRootForPath(expand('%'))
endfunction

function! FindGitRootForPath(path)
  let l:git_command = 'git rev-parse --show-toplevel 2> /dev/null'
  let l:path_change = 'cd "$(dirname "' . expand(a:path) . '")"'
  return expand(system(l:path_change . ' && ' . l:git_command)[:-2])
endfunction

"==========================================================
" Utility functions
"==========================================================
function! Mapped(fn, l)
  return OperateOnEnumerable(a:fn, a:l, 'map')
endfunction

function! Filtered(fn, l)
  return OperateOnEnumerable(a:fn, a:l, 'filter')
endfunction

function! OperateOnEnumerable(fn, list, operation)
  let l:new_list = deepcopy(a:list)
  execute('call ' . a:operation . "(l:new_list,  string(a:fn) . '(v:val)')")

  return l:new_list
endfunction

"==========================================================
" visual selection utils
"==========================================================

function! VisualSelection()
  if mode() ==? 'v'
    let [l:line_start, l:column_start] = getpos('v')[1:2]
    let [l:line_end, l:column_end] = getpos('.')[1:2]
  else
    let [l:line_start, l:column_start] = getpos("'<")[1:2]
    let [l:line_end, l:column_end] = getpos("'>")[1:2]
  end
  if (line2byte(l:line_start) + l:column_start) > (line2byte(l:line_end) + l:column_end)
    let [l:line_start, l:column_start, l:line_end, l:column_end] =
          \   [l:line_end, l:column_end, l:line_start, l:column_start]
  end
  let l:lines = getline(l:line_start, l:line_end)
  if len(l:lines) == 0
    return ''
  endif
  let l:lines[-1] = l:lines[-1][: l:column_end - 1]
  let l:lines[0] = l:lines[0][l:column_start - 1:]
  return join(l:lines, "\n")
endfunction

function! GetVisualSelection(separator = "\n")
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return lines
endfunction

]])
