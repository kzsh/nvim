local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local function query_dir()
  return vim.g.kzsh.query_result_dir
end

-- Rust Execute visual-selection

local function rust_execute()
  local stem = vim.fn.expand("%:t:r")
  local in_file = query_dir() .. "/rust/in/" .. stem .. ".rs"
  local executable = query_dir() .. "/rust/in/" .. stem
  local out_file = query_dir() .. "/rust/out/" .. stem .. ".log"

  vim.cmd("%w! " .. in_file .. " | !rustc " .. in_file .. " -o " .. executable)
  vim.cmd("!" .. executable .. " > " .. out_file)
end

local function rust_view_execution()
  local out_file = query_dir() .. "/rust/out/" .. vim.fn.expand("%:t:r") .. ".log"
  vim.cmd("silent! vsplit " .. out_file)
end

-- Mongo Execute visual-selection

local function mongodb_query()
  local stem = vim.fn.expand("%:t:r")
  local in_file = query_dir() .. "/mongodb/in/" .. stem .. ".js"
  local out_file = query_dir() .. "/mongodb/out/" .. stem

  vim.cmd('%w! ' .. in_file .. ' | !cat ' .. in_file .. ' | mongosh --norc --quiet | sed "s/^rs.*>//g;/^ *$/d" > ' .. out_file)
end

local function mongodb_view_query()
  local out_file = query_dir() .. "/mongodb/out/" .. vim.fn.expand("%:t:r")
  vim.cmd("silent! vsplit " .. out_file)
end

-- Neo4j Execute visual-selection

vim.g.Neo4jQuery_database = "some_db"

local function neo4j_query(mode)
  local stem = vim.fn.expand("%:t:r")
  local out_file = query_dir() .. "/cypher/out/" .. stem .. ".cypher"
  local in_file = query_dir() .. "/cypher/in/" .. stem .. ".cypher"
  local db = vim.g.Neo4jQuery_database
  local cypher_cmd = "cypher-shell --database " .. db .. " --user neo4j --password changeme --non-interactive --format plain --file " .. in_file .. " > " .. out_file

  if mode == 2 then
    vim.cmd("%w! " .. in_file .. " | !" .. cypher_cmd)
  elseif mode == 1 then
    local visual = vim.fn.GetVisualSelection()
    vim.fn.writefile(visual, in_file, "b")
    print(in_file)
    vim.cmd("!cat " .. in_file .. " | " .. cypher_cmd)
  elseif mode == 0 then
    vim.fn.writefile(vim.split(vim.fn.getline("."), "\n"), in_file, "b")
    print(vim.split(vim.fn.getline("."), "\n"))
    vim.cmd("!cat " .. in_file .. " | " .. cypher_cmd)
  else
    print("no valid approach selected")
  end
end

local function neo4j_view_query()
  local out_file = query_dir() .. "/cypher/out/" .. vim.fn.expand("%:t:r") .. ".cypher"
  vim.cmd("silent! vsplit " .. out_file)
end

-- PostgreSQL Execute visual-selection

vim.g.PostgreSQLQuery_database = "db-name"

local function postgresql_query(mode)
  local stem = vim.fn.expand("%:t:r")
  local out_file = query_dir() .. "/psql/out/" .. stem .. ".sql"
  local in_file = query_dir() .. "/psql/in/" .. stem .. ".sql"
  local db = vim.g.PostgreSQLQuery_database
  local psql_cmd = "PGPASSWORD=postgres psql --host localhost --port 5432 --username=postgres --dbname=" .. db

  if mode == 2 then
    vim.cmd("%w! " .. in_file .. " | ! " .. psql_cmd .. " --file " .. in_file .. " > " .. out_file)
  elseif mode == 1 then
    local visual = vim.fn.GetVisualSelection()
    vim.fn.writefile(visual, in_file, "b")
    print(in_file)
    vim.cmd("!cat " .. in_file .. " | " .. psql_cmd .. " > " .. out_file)
  elseif mode == 0 then
    vim.fn.writefile(vim.split(vim.fn.getline("."), "\n"), in_file, "b")
    print(vim.split(vim.fn.getline("."), "\n"))
    vim.cmd("!cat " .. in_file .. " | " .. psql_cmd .. " > " .. out_file)
  else
    print("no valid approach selected")
  end
end

local function postgresql_view_query()
  local out_file = query_dir() .. "/psql/out/" .. vim.fn.expand("%:t:r") .. ".sql"
  vim.cmd("silent! vsplit " .. out_file)
end

-- Node.js Execute visual-selection

local function node_repl(mode)
  local stem = vim.fn.expand("%:t:r")
  local out_file = query_dir() .. "/nodejs/out/" .. stem .. ".txt"
  local in_file = query_dir() .. "/nodejs/in/" .. stem .. ".js"

  if mode == 2 then
    vim.cmd("%w! " .. in_file .. " | !node " .. in_file .. " > " .. out_file)
  elseif mode == 1 then
    local visual = vim.fn.GetVisualSelection()
    vim.fn.writefile(visual, in_file, "b")
    -- print(in_file)
    vim.cmd("%w! " .. in_file .. " | !node " .. in_file .. " > " .. out_file)
  elseif mode == 0 then
    vim.fn.writefile(vim.split(vim.fn.getline("."), "\n"), in_file, "b")
    -- print(vim.split(vim.fn.getline("."), "\n"))
    vim.cmd("%w! " .. in_file .. " | !node " .. in_file .. " > " .. out_file)
  else
    print("no valid approach selected")
  end
end

local function node_repl_view_query()
  local out_file = query_dir() .. "/nodejs/out/" .. vim.fn.expand("%:t:r") .. ".txt"
  vim.cmd("silent! vsplit " .. out_file)
end

-- Filetype-specific REPL keymaps

local exec_group = augroup("ExecuteSelectedTextByFileType", { clear = true })

local function ft_map(filetype, mode, lhs, rhs, opts)
  autocmd("FileType", {
    group = exec_group,
    pattern = filetype,
    callback = function(ev)
      opts = vim.tbl_extend("force", { buffer = ev.buf }, opts or {})
      map(mode, lhs, rhs, opts)
    end,
  })
end

ft_map("ruby", "v", "<Leader>rr", ":!cat | awk '{ print \"puts \"$0 }' | ruby<CR>")
ft_map("javascript", "v", "<Leader>rr", ":!cat | awk '{ print \"process.stdout.write(String(\"$0\"))\" }' | node<CR>")
ft_map("typescript", "v", "<Leader>rr", ":!cat | awk '{ print \"process.stdout.write(String(\"$0\"))\" }' | node<CR>")
ft_map("python", "v", "<Leader>rr", ":ReplSend<CR>")
ft_map("python", "n", "<Leader>ro", ":ReplAuto<CR>")
ft_map("python", "n", "<Leader>ra", ":0,$ReplSend<CR>")

ft_map("mongodb.*", "n", "<Leader>ro", mongodb_view_query)
ft_map("mongodb.*", "n", "<Leader>rr", mongodb_query)

ft_map("rust", "n", "<Leader>ro", rust_view_execution)
ft_map("rust", "n", "<Leader>rr", rust_execute)
ft_map("rust", "v", "<Leader>ro", rust_view_execution)
ft_map("rust", "v", "<Leader>rr", rust_execute)

ft_map("cypher", "n", "<Leader>ro", neo4j_view_query)
ft_map("cypher", "n", "<Leader>rr", function() neo4j_query(0) end)
ft_map("cypher", "v", "<Leader>rr", function() neo4j_query(1) end)
ft_map("cypher", "n", "<Leader>ra", function() neo4j_query(2) end)

ft_map("sql", "n", "<Leader>ro", postgresql_view_query)
ft_map("sql", "n", "<Leader>rr", function() postgresql_query(0) end)
ft_map("sql", "v", "<Leader>rr", function() postgresql_query(1) end)
ft_map("sql", "n", "<Leader>ra", function() postgresql_query(2) end)

ft_map("javascript", "n", "<Leader>ro", node_repl_view_query)
ft_map("javascript", "n", "<Leader>rr", function() node_repl(0) end)
ft_map("javascript", "v", "<Leader>rr", function() node_repl(1) end)
ft_map("javascript", "n", "<Leader>ra", function() node_repl(2) end)
