return {
  'Tsuzat/NeoSolarized.nvim',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  config = function()
    -- load the colorscheme here
    vim.cmd([[
    "colorscheme NeoSolarized
    "highlight OctoEditable guibg=#1a1a26
    "highlight OctoGreyFloat guifg=#2a354c guibg=#1a1a26
    "highlight OctoBlueFloat guifg=#58a6ff guibg=#1a1a26
    "highlight OctoYellowFloat guifg=#d3c846 guibg=#1a1a26
    "highlight OctoPurpleFloat guifg=#6f42c1 guibg=#1a1a26
    "highlight OctoRedFloat guifg=#da3633 guibg=#1a1a26
    "highlight OctoGreenFloat guifg=#238636 guibg=#1a1a26
      let g:neosolarized_contrast = "hight"
      let g:neosolarized_visibility = "normal"
    ]])
  end,
}
