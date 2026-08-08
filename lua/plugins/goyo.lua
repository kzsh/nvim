-- Distraction-free vim config -- often used in presentation
return {
  'junegunn/goyo.vim',
  config = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "GoyoEnter",
      nested = true,
      callback = function(ev)
        vim.keymap.set('n', '<S-L>', 'gt')
        vim.keymap.set('n', '<S-H>', 'g<S-t>')
        vim.opt.wrap = true
        vim.opt.linebreak = true
      end
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "GoyoLeave",
      nested = true,
      callback = function(ev)
        vim.keymap.set('n', '<S-L>', 'bn')
        vim.keymap.set('n', '<S-H>', 'bp')
        vim.opt.wrap = false
        vim.opt.linebreak = false
      end
    })
  end,
  cmd = 'Goyo',
  keys = {
    { '<leader>go', ':Goyo<CR>' },
  },
}
