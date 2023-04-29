vim.cmd([[
function! OpenGitHubUrlForCurrentLine()
  call system("/usr/local/bin/hub browse -- blob/$(git rev-parse HEAD)/" . expand('%') . "/#L" . line('.'))
endfunction

function! CopyGitHubUrlForCurrentLine()
  let l:base = FindGitRootForPath(expand('%:p:h'))

  if l:base == ""
    let l:base = "."
  endif

  let l:current = expand('%:p')
  let l:relative = system("realpath --relative-to=" . l:base . " " . l:current)[:-2]
  " echom l:relative
  let l:base_url = system("gh repo view -b master --json url -q '.url'")[:-2] "Trim odd ^@ symbol from url
  " echom l:base_url

  " Trim newlines from the end of the command
  let l:commit_hash = system('git rev-parse HEAD')[:-2]
  let l:full_url = join([l:base_url, "blob", l:commit_hash, l:relative], '/')
  let l:full_link = l:full_url . "#L" . line('.')
  " echom l:full_link
  let @+ = l:full_link
  " system('echo ' . l:full_link . ' | xclip -selection clipboard')
endfunction

function! CopyGitHubBranchUrlForCurrentLine(branch)
  call CopyGitHubUrlForCurrentLine()
  " 40 is the length of the full git hash
  let @+ = substitute(@+, "[a-z0-9]\\{40\\}", a:branch, "g")
endfunction

function! CopyGitHubCurrentBranchUrlForCurrentLine()
  let l:branch = system("git rev-parse --abbrev-ref HEAD| tr -d \"\n\"")
  echo l:branch
  call CopyGitHubBranchUrlForCurrentLine(l:branch)
endfunction

nnoremap <silent> <Leader>gx :call OpenGitHubUrlForCurrentLine()<CR>
nnoremap <silent> <Leader>ghc :call CopyGitHubUrlForCurrentLine()<CR>
nnoremap <silent> <Leader>ghi :call CopyGitHubBranchUrlForCurrentLine("integration")<CR>
nnoremap <silent> <Leader>ghm :call CopyGitHubBranchUrlForCurrentLine("main")<CR>
nnoremap <silent> <Leader>ghb :call CopyGitHubCurrentBranchUrlForCurrentLine()<CR>
]])
