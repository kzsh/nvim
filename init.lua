-- TODOS:
-- - port source cloning function
-- - port rpc sourcing

--==========================================================
-- Startup-only commands
--==========================================================
vim.g.mapleader = " "
require('init/startup')
require('init/lazy')

require('autocmd')
require('commands')
require('cfg/spell')
require('cfg/pane') -- TODO: group under nvim?
require('cfg/buffer')
require('cfg/diff')
require('cfg/terminal')
require('cfg/nvim-mods')
require('fns/execute')
require('fns/tig')
require('fns/github')
require('keybindings')
