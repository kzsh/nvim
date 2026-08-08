-- Show +/-/~ in the gutter
return {
  'lewis6991/gitsigns.nvim',
  event = 'BufEnter',
  config = function()
    -- gitsigns isn't set as the MAIN for lazy's purposes
    require('gitsigns').setup()
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
  }
}
