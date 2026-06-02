local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local user_command = vim.api.nvim_create_user_command

vim.api.nvim_create_user_command('AiChat', function()
  local mode = vim.fn.mode()
  if mode == 'v' or mode == 'V' then
    local temp_file = vim.fn.tempname()
    local temp_err_file = vim.fn.tempname()
    local command = string.format("'<,'>!aichat > %s 2> %s", vim.fn.shellescape(temp_file), vim.fn.shellescape(temp_err_file))

    -- Execute the command and replace the selection with the output
    vim.cmd(command)

    -- Check and display any error messages captured in the temp file
    if vim.fn.filereadable(temp_file) and vim.fn.getfsize(temp_file) > 0 then
      vim.cmd('botright new')
      vim.cmd('read ' .. temp_file)
      vim.cmd('file AiChat Errors')
      vim.cmd('setlocal buftype=nofile')
    end
  end
end, { range = true })

-- Add shortcut to edit init.vim/vimrc
user_command("INIT", "tabedit $MYVIMRC", {})

user_command("Chat", "call aichat", { register = true })

-- vim-cd to top-level of git repo
local function cdg()
  local root = vim.fn.FindGitRoot()
  vim.cmd("cd " .. root)
end

user_command("Cdg", cdg, {})
vim.cmd([[cnoreabbrev <expr> cdg ((getcmdtype() is# ':' && getcmdline() is# 'cdg')?('Cdg'):('cdg'))]])

-- Remove trailing whitespaces
vim.g.skip_whitespace = { "markdown" }

local function strip_trailing_whitespaces()
  if not vim.tbl_contains(vim.g.skip_whitespace, vim.bo.filetype) then
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end
end

-- when saving, remove all trailing spaces from the file.
local strip_group = augroup("StripWhitespaceOnSave", { clear = true })
autocmd("FileType", {
  group = strip_group,
  pattern = "*",
  callback = function(ev)
    autocmd("BufWritePre", {
      group = strip_group,
      buffer = ev.buf,
      callback = strip_trailing_whitespaces,
    })
  end,
})

-- Remove consecutive empty lines
local function remove_extra_empty_lines()
  vim.cmd([[%g/^$\n\n/d]])
end

user_command("RemoveExtraEmptyLines", remove_extra_empty_lines, {})

-- Copy search matches to register e.g. :CopyMatches a
local function copy_matches(opts)
  local hits = {}
  vim.cmd([[%s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne]])
  local reg = opts.reg ~= "" and opts.reg or "+"
  vim.fn.setreg(reg, table.concat(hits, "\n") .. "\n")
end

user_command("CopyMatches", copy_matches, { register = true })

-- Auto-create directories on save
local mkdir_group = augroup("BWCCreateDir", { clear = true })
autocmd("BufWritePre", {
  group = mkdir_group,
  pattern = "*",
  callback = function(ev)
    local file = ev.match
    local buf = ev.buf
    if vim.bo[buf].buftype == "" and not file:match("^%w+://") then
      local dir = vim.fn.fnamemodify(file, ":h")
      if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
      end
    end
  end,
})
