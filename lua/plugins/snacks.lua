return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    debug = { },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { },
    picker = { },
    notifier = { },
    quickfile = { },
    scope = { },
    scroll = { enabled = false }, -- not the UX I'm looking for
    statuscolumn = { enabled = false },
    toggle = { },
    win = { },
    words = { },
    image = {
      doc = {
        -- takes precedence over `opts.float` on supported terminals
        inline = true,
        -- render the image in a floating window
        -- only used if `opts.inline` is disabled
        float = false,
        max_width = 120,
      },
    },
  },
}
