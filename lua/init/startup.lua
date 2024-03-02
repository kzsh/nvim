--==========================================================
-- Configure globals/opts
--==========================================================
kzsh = {}
kzsh.vim_tmp_dir = vim.env.VIM_DIR .. '/.tmp'
kzsh.system_tmp_dir = '/tmp/neovim'
kzsh.query_result_dir = vim.env.HOME .. '/.neovim-queries'
kzsh.vim_log_dir = kzsh.system_tmp_dir
vim.g.kzsh = kzsh

vim.fn.mkdir(vim.g.kzsh.vim_log_dir, 'p')

vim.g.path = ".,**,,"
vim.opt.path = vim.g.path

vim.opt.mouse = ""
vim.opt.scrollback=100000
vim.opt.modeline = false
vim.opt.wrap = false
vim.opt.laststatus = 1
vim.opt.showmode = false
vim.opt.shortmess = "filnxtToOFrsI"
vim.opt.regexpengine = 0
vim.opt.hidden = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 5
vim.opt.list = true
vim.opt.listchars = "space: ,tab:  ,trail:~,extends:>,precedes:<"
-- vim.opt.listchars = "tab:>-,trail:~,extends:>,precedes:<"
vim.opt.timeout = false
vim.opt.ttimeout = false
vim.opt.ttimeoutlen = 0

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.shell = "/bin/bash -O globstar"
vim.opt.number = true
vim.opt.showbreak = "↪"
vim.opt.synmaxcol = 512
vim.opt.splitright = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr="nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 1
vim.opt.foldenable = false
vim.opt.formatoptions = "qrn1j"
vim.opt.shiftround = true
-- vim.opt.wildmenu=longest:full,full
vim.opt.wildignore = "*.git,*.hg,*.svn,*/tmp/*,*.so,*.swp,*.zip"
vim.opt.complete = ".,w,b,u,t,i"
vim.opt.completeopt = "longest,menuone,preview,noselect"

vim.opt.undofile = true
vim.opt.undolevels=1000
vim.opt.undoreload=10000

if vim.fn.executable('rg') then
  -- set grepprg=rg\ --vimgrep\ --no-heading
  vim.opt.grepprg = "rg --column --colors path:fg:blue --line-number --no-heading --color=always --smart-case"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

-- TODO: Update this syntax
vim.cmd([[
set clipboard=unnamed
set clipboard+=unnamedplus
]])

vim.cmd([[
syntax manual
]])

