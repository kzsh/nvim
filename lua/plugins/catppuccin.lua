return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  config = function()
    vim.cmd([[colorscheme catppuccin]])
  end,
}
