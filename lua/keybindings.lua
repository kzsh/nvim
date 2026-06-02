local map = vim.keymap.set

-- Return to previous buffer with Tab
map("n", "<Tab>", "<C-^>")

-- Swap backtick and single quote
map("n", "'", "`")
map("n", "`", "'")

-- Resize panes with arrow keys and shift
map("n", "<Left>", ":vertical resize -1<CR>")
map("n", "<Right>", ":vertical resize +1<CR>")
map("n", "<Up>", ":resize -1<CR>")
map("n", "<Down>", ":resize +1<CR>")

map("n", "<S-Left>", ":vertical resize -10<CR>")
map("n", "<S-Right>", ":vertical resize +10<CR>")
map("n", "<S-Up>", ":resize -10<CR>")
map("n", "<S-Down>", ":resize +10<CR>")

-- Alternate escape sequence for terminal emulator
map("t", "ก", [[<C-\><C-n>]])

-- Make escape fancy
map("n", [[<C-\><C-n>]], "<Esc>")

local function conditional_escape()
  if vim.fn.bufname("%") == "[Command Line]" then
    if vim.fn.mode() == "n" then
      vim.cmd("close")
    end
  else
    vim.cmd([[normal! \<C-\>\<C-n>]])
  end
end

map("n", "<Esc>", conditional_escape, { silent = true })

-- Open quickfix window
map("n", "<Leader>fq", ":copen | silent grep! ")

-- Restart LSP
map("n", "<Leader><Leader>r", ":LspRestart<CR>")
