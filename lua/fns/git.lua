vim.cmd([[
function! DiffUpstreamForChangedFiles(upstream)
  let l:git_command = 'git diff --name-only' . a:upstream
  return expand(system(l:git_command))
endfunction
]])
