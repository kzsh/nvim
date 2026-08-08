-- Per directory vim-config
return {
  'chazy/dirsettings',
  event = {
    'BufNew',
    'BufNewFile',
    'BufReadPost',
    'VimEnter',
  }
}
