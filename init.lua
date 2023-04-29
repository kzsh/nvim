-- TODOS:
-- - port source cloning function
-- - port rpc sourcing

--==========================================================
-- Startup-only commands
--==========================================================
if vim.fn.has("vim_starting") then
  vim.g.mapleader = " "
  require "init/startup"
  require 'init/lazy'

end

require 'impatient'
require 'utils'
require 'autocmd'
require 'commands'
require 'cfg/spell'
require 'cfg/pane' -- TODO: group under nvim?
require 'cfg/buffer'
require 'cfg/diff'
require 'cfg/nvim-mods'
require 'fns/buffer'
require 'fns/execute'
require 'fns/tig'
require 'fns/git'
require 'fns/github'
require 'cfg/terminal'
-- require 'cfg/ale' -- Move to plugins.lua under ale entry
require 'keybindings'
