return {
  'dstein64/vim-startuptime',
  cmd = 'StartupTime',
  init = function()
    vim.g.startuptime_tries = 15
  end,
}
