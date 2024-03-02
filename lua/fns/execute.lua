vim.cmd([[
"==========================================================
" Rust Execute visual-selection
"==========================================================

function! RustExecute()
  let l:in_file_path = g:kzsh.query_result_dir . '/rust/in/' . expand('%:t:r') . '.rs'
  let l:in_file_executable = g:kzsh.query_result_dir . '/rust/in/' . expand('%:t:r')
  let l:out_file_path = g:kzsh.query_result_dir . '/rust/out/' . expand('%:t:r') . '.log'

  execute('%w! ' . l:in_file_path . ' | !rustc ' . l:in_file_path . ' -o ' . l:in_file_executable)
  execute('!' . l:in_file_executable . ' > ' . l:out_file_path)
endfunction

function! RustViewExecution()
  let l:out_file_path = g:kzsh.query_result_dir . '/rust/out/' . expand('%:t:r') . '.log'
  execute('silent! vsplit ' . l:out_file_path)
endfunction

command! RustExecute call s:RustExecute()
command! RustViewExecution call s:RustViewExecution()

"==========================================================
" Mongo Execute visual-selection
"==========================================================

function! MongodbQuery()
  let l:in_file_path = g:kzsh.query_result_dir . '/mongodb/in/' . expand('%:t:r') . '.js'
  let l:out_file_path = g:kzsh.query_result_dir . '/mongodb/out/' . expand('%:t:r')

  execute('%w! ' . l:in_file_path . ' | !cat ' . l:in_file_path . ' | mongosh --norc --quiet | sed "s/^rs.*>//g;/^ *$/d" > ' . l:out_file_path)
endfunction

function! MongodbViewQuery()
  let l:out_file_path = g:kzsh.query_result_dir . '/mongodb/out/' . expand('%:t:r')
  execute('silent! vsplit ' . l:out_file_path)
endfunction

command! MongodbQuery call s:MongodbQuery()
command! MongodbViewQuery call s:MongodbViewQuery()

"==========================================================
" Neo4j Execute visual-selection
"==========================================================
let g:Neo4jQuery_database = "some_db"
function! Neo4jQuery(is_inline) range
  let l:out_file_path = g:kzsh.query_result_dir . '/cypher/out/' . expand('%:t:r') . '.cypher'
  let l:in_file_path = g:kzsh.query_result_dir . '/cypher/in/' . expand('%:t:r') . '.cypher'
  if(a:is_inline == 2)
    execute('%w! ' . l:in_file_path . ' | !cypher-shell --database ' . g:Neo4jQuery_database . ' --user neo4j --password changeme --non-interactive --format plain --file ' . l:in_file_path . ' > ' . l:out_file_path)
  elseif(a:is_inline == 1)
    let l:visual = GetVisualSelection()
    call writefile(l:visual, l:in_file_path, 'b')
    echom l:in_file_path
    execute('!cat ' . l:in_file_path . ' | cypher-shell --database ' . g:Neo4jQuery_database . ' --user neo4j --password changeme --non-interactive --format plain --file ' . l:in_file_path . ' > ' . l:out_file_path)
  elseif(a:is_inline == 0)
    call writefile(split(getline('.'), "\n"), l:in_file_path, 'b')
    echom split(getline('.'), "\n")
    " execute('!cat ' . l:in_file_path)
    execute('!cat ' . l:in_file_path . ' | cypher-shell --database ' . g:Neo4jQuery_database . ' --user neo4j --password changeme --non-interactive --format plain --file ' . l:in_file_path . ' > ' . l:out_file_path)
  else
    echom "no valid approach selected"
  endif
endfunction

function! Neo4jViewQuery()
  let l:out_file_path = g:kzsh.query_result_dir . '/cypher/out/' . expand('%:t:r') . '.cypher'
  execute('silent! vsplit ' . l:out_file_path)
endfunction

"==========================================================
" PostgreSQL Execute visual-selection
"==========================================================
let g:PostgreSQLQuery_database = "db-name"
function! PostgreSQLQuery(is_inline) range
  let l:out_file_path = g:kzsh.query_result_dir . '/psql/out/' . expand('%:t:r') . '.sql'
  let l:in_file_path = g:kzsh.query_result_dir . '/psql/in/' . expand('%:t:r') . '.sql'
  if(a:is_inline == 2)
    execute('%w! ' . l:in_file_path . ' | ! PGPASSWORD=postgres psql --host localhost --port 5432 --username=postgres --dbname=' . g:PostgreSQLQuery_database . ' --file ' . l:in_file_path . ' > ' . l:out_file_path)
  elseif(a:is_inline == 1)
    let l:visual = GetVisualSelection()
    call writefile(l:visual, l:in_file_path, 'b')
    echom l:in_file_path
    execute('!cat ' . l:in_file_path . ' | PGPASSWORD=postgres psql --host localhost --port 5432 --username=postgres --dbname=' . g:PostgreSQLQuery_database . ' > ' . l:out_file_path)
  elseif(a:is_inline == 0)
    call writefile(split(getline('.'), "\n"), l:in_file_path, 'b')
    echom split(getline('.'), "\n")
    " execute('!cat ' . l:in_file_path)
    execute('!cat ' . l:in_file_path . ' | PGPASSWORD=postgres psql --host localhost --port 5432 --username=postgres --dbname=' . g:PostgreSQLQuery_database . ' > ' . l:out_file_path)
  else
    echom "no valid approach selected"
  endif
endfunction

function! PostgreSQLViewQuery()
  let l:out_file_path = g:kzsh.query_result_dir . '/psql/out/' . expand('%:t:r') . '.sql'
  execute('silent! vsplit ' . l:out_file_path)
endfunction

"==========================================================
" Node.js Execute visual-selection
"==========================================================
function! NodeRepl(is_inline) range
  let l:out_file_path = g:kzsh.query_result_dir . '/nodejs/out/' . expand('%:t:r') . '.txt'
  let l:in_file_path = g:kzsh.query_result_dir . '/nodejs/in/' . expand('%:t:r') . '.js'
  if(a:is_inline == 2)
    execute('%w! ' . l:in_file_path . ' | !node ' . l:in_file_path . ' > ' . l:out_file_path)
  elseif(a:is_inline == 1)
    let l:visual = GetVisualSelection()
    call writefile(l:visual, l:in_file_path, 'b')
    " echom l:in_file_path
    execute('%w! ' . l:in_file_path . ' | !node ' . l:in_file_path . ' > ' . l:out_file_path)
  elseif(a:is_inline == 0)
    call writefile(split(getline('.'), "\n"), l:in_file_path, 'b')
    " echom split(getline('.'), "\n")
    " execute('!cat ' . l:in_file_path)
    execute('%w! ' . l:in_file_path . ' | !node ' . l:in_file_path . ' > ' . l:out_file_path)
  else
    echom "no valid approach selected"
  endif
endfunction

function! NodeReplViewQuery()
  let l:out_file_path = g:kzsh.query_result_dir . '/nodejs/out/' . expand('%:t:r') . '.txt'
  execute('silent! vsplit ' . l:out_file_path)
endfunction

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
  autocmd FileType cypher nnoremap <buffer> <Leader>ra :call Neo4jQuery(2)<CR>

  autocmd FileType sql nnoremap <buffer> <Leader>ro :call PostgreSQLViewQuery()<CR>
  autocmd FileType sql nnoremap <buffer> <Leader>rr :call PostgreSQLQuery(0)<CR>
  autocmd FileType sql vnoremap <buffer> <Leader>rr :call PostgreSQLQuery(1)<CR>
  autocmd FileType sql nnoremap <buffer> <Leader>ra :call PostgreSQLQuery(2)<CR>

  autocmd FileType javascript nnoremap <buffer> <Leader>ro :call NodeReplViewQuery()<CR>
  autocmd FileType javascript nnoremap <buffer> <Leader>rr :call NodeRepl(0)<CR>
  autocmd FileType javascript vnoremap <buffer> <Leader>rr :call NodeRepl(1)<CR>
  autocmd FileType javascript nnoremap <buffer> <Leader>ra :call NodeRepl(2)<CR>

augroup END
]])
