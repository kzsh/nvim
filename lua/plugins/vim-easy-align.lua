-- Generalized text aligner
return {
  'junegunn/vim-easy-align',
  keys = {
    { 'ga', '<Plug>(EasyAlign)', ft = 'markdown', mode = 'x' },
    { 'ga', '<Plug>(EasyAlign)', ft = 'markdown' },
  },
}
