vim.cmd([[
"==========================================================
" Rust Execute visual-selection
"==========================================================

function! RustExecute()
  let l:in_file_path = g:kzsh#query_result_dir . '/rust/in/' . expand('%:t:r') . '.rs'
  let l:in_file_executable = g:kzsh#query_result_dir . '/rust/in/' . expand('%:t:r')
  let l:out_file_path = g:kzsh#query_result_dir . '/rust/out/' . expand('%:t:r') . '.log'

  execute('%w! ' . l:in_file_path . ' | !rustc ' . l:in_file_path . ' -o ' . l:in_file_executable)
  execute('!' . l:in_file_executable . ' > ' . l:out_file_path)
endfunction

function! RustViewExecution()
  let l:out_file_path = g:kzsh#query_result_dir . '/rust/out/' . expand('%:t:r') . '.log'
  execute('silent! vsplit ' . l:out_file_path)
endfunction

command! RustExecute call s:RustExecute()
command! RustViewExecution call s:RustViewExecution()

"==========================================================
" Mongo Execute visual-selection
"==========================================================

function! MongodbQuery()
  let l:in_file_path = g:kzsh#query_result_dir . '/mongodb/in/' . expand('%:t:r') . '.js'
  let l:out_file_path = g:kzsh#query_result_dir . '/mongodb/out/' . expand('%:t:r')

  execute('%w! ' . l:in_file_path . ' | !cat ' . l:in_file_path . ' | mongosh --norc --quiet | sed "s/^rs.*>//g;/^ *$/d" > ' . l:out_file_path)
endfunction

function! MongodbViewQuery()
  let l:out_file_path = g:kzsh#query_result_dir . '/mongodb/out/' . expand('%:t:r')
  execute('silent! vsplit ' . l:out_file_path)
endfunction

command! MongodbQuery call s:MongodbQuery()
command! MongodbViewQuery call s:MongodbViewQuery()

"==========================================================
" Neo4j Execute visual-selection
"==========================================================
function! Neo4jQuery(is_inline)
  if(a:is_inline != 0)
    let l:out_file_path = g:kzsh#query_result_dir . '/cypher/out/' . expand('%:t:r')
    execute('!~/bin/neo "' . GetVisualSelection("a") . '" | jq > ' . l:out_file_path)
  else
    let l:in_file_path = g:kzsh#query_result_dir . '/cypher/in/' . expand('%:t:r') . '.cypher'
    let l:out_file_path = g:kzsh#query_result_dir . '/cypher/out/' . expand('%:t:r')
    " execute('%w! ' . l:in_file_path . ' | !~/bin/neo -f ' . l:in_file_path . ' | jq -r > ' . l:out_file_path)
    execute('%w! ' . l:in_file_path . ' | !cypher-shell --database [some-deb-here] --user neo4j --password changeme --non-interactive --file ' . l:in_file_path . ' > ' . l:out_file_path)
  endif
endfunction

function! Neo4jViewQuery()
  let l:out_file_path = g:kzsh#query_result_dir . '/cypher/out/' . expand('%:t:r')
  execute('silent! vsplit ' . l:out_file_path)
endfunction

command! Neo4jdbQuery call s:Neo4jQuery()
command! Neo4jdbViewQuery call s:Neo4jViewQuery()


augroup ExecuteSelectedTextByFileType
  autocmd FileType ruby       vnoremap <buffer> <Leader>rr :!cat \| awk '{ print "puts "$0 }' \| ruby<CR>
  autocmd FileType javascript vnoremap <buffer> <Leader>rr :!cat \| awk '{ print "process.stdout.write(String("$0"))" }' \| node<CR>
  autocmd FileType typescript vnoremap <buffer> <Leader>rr :!cat \| awk '{ print "process.stdout.write(String("$0"))" }' \| node<CR>
  autocmd FileType python     vnoremap <buffer> <Leader>rr :ReplSend<CR>
  autocmd FileType python     nnoremap <buffer> <Leader>ro :ReplAuto<CR>
  autocmd FileType python     nnoremap <buffer> <Leader>ra :0,$ReplSend<CR>

  autocmd FileType mongodb.* nnoremap <buffer> <Leader>ro :call MongodbViewQuery()<CR>
  autocmd FileType mongodb.* nnoremap <buffer> <Leader>rr :call MongodbQuery()<CR>

  autocmd FileType rust nnoremap <buffer> <Leader>ro :call RustViewExecution()<CR>
  autocmd FileType rust nnoremap <buffer> <Leader>rr :call RustExecute()<CR>

  autocmd FileType rust vnoremap <buffer> <Leader>ro :call RustViewExecution()<CR>
  autocmd FileType rust vnoremap <buffer> <Leader>rr :call RustExecute()<CR>

  autocmd FileType cypher nnoremap <buffer> <Leader>ro :call Neo4jViewQuery()<CR>
  autocmd FileType cypher nnoremap <buffer> <Leader>rr :call Neo4jQuery(0)<CR>
  autocmd FileType cypher vnoremap <buffer> <Leader>rr :call Neo4jQuery(1)<CR>

augroup END
]])
