local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Filetype detection
vim.filetype.add({
  extension = {
    applescript = "applescript",
    avdl = "avdl",
    kt = "kotlin",
    markdown = "markdown",
    md = "markdown",
    mkd = "markdown",
    jbuilder = "ruby",
    dockerfile = "dockerfile",
    swift = "swift",
    ts = "typescript",
    tsx = "typescript.tsx",
    dust = "dust",
    handlebars = "mustache",
    ipynb = "python",
    cypher = "cypher",
    shader = "hlsl",
  },
  filename = {
    [".babelrc"] = "json",
    [".eslintrc"] = "json",
    [".stylelintrc"] = "json",
    ["coc-settings.json"] = "jsonc",
    ["tsconfig.json"] = "jsonc",
    ["requirements.txt"] = "python",
    [".swcrc"] = "json",
    [".envrc"] = "sh",
    [".xinitrc"] = "sh",
    ["rules"] = "make",
    ["default.conf"] = "conf",
  },
  pattern = {
    ["^Jenkinsfile"] = "groovy",
    ["Jenkinsfile$"] = "groovy",
    ["^Podfile"] = "ruby",
    ["^Vagrantfile"] = "ruby",
    ["^Dockerfile"] = "dockerfile",
    ["%-Dockerfile$"] = "dockerfile",
    ["%-dockerfile$"] = "dockerfile",
    ["%.mongo%.js$"] = "mongodb.javascript",
    ["^%.gitignore"] = "conf",
    ["sxhkdrc$"] = "sxhkdrc",
    ["%.yml%.template$"] = "yaml",
  },
})

-- Per-filetype settings
local ft_group = augroup("FileTypeSettings", { clear = true })

autocmd("FileType", {
  group = ft_group,
  pattern = { "html", "css", "xml", "jsp", "ruby", "javascript", "typescript", "swift", "svelte" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

autocmd("FileType", {
  group = ft_group,
  pattern = "tag",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.syntax = "ON"
  end,
})

autocmd("FileType", {
  group = ft_group,
  pattern = "mongodb.javascript",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.syntax = "javascript"
  end,
})

autocmd("FileType", {
  group = ft_group,
  pattern = { "m", "h", "kotlin" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

autocmd("FileType", {
  group = ft_group,
  pattern = { "wflow", "plist", "groovy" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.syntax = "ON"
  end,
})

autocmd("FileType", {
  group = ft_group,
  pattern = "applescript",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false
    vim.opt_local.syntax = "ON"
  end,
})

autocmd("FileType", {
  group = ft_group,
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 0
    vim.opt_local.spell = true
  end,
})

autocmd("FileType", {
  group = ft_group,
  pattern = "json",
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

autocmd("FileType", {
  group = ft_group,
  pattern = "gitconfig",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = false
    vim.opt_local.syntax = "ON"
  end,
})

autocmd("FileType", {
  group = ft_group,
  pattern = { "fugitiveblame", "make", "xf86conf", "checkhealth", "diff", "csv", "conf" },
  callback = function()
    vim.opt_local.syntax = "ON"
  end,
})

autocmd("FileType", {
  group = ft_group,
  pattern = "git*",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.syntax = "ON"
  end,
})

autocmd("FileType", {
  group = ft_group,
  pattern = "sxhkdrc",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = false
    vim.opt_local.syntax = "conf"
  end,
})

autocmd("FileType", {
  group = ft_group,
  pattern = "cypher",
  callback = function()
    vim.opt_local.syntax = "ON"
    vim.opt_local.commentstring = "// %s"
  end,
})

autocmd("FileType", {
  group = ft_group,
  pattern = "vimwiki",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.syntax = "ON"
  end,
})

-- JSON comment highlighting
autocmd("FileType", {
  group = ft_group,
  pattern = "json",
  command = [[syntax match Comment +\/\/.\+$+]],
})

-- Prettier makeprg for JS/TS
autocmd("FileType", {
  group = ft_group,
  pattern = { "javascript", "typescript" },
  callback = function()
    vim.opt_local.makeprg = "pretty-quick --pattern %"
  end,
})

-- Autocommit changes to notes
local notes_path = vim.fn.expand("$NOTES_DIR")
local autocommit_group = augroup("autoCommitChangesToNotes", { clear = true })

autocmd("BufWritePre", {
  group = autocommit_group,
  pattern = vim.fn.expand("~/notes") .. "/**",
  callback = function()
    vim.fn.system(notes_path .. "/autocommit.sh")
  end,
})
