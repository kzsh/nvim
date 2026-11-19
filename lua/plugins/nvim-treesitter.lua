return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    'RRethy/nvim-treesitter-endwise',
  },
  branch = 'main',
  -- main does not support lazy-loading
  lazy = false,
  build = ':TSUpdate',
  config = function()
    -- async, and a no-op for parsers already installed
    require('nvim-treesitter').install {
      "bash",
      "c",
      "css",
      "cpp",
      "dockerfile",
      "vimdoc",
      "java",
      "json",
      "html",
      "javascript",
      "lua",
      "python",
      "rust",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    }

    -- pcall: start() errors on filetypes with no installed parser
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('UserTreesitter', {}),
      callback = function(ev) pcall(vim.treesitter.start, ev.buf) end,
    })

    require('nvim-treesitter-textobjects').setup {
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V',  -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        include_surrounding_whitespace = true,
      },
    }

    local select = require('nvim-treesitter-textobjects.select')
    local selections = {
      af = { '@function.outer', 'textobjects' },
      ['if'] = { '@function.inner', 'textobjects' },
      ac = { '@class.outer', 'textobjects' },
      ic = { '@class.inner', 'textobjects', 'Select inner part of a class region' },
      as = { '@local.scope', 'locals', 'Select language scope' },
    }
    for lhs, s in pairs(selections) do
      vim.keymap.set({ 'x', 'o' }, lhs, function()
        select.select_textobject(s[1], s[2])
      end, { desc = s[3] })
    end

    local swap = require('nvim-treesitter-textobjects.swap')
    for _, lhs in ipairs { '<leader><leader>j', '<leader><leader>l' } do
      vim.keymap.set('n', lhs, function() swap.swap_next '@parameter.inner' end)
    end
    for _, lhs in ipairs { '<leader><leader>h', '<leader><leader>k' } do
      vim.keymap.set('n', lhs, function() swap.swap_previous '@parameter.inner' end)
    end
  end
}
