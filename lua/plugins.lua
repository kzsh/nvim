--==========================================================
-- Load Lazy.nvim plugins
--==========================================================

local cwd = function() return vim.fn.expand('%:p:h') end
local git_root_dir = function()
  return vim.fn.systemlist("git rev-parse --show-toplevel")[1]
end

return {
{
  'ojroques/nvim-bufdel',
  cmd = 'BufDel',
},
{
  'kevinhwang91/nvim-bqf',
  ft = 'qf',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'junegunn/fzf'
  }
},
{
  'numToStr/Comment.nvim'
},
'andymass/vim-matchup',
{
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  opts = {
    defaults = {
      layout_strategy = 'vertical',
      layout_config = {
        preview_cutoff = 20,
        width = 0.99,
        height = 0.999999,
      },
    },
    extensions = {
      fzf = {
        -- fuzzy = true,                    -- false will only do exact matching
        -- override_generic_sorter = true,  -- override the generic sorter
        -- override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      live_grep_args = {}
    },
  },
  keys = {
    {'<leader>;f', function() require('telescope.builtin').find_files() end},
    {'<leader>;F', function()
      require('telescope.builtin').find_files({ cwd = cwd() })
    end},
    {'<leader>;af', function()
      require('telescope.builtin').find_files({ cwd = git_root_dir() })
    end},
    {'<leader>af', function()
      require('telescope.builtin').live_grep({ cwd = git_root_dir() })
    end},
    {'<leader>ff', require('telescope.builtin').live_grep},
    {'<leader>FF', function()
      require('telescope.builtin').live_grep({ cwd = cwd() })
    end},
    {'<leader>fw', require('telescope.builtin').grep_string},
    {'<leader>;;', require('telescope.builtin').buffers},
    {'<leader>;h', require('telescope.builtin').help_tags},
  },
  cmd = 'Telescope',
},
{
  'nvim-telescope/telescope-fzf-native.nvim',
  lazy = true,-- Only load when Telescope is called
  build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
},
-- {
--     'hrsh7th/nvim-cmp',
--     config = function(opts)
--       local cmp = require('cmp')
--
--       cmp.setup({
--         confirmation = {
--           completeopt = 'longest,menuone,preview',
--         },
--         sources = cmp.config.sources({
--           { name = 'nvim_lsp' },
--           { name = 'nvim_lsp_signature_help' },
--           { name = 'buffer' },
--           { name = 'nvim_lua' },
--           { name = 'under_comparator' },
--           { name = 'path' },
--         }),
--         mapping = cmp.mapping.preset.insert({
--           ["<CR>"] = cmp.config.disable,
--           -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--           ["<C-p>"] = cmp.mapping.select_prev_item(),
--           ["<C-n>"] = cmp.mapping.select_next_item(),
--           ["<C-e>"] = cmp.mapping.abort(),
--           ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--           ['<C-f>'] = cmp.mapping.scroll_docs(4),
--           ['<C-Space>'] = cmp.mapping.complete(),
--           ['<C-e>'] = cmp.mapping.abort(),
--         })
--       })
--     end,
--     event = 'InsertEnter',
--
--     -- mapping logic is handled by cmp in opts^
--     keys = {
--       '<CR>',
--       '<C-p>',
--       '<C-n>',
--       '<C-e>',
--       '<C-b>',
--       '<C-f>',
--       '<C-Space>',
--       '<C-e>',
--     },
--
--     dependencies = {
--       'hrsh7th/cmp-buffer',
--       'hrsh7th/cmp-nvim-lsp',
-- --       'onsails/lspkind.nvim',
--       'hrsh7th/cmp-nvim-lsp-signature-help',
--       'hrsh7th/cmp-path',
--       'hrsh7th/cmp-nvim-lua',
--       'lukas-reineke/cmp-under-comparator',
-- --       'dcampos/cmp-snippy',
--       -- 'hrsh7th/cmp-cmdline',
-- --       'hrsh7th/cmp-nvim-lsp-document-symbol',
-- --       'doxnit/cmp-luasnip-choice',
--     },
-- },
{
  -- Show +/-/~ in the gutter
  'lewis6991/gitsigns.nvim',
  event = 'BufEnter',
  config = function()
    -- gitsigns isn't set as the MAIN for lazy's purposes
    require('gitsigns').setup()
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
  }
},
-- 'airblade/vim-gitgutter',

-- Add :ConvertColorTo to convert css colors
{
  'amadeus/vim-convert-color-to',
  cmd = 'ConvertColorTo',
},

--Per directory vim-config
{
  'chazy/dirsettings',
  event = {
    'BufNew',
    'BufNewFile',
    'BufReadPost',
    'VimEnter',
  }
},

-- General purpose linter
-- {
--   'dense-analysis/ale',
--   config = true
-- },

'editorconfig/editorconfig-vim',

-- Experimental in-line images in vim (not used)
-- {
--   'edluffy/hologram.nvim',
--   lazy = false,
--   opts = {
--     auto_display = true,
--   },
-- },

-- Support many traversal behaviors
{
  'junegunn/fzf',
  build = ":call fzf#install()"
},

-- Distraction-free vim config -- often used in presentation
{
  'junegunn/goyo.vim',
  config = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "GoyoEnter",
      nested = true,
      callback = function(ev)
        vim.keymap.set('n', '<S-L>', 'gt')
        vim.keymap.set('n', '<S-H>', 'g<S-t>')
      end
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "GoyoLeave",
      nested = true,
      callback = function(ev)
        vim.keymap.set('n', '<S-L>', 'bn')
        vim.keymap.set('n', '<S-H>', 'bp')
      end
    })
  end,
  cmd = 'Goyo',
  keys = {
    { '<leader>go', ':Goyo<CR>' },
  },
},
{
  -- Generalized text aligner
  'junegunn/vim-easy-align',
  keys = {
    { 'ga', '<Plug>(EasyAlign)', ft = 'markdown', mode = 'x' },
    { 'ga', '<Plug>(EasyAlign)', ft = 'markdown' },
  },
},

-- Display marks in gutter (does more, but I don't use that)
{
  'chentoast/marks.nvim',
  keys = {
    'm'
  },
  opts = {
    -- mappings = {
    --   {'m,', 'set_next'},               -- Set next available lowercase mark at cursor.
    --   {'m;', 'toggle'},                 -- Toggle next available mark at cursor.
    --   {'dm-', 'delete_line'},            -- Deletes all marks on current line.
    --   {'dm<Space>', 'delete_buf'},             -- Deletes all marks in current buffer.
    --   {'m]', 'next'},                   -- Goes to next mark in buffer.
    --   {'m[', 'prev'},                   -- Goes to previous mark in buffer.
    --   {'m:', 'preview'},                -- Previews mark (will wait for user input). press <cr> to just preview the next mark.
    --   -- {'m', 'set'}                    -- Sets a letter mark (will wait for input).
    --   -- {'', 'delete'}                 -- Delete a letter mark (will wait for input).
    --
    --   -- {'', 'set_bookmark0'}      -- Sets a bookmark from group[0-9].
    --   -- {'', 'delete_bookmark0'}   -- Deletes all bookmarks from group[0-9].
    --   -- {'', 'delete_bookmark'}        -- Deletes the bookmark under the cursor.
    --   -- {'', 'next_bookmark'}          -- Moves to the next bookmark having the same type as the
    --                                 -- bookmark under the cursor.
    --   -- {'', 'prev_bookmark'}          -- Moves to the previous bookmark having the same type as the
    --                                 -- bookmark under the cursor.
    --   -- {'', 'next_bookmark0'}         --Moves to the next bookmark of the same group type. Works by
    --                                 -- first going according to line number, and then according to buffer
    --                                 -- number.
    --   --0 {'', 'prev_bookmark0'}         -- Moves to the previous bookmark of the same group type. Works by
    --                                 -- first going according to line number, and then according to buffer
    --                                 -- number.
    --   -- {'', 'annotate'}               -- Prompts the user for a virtual line annotation that is then placed
    --                             -- above the bookmark. Requires neovim 0.6+ and is not mapped by default.
    -- }
  }
},

-- Display binary in a hexdump format
{
  'mattn/vim-xxdcursor',
  ft = {
    'xxd',
    'binary'
  },
},

-- {
--   'brenoprata10/nvim-highlight-colors',
--   init = function()
--     require('nvim-highlight-colors').setup({})
--   end
-- },
'teal-language/vim-teal',
{
  'b0o/incline.nvim',
  event = 'BufEnter',
  opts = {
    hide = {
      cursorline = true,
      focused_win = false,
      only_win = false
    },
  }
},
-- define and store snippets
{
  'dcampos/nvim-snippy',
  opts = {
    mappings = {
      is = {
        ['<Tab>'] = 'expand_or_advance',
        ['<S-Tab>'] = 'previous',
      },
      -- nx = {
      --   ['<leader>x'] = 'cut_text',
      -- },
    },
  },
},

-- The TPope corner
{
  'tpope/vim-abolish',
  event = 'BufRead',
},
{
  'tpope/vim-git',
  ft = { 'gitconfig', 'gituser', 'gitignore_global' }
},
-- 'tpope/vim-commentary',
-- 'tpope/vim-dadbod',
-- 'tpope/vim-eunuch',
{
  'tpope/vim-fugitive',
  event = 'BufRead',
  config = function()
    vim.cmd([[
    "==========================================================
    " Fugitive
    "==========================================================
    vnoremap <Leader>ll :'<,'>0Gclog<CR>
    nnoremap <Leader>ll :silent! call ToggleFugitive()<CR>

    " nnoremap <Leader>gs :Gstatus<CR>
    " nnoremap <Leader>df

    " command! -range FugitiveRange <line1>,<line2>call ToggleFugitive()

    function! ToggleFugitive()
      if expand('%') =~# 'fugitive'
        execute('Gedit')
      else
        execute(line('.') . 'Gclog')
      end
    endfunction
  ]])
  end
},
{
  'tpope/vim-repeat',
  event = "VeryLazy",
  priority = 1000,
},
{
  "kylechui/nvim-surround",
  version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end
},
{
  'cespare/vim-toml',
  branch = 'main',
  ft = { 'toml' },
},
{
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-refactor',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'RRethy/nvim-treesitter-endwise',
  },
  branch = 'master',
  build = ':TSUpdate',
  event = 'VeryLazy',
  config = function()
    ------------------------------------------------------------
    -- treesitter config
    ------------------------------------------------------------
    require 'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true,
      },

      incremental_selection = {
        enable = false,
      },
      endwise = {
        enable = true,
      },
      additional_vim_regex_highlighting = { 'vimscript', 'gitcommit', 'gitrebase' },

      playground = {
        enable = true,
        disable = {},
        updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },
      ensure_installed = {
        "bash",
        "c",
        "css",
        "cpp",
        "dockerfile",
        "vimdoc",
        "java",
        "json",
        "jsonc",
        "html",
        "javascript",
        "lua",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            -- You can also use captures from other query groups like `locals.scm`
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V',  -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true or false
          include_surrounding_whitespace = true,
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader><leader>j"] = "@parameter.inner",
            ["<leader><leader>l"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader><leader>h"] = "@parameter.inner",
            ["<leader><leader>k"] = "@parameter.inner",
          },
        },
      },
    }
  end
},
{
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = true,
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
},

{
  'lervag/vimtex',
  ft = { 'tex' },
  init = function()
    local g = vim.g
    g.vimtex_complete_recursive_bib = 1
    g.vimtex_complete_enabled = 1
    g.vimtex_quickfix_method = 'pplatex'
    g.tex_conceal = ''
    g.vimtex_quickfix_mode = 0
    g.vimtex_view_forward_search_on_start = 0
    g.vimtex_view_method = 'sioyek'
    -- g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
    -- g.vimtex_compiler_latexrun = { options = { '-verbose-cmds', '--latex-args="-synctex=1"', '--bibtex-cmd=biber' } }
    -- This must be a dictionary, and {} gets converted to a list
    g.vimtex_syntax_conceal_disable = 1
  end
},
'barreiroleo/ltex_extra.nvim',
{
  'dstein64/vim-startuptime',
  cmd = 'StartupTime',
  init = function()
    vim.g.startuptime_tries = 15
  end,
},
{
  'neo4j-contrib/cypher-vim-syntax',
  ft = { 'cypher' }
},
{
  'jimmyhchan/dustjs.vim',
  ft = { 'dustjs', 'dust' }
},
{
  'mustache/vim-mustache-handlebars',
  ft = { 'handlebars' }
},
{
  'jparise/vim-graphql',
  ft = { 'graphql' }
},
{
  'towolf/vim-helm',
  ft = { 'helm', 'yaml' }
},
{
  'udalov/kotlin-vim',
  ft = { 'kotlin' }
},
{
  'dkarter/bullets.vim',
  ft = { 'markdown' }
},
{
  'jeetsukumaran/vim-pursuit',
  branch = 'main',
  ft = { 'markdown' },
},
{
  'plasticboy/vim-markdown',
  enabled = false,
  ft = { 'markdown' },
  config = function()
    vim.cmd([[
    "==========================================================
    " vim Markdown
    "==========================================================
    let g:markdown_fenced_languages = ['html', 'ruby', 'js=javascript', 'python', 'bash=sh', 'graphql', 'ts=typescript', 'sql', 'cypher']
    " let g:vim_markdown_conceal = 0
    let g:vim_markdown_conceal_code_blocks = 0
  ]])
  end
},
-- {
--   'dhruvasagar/vim-table-mode',
--   ft = {'markdown'},
-- }
{
  'darfink/vim-plist',
  ft = { 'plist' }
},
{
  'noprompt/vim-yardoc',
  ft = { 'ruby' }
},
{
  'rust-lang/rust.vim',
  ft = { 'rust' }
},
{
  'lifepillar/pgsql.vim',
  ft = { 'sql' }
},
{
  'mitsuse/autocomplete-swift',
  ft = { 'swift' }
},
{
  'cespare/vim-toml',
  ft = { 'toml' }
},
{
  'rhysd/reply.vim',
  ft = { 'Repl', 'ReplAuto', 'ReplSend' }
},
{
  'simrat39/rust-tools.nvim',
  ft = { 'rust' },
  config = function()
    local rt = require("rust-tools")
    rt.setup({
      server = {
        -- on_attach = function(_, bufnr)
        -- Hover actions
        -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        -- end,
      },
    })
  end
},
{
  'folke/trouble.nvim'
},
{
  'folke/neodev.nvim',
},
{
  "folke/tokyonight.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  config = function()
    -- load the colorscheme here
    -- vim.cmd([[colorscheme tokyonight]])
  end,
},
{
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
},
{
  'morhetz/gruvbox',
  name = "gruvbox",
  lazy = true, -- make sure we load this during startup if it is your main colorscheme
  config = function()
    -- load the colorscheme here
    -- vim.cmd([[colorscheme gruvbox]])
  end,
},
{
  'kepano/flexoki-neovim',
  name = "flexoki",
  lazy = true, -- make sure we load this during startup if it is your main colorscheme
  config = function()
    -- load the colorscheme here
    -- vim.cmd([[colorscheme flexoki ]])
  end,
},
{
  'folke/tokyonight.nvim',
  name = "tokyonight",
  lazy = true, -- make sure we load this during startup if it is your main colorscheme
  config = function()
    -- load the colorscheme here
    -- vim.cmd([[colorscheme tokyonight ]])
  end,
},
{
  'rebelot/kanagawa.nvim',
  name = "kanagawa",
  lazy = true, -- make sure we load this during startup if it is your main colorscheme
  config = function()
    -- load the colorscheme here
    -- vim.cmd([[colorscheme kanagawa ]])
  end,
},
{
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  config = function()
    vim.cmd([[colorscheme catppuccin]])
  end,
},
{
  'NLKNguyen/papercolor-theme',
  lazy = true, -- make sure we load this during startup if it is your main colorscheme
  config = function()
    -- load the colorscheme here
    -- vim.cmd([[colorscheme PaperColor ]])
  end,
},
{
  "mason-org/mason-lspconfig.nvim",
  -- opts = {
  --   ensure_installed = {
  --     "bash-language-server",
  --     "bashls",
  --     -- "clangd",
  --     "css-lsp",
  --     "cssls",
  --     "cssmodules-language-server",
  --     "cssmodules_ls",
  --     "java-language-server",
  --     "java_language_server",
  --     "stylelint",
  --     "stylelint-lsp",
  --     "stylelint_lsp",
  --     "typescript-language-server",
  --     "tsserver",
  --   },
  -- },
  dependencies = {
    {"mason-org/mason.nvim", "neovim/nvim-lspconfig"},
  },
},
{
  'neovim/nvim-lspconfig',
  init = function()
    -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- vim.lsp.config('bashls', {})
    -- vim.lsp.enable('bashls')
    --
    -- vim.lsp.config('lua_ls', {
    --   diagnostics = {
    --     globals = { 'vim' }, -- Add 'vim' here
    --   },
    -- })
    -- vim.lsp.enable('lua_ls')

    -- vim.lsp.config('clangd', {
    --   format_on_save = false,
    --   on_attach = function(client, bufnr)
    --     client.server_capabilities.signatureHelpProvider = false
    --     on_attach(client, bufnr)
    --   end,
    --   capabilities = capabilities,
    -- })

    -- vim.lsp.config('cssls', {
    --   capabilities = capabilities
    -- })

    -- vim.lsp.config('rust_analyzer', {
    --   capabilities = capabilities
    -- })

    vim.lsp.config('ts_ls', {})
    vim.lsp.enable('ts_ls')

    -- vim.lsp.config('cssmodules_ls', {
    --   capabilities = capabilities
    -- })

    -- vim.lsp.config('stylelint_lsp', {
    --   capabilities = capabilities,
    --   filetypes = {'css', 'less', 'scss'}
    -- })

    -- vim.lsp.config('jdtls', {
    --   capabilities = capabilities,
    --   code_actions = {
    --     enable = true,
    --     apply_on_save = {
    --       enable = true,
    --       types = { "directive", "problem", "suggestion", "layout" },
    --     },
    --     disable_rule_comment = {
    --       enable = true,
    --       location = "separate_line", -- or `same_line`
    --     },
    --   },
    --   diagnostics = {
    --     enable = true,
    --     report_unused_disable_directives = false,
    --     run_on = "save", -- or `type`
    --   },
    -- })
    -- vim.lsp.enable('jdtls')

    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   callback = function(ev)
    --     vim.lsp.buf.format({
    --       filter = function(client) return client.name ~= "ts_ls" end
    --     })
    --   end
    -- })

    vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader><leader>s', vim.lsp.buf.signature_help, opts)
        -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        -- vim.keymap.set('n', '<leader>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, opts)
        vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>mr', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>mca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>mf', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })
  end,
},
{
  "pwntester/octo.nvim",
  cmd = "Octo",
  opts = {
    use_local_fs = false,                      -- use local files on right side of reviews
    enable_builtin = false,                    -- shows a list of builtin actions when no action is provided
    default_remote = { "upstream", "origin" }, -- order to try remotes
    default_merge_method = "merge",            -- default merge method which should be used for both `Octo pr merge` and merging from picker, could be `merge`, `rebase` or `squash`
    default_delete_branch = false,             -- whether to delete branch when merging pull request with either `Octo pr merge` or from picker (can be overridden with `delete`/`nodelete` argument to `Octo pr merge`)
    ssh_aliases = {},                          -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`. The key part will be interpreted as an anchored Lua pattern.
    picker = "telescope",                      -- or "fzf-lua" or "snacks" or "default"
    picker_config = {
      use_emojis = false,                      -- only used by "fzf-lua" picker for now
      search_static = true,                    -- Whether to use static search results (true) or dynamic search (false)
      mappings = {                             -- mappings for the pickers
        open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
        copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
        copy_sha = { lhs = "<C-e>", desc = "copy commit SHA to system clipboard" },
        checkout_pr = { lhs = "<C-o>", desc = "checkout pull request" },
        merge_pr = { lhs = "<C-r>", desc = "merge pull request" },
      },
      snacks = {     -- snacks specific config
        actions = {  -- custom actions for specific snacks pickers (array of tables)
          issues = { -- actions for the issues picker
            -- { name = "my_issue_action", fn = function(picker, item) print("Issue action:", vim.inspect(item)) end, lhs = "<leader>a", desc = "My custom issue action" },
          },
          pull_requests = { -- actions for the pull requests picker
            -- { name = "my_pr_action", fn = function(picker, item) print("PR action:", vim.inspect(item)) end, lhs = "<leader>b", desc = "My custom PR action" },
          },
          notifications = {},   -- actions for the notifications picker
          issue_templates = {}, -- actions for the issue templates picker
          search = {},          -- actions for the search picker
          -- ... add actions for other pickers as needed
        },
      },
    },
    comment_icon = "▎", -- comment marker
    outdated_icon = "󰅒 ", -- outdated indicator
    resolved_icon = " ", -- resolved indicator
    reaction_viewer_hint_icon = " ", -- marker for user reactions
    commands = {}, -- additional subcommands made available to `Octo` command
    users = "search", -- Users for assignees or reviewers. Values: "search" | "mentionable" | "assignable"
    user_icon = " ", -- user icon
    ghost_icon = "󰊠 ", -- ghost icon
    copilot_icon = " ", -- copilot icon
    timeline_marker = " ", -- timeline marker
    timeline_indent = 2, -- timeline indentation
    use_timeline_icons = true, -- toggle timeline icons
    timeline_icons = { -- the default icons based on timelineItems
      auto_squash = "  ",
      commit_push = "  ",
      comment_deleted = " ",
      force_push = "  ",
      draft = "  ",
      ready = " ",
      commit = "  ",
      deployed = "  ",
      issue_type = "  ",
      label = "  ",
      reference = "  ",
      project = "  ",
      connected = "  ",
      subissue = "  ",
      cross_reference = "  ",
      parent_issue = "  ",
      head_ref = "  ",
      pinned = "  ",
      milestone = "  ",
      renamed = "  ",
      automatic_base_change_succeeded = "  ",
      base_ref_changed = "  ",
      merged = { "  ", "OctoPurple" },
      closed = {
        closed = { "  ", "OctoRed" },
        completed = { "  ", "OctoPurple" },
        not_planned = { "  ", "OctoGrey" },
        duplicate = { "  ", "OctoGrey" },
      },
      reopened = { "  ", "OctoGreen" },
      assigned = "  ",
      review_requested = "  ",
    },
    right_bubble_delimiter = "", -- bubble delimiter
    left_bubble_delimiter = "", -- bubble delimiter
    github_hostname = "", -- GitHub Enterprise host
    snippet_context_lines = 4, -- number or lines around commented lines
    gh_cmd = "gh", -- Command to use when calling Github CLI
    gh_env = {}, -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
    timeout = 5000, -- timeout for requests between the remote server
    default_to_projects_v2 = false, -- use projects v2 for the `Octo card ...` command by default. Both legacy and v2 commands are available under `Octo cardlegacy ...` and `Octo cardv2 ...` respectively.
    -- Also disable sending v2 events into Github API.
    ui = {
      use_signcolumn = false, -- show "modified" marks on the sign column
      use_signstatus = true,  -- show "modified" marks on the status column
    },
    issues = {
      order_by = {            -- criteria to sort results of `Octo issue list`
        field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
        direction =
        "DESC"                -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
      }
    },
    reviews = {
      auto_show_threads = true,    -- automatically show comment threads on cursor move
      focus             = "right", -- focus right buffer on diff open
    },
    runs = {
      icons = {
        pending = "🕖",
        in_progress = "🔄",
        failed = "❌",
        succeeded = "",
        skipped = "⏩",
        cancelled = "✖",
      },
    },
    pull_requests = {
      order_by = {                            -- criteria to sort the results of `Octo pr list`
        field = "CREATED_AT",                 -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
        direction =
        "DESC"                                -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
      },
      always_select_remote_on_create = false, -- always give prompt to select base remote repo when creating PRs
      use_branch_name_as_title = false        -- sets branch name to be the name for the PR
    },
    notifications = {
      current_repo_only = false, -- show notifications for current repo only
    },
    file_panel = {
      size = 10,       -- changed files panel rows
      use_icons = true -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
    },
    colors = {         -- used for highlight groups (see Colors section below)
      white = "#ffffff",
      grey = "#2A354C",
      black = "#000000",
      red = "#fdb8c0",
      dark_red = "#da3633",
      green = "#acf2bd",
      dark_green = "#238636",
      yellow = "#d3c846",
      dark_yellow = "#735c0f",
      blue = "#58A6FF",
      dark_blue = "#0366d6",
      purple = "#6f42c1",
    },
    mappings_disable_default = false, -- disable default mappings if true, but will still adapt user mappings
    mappings = {
      discussion = {
        discussion_options = { lhs = "<CR>", desc = "show discussion options" },
        open_in_browser = { lhs = "<C-b>", desc = "open discussion in browser" },
        copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
        add_comment = { lhs = "<localleader>ca", desc = "add comment" },
        add_reply = { lhs = "<localleader>cr", desc = "add reply" },
        delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
        add_label = { lhs = "<localleader>la", desc = "add label" },
        remove_label = { lhs = "<localleader>ld", desc = "remove label" },
        next_comment = { lhs = "]c", desc = "go to next comment" },
        prev_comment = { lhs = "[c", desc = "go to previous comment" },
        react_hooray = { lhs = "<localleader>rp", desc = "add/remove 🎉 reaction" },
        react_heart = { lhs = "<localleader>rh", desc = "add/remove ❤️ reaction" },
        react_eyes = { lhs = "<localleader>re", desc = "add/remove 👀 reaction" },
        react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove 👍 reaction" },
        react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove 👎 reaction" },
        react_rocket = { lhs = "<localleader>rr", desc = "add/remove 🚀 reaction" },
        react_laugh = { lhs = "<localleader>rl", desc = "add/remove 😄 reaction" },
        react_confused = { lhs = "<localleader>rc", desc = "add/remove 😕 reaction" },
      },
      runs = {
        expand_step = { lhs = "o", desc = "expand workflow step" },
        open_in_browser = { lhs = "<C-b>", desc = "open workflow run in browser" },
        refresh = { lhs = "<C-r>", desc = "refresh workflow" },
        rerun = { lhs = "<C-o>", desc = "rerun workflow" },
        rerun_failed = { lhs = "<C-f>", desc = "rerun failed workflow" },
        cancel = { lhs = "<C-x>", desc = "cancel workflow" },
        copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
      },
      issue = {
        issue_options = { lhs = "<CR>", desc = "show issue options" },
        close_issue = { lhs = "<localleader>ic", desc = "close issue" },
        reopen_issue = { lhs = "<localleader>io", desc = "reopen issue" },
        list_issues = { lhs = "<localleader>il", desc = "list open issues on same repo" },
        reload = { lhs = "<C-r>", desc = "reload issue" },
        open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
        copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
        add_assignee = { lhs = "<localleader>aa", desc = "add assignee" },
        remove_assignee = { lhs = "<localleader>ad", desc = "remove assignee" },
        create_label = { lhs = "<localleader>lc", desc = "create label" },
        add_label = { lhs = "<localleader>la", desc = "add label" },
        remove_label = { lhs = "<localleader>ld", desc = "remove label" },
        goto_issue = { lhs = "<localleader>gi", desc = "navigate to a local repo issue" },
        add_comment = { lhs = "<localleader>ca", desc = "add comment" },
        add_reply = { lhs = "<localleader>cr", desc = "add reply" },
        delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "go to next comment" },
        prev_comment = { lhs = "[c", desc = "go to previous comment" },
        react_hooray = { lhs = "<localleader>rp", desc = "add/remove 🎉 reaction" },
        react_heart = { lhs = "<localleader>rh", desc = "add/remove ❤️ reaction" },
        react_eyes = { lhs = "<localleader>re", desc = "add/remove 👀 reaction" },
        react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove 👍 reaction" },
        react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove 👎 reaction" },
        react_rocket = { lhs = "<localleader>rr", desc = "add/remove 🚀 reaction" },
        react_laugh = { lhs = "<localleader>rl", desc = "add/remove 😄 reaction" },
        react_confused = { lhs = "<localleader>rc", desc = "add/remove 😕 reaction" },
      },
      pull_request = {
        pr_options = { lhs = "<CR>", desc = "show PR options" },
        checkout_pr = { lhs = "<localleader>po", desc = "checkout PR" },
        merge_pr = { lhs = "<localleader>pm", desc = "merge PR" },
        squash_and_merge_pr = { lhs = "<localleader>psm", desc = "squash and merge PR" },
        rebase_and_merge_pr = { lhs = "<localleader>prm", desc = "rebase and merge PR" },
        merge_pr_queue = { lhs = "<localleader>pq", desc = "merge commit PR and add to merge queue (Merge queue must be enabled in the repo)" },
        squash_and_merge_queue = { lhs = "<localleader>psq", desc = "squash and add to merge queue (Merge queue must be enabled in the repo)" },
        rebase_and_merge_queue = { lhs = "<localleader>prq", desc = "rebase and add to merge queue (Merge queue must be enabled in the repo)" },
        list_commits = { lhs = "<localleader>pc", desc = "list PR commits" },
        list_changed_files = { lhs = "<localleader>pf", desc = "list PR changed files" },
        show_pr_diff = { lhs = "<localleader>pd", desc = "show PR diff" },
        add_reviewer = { lhs = "<localleader>va", desc = "add reviewer" },
        remove_reviewer = { lhs = "<localleader>vd", desc = "remove reviewer request" },
        close_issue = { lhs = "<localleader>ic", desc = "close PR" },
        reopen_issue = { lhs = "<localleader>io", desc = "reopen PR" },
        list_issues = { lhs = "<localleader>il", desc = "list open issues on same repo" },
        reload = { lhs = "<C-r>", desc = "reload PR" },
        open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
        copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
        goto_file = { lhs = "gf", desc = "go to file" },
        add_assignee = { lhs = "<localleader>aa", desc = "add assignee" },
        remove_assignee = { lhs = "<localleader>ad", desc = "remove assignee" },
        create_label = { lhs = "<localleader>lc", desc = "create label" },
        add_label = { lhs = "<localleader>la", desc = "add label" },
        remove_label = { lhs = "<localleader>ld", desc = "remove label" },
        goto_issue = { lhs = "<localleader>gi", desc = "navigate to a local repo issue" },
        add_comment = { lhs = "<localleader>ca", desc = "add comment" },
        add_reply = { lhs = "<localleader>cr", desc = "add reply" },
        delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "go to next comment" },
        prev_comment = { lhs = "[c", desc = "go to previous comment" },
        react_hooray = { lhs = "<localleader>rp", desc = "add/remove 🎉 reaction" },
        react_heart = { lhs = "<localleader>rh", desc = "add/remove ❤️ reaction" },
        react_eyes = { lhs = "<localleader>re", desc = "add/remove 👀 reaction" },
        react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove 👍 reaction" },
        react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove 👎 reaction" },
        react_rocket = { lhs = "<localleader>rr", desc = "add/remove 🚀 reaction" },
        react_laugh = { lhs = "<localleader>rl", desc = "add/remove 😄 reaction" },
        react_confused = { lhs = "<localleader>rc", desc = "add/remove 😕 reaction" },
        review_start = { lhs = "<localleader>vs", desc = "start a review for the current PR" },
        review_resume = { lhs = "<localleader>vr", desc = "resume a pending review for the current PR" },
        resolve_thread = { lhs = "<localleader>rt", desc = "resolve PR thread" },
        unresolve_thread = { lhs = "<localleader>rT", desc = "unresolve PR thread" },
      },
      review_thread = {
        goto_issue = { lhs = "<localleader>gi", desc = "navigate to a local repo issue" },
        add_comment = { lhs = "<localleader>ca", desc = "add comment" },
        add_reply = { lhs = "<localleader>cr", desc = "add reply" },
        add_suggestion = { lhs = "<localleader>sa", desc = "add suggestion" },
        delete_comment = { lhs = "<localleader>cd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "go to next comment" },
        prev_comment = { lhs = "[c", desc = "go to previous comment" },
        select_next_entry = { lhs = "]q", desc = "move to next changed file" },
        select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
        select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
        select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
        select_next_unviewed_entry = { lhs = "]u", desc = "move to next unviewed changed file" },
        select_prev_unviewed_entry = { lhs = "[u", desc = "move to previous unviewed changed file" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        react_hooray = { lhs = "<localleader>rp", desc = "add/remove 🎉 reaction" },
        react_heart = { lhs = "<localleader>rh", desc = "add/remove ❤️ reaction" },
        react_eyes = { lhs = "<localleader>re", desc = "add/remove 👀 reaction" },
        react_thumbs_up = { lhs = "<localleader>r+", desc = "add/remove 👍 reaction" },
        react_thumbs_down = { lhs = "<localleader>r-", desc = "add/remove 👎 reaction" },
        react_rocket = { lhs = "<localleader>rr", desc = "add/remove 🚀 reaction" },
        react_laugh = { lhs = "<localleader>rl", desc = "add/remove 😄 reaction" },
        react_confused = { lhs = "<localleader>rc", desc = "add/remove 😕 reaction" },
        resolve_thread = { lhs = "<localleader>rt", desc = "resolve PR thread" },
        unresolve_thread = { lhs = "<localleader>rT", desc = "unresolve PR thread" },
      },
      submit_win = {
        approve_review = { lhs = "<C-a>", desc = "approve review", mode = { "n", "i" } },
        comment_review = { lhs = "<C-m>", desc = "comment review", mode = { "n", "i" } },
        request_changes = { lhs = "<C-r>", desc = "request changes review", mode = { "n", "i" } },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab", mode = { "n", "i" } },
      },
      review_diff = {
        submit_review = { lhs = "<localleader>vs", desc = "submit review" },
        discard_review = { lhs = "<localleader>vd", desc = "discard review" },
        add_review_comment = { lhs = "<localleader>ca", desc = "add a new review comment", mode = { "n", "x" } },
        add_review_suggestion = { lhs = "<localleader>sa", desc = "add a new review suggestion", mode = { "n", "x" } },
        focus_files = { lhs = "<localleader>e", desc = "move focus to changed file panel" },
        toggle_files = { lhs = "<localleader>b", desc = "hide/show changed files panel" },
        next_thread = { lhs = "]t", desc = "move to next thread" },
        prev_thread = { lhs = "[t", desc = "move to previous thread" },
        select_next_entry = { lhs = "]q", desc = "move to next changed file" },
        select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
        select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
        select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
        select_next_unviewed_entry = { lhs = "]u", desc = "move to next unviewed changed file" },
        select_prev_unviewed_entry = { lhs = "[u", desc = "move to previous unviewed changed file" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        toggle_viewed = { lhs = "<localleader><space>", desc = "toggle viewer viewed state" },
        goto_file = { lhs = "gf", desc = "go to file" },
      },
      file_panel = {
        submit_review = { lhs = "<localleader>vs", desc = "submit review" },
        discard_review = { lhs = "<localleader>vd", desc = "discard review" },
        next_entry = { lhs = "j", desc = "move to next changed file" },
        prev_entry = { lhs = "k", desc = "move to previous changed file" },
        select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
        refresh_files = { lhs = "R", desc = "refresh changed files panel" },
        focus_files = { lhs = "<localleader>e", desc = "move focus to changed file panel" },
        toggle_files = { lhs = "<localleader>b", desc = "hide/show changed files panel" },
        select_next_entry = { lhs = "]q", desc = "move to next changed file" },
        select_prev_entry = { lhs = "[q", desc = "move to previous changed file" },
        select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
        select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
        select_next_unviewed_entry = { lhs = "]u", desc = "move to next unviewed changed file" },
        select_prev_unviewed_entry = { lhs = "[u", desc = "move to previous unviewed changed file" },
        close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
        toggle_viewed = { lhs = "<localleader><space>", desc = "toggle viewer viewed state" },
      },
      notification = {
        read = { lhs = "<localleader>nr", desc = "mark notification as read" },
        done = { lhs = "<localleader>nd", desc = "mark notification as done" },
        unsubscribe = { lhs = "<localleader>nu", desc = "unsubscribe from notifications" },
      },
      repo = {
        repo_options = { lhs = "<CR>", desc = "show repo options" },
        create_issue = { lhs = "<localleader>ic", desc = "create issue" },
        create_discussion = { lhs = "<localleader>dc", desc = "create discussion" },
        contributing_guidelines = { lhs = "<localleader>cg", desc = "view contributing guidelines" },
        open_in_browser = { lhs = "<C-b>", desc = "open repo in browser" },
      },
      release = {
        open_in_browser = { lhs = "<C-b>", desc = "open release in browser" },
      },
    },
  },
  keys = {
    {
      "<leader>oi",
      "<CMD>Octo issue list<CR>",
      desc = "List GitHub Issues",
    },
    {
      "<leader>op",
      "<CMD>Octo pr list<CR>",
      desc = "List GitHub PullRequests",
    },
    {
      "<leader>od",
      "<CMD>Octo discussion list<CR>",
      desc = "List GitHub Discussions",
    },
    {
      "<leader>on",
      "<CMD>Octo notification list<CR>",
      desc = "List GitHub Notifications",
    },
    {
      "<leader>os",
      function()
        require("octo.utils").create_base_search_command { include_current_repo = true }
      end,
      desc = "Search GitHub",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    -- OR "ibhagwan/fzf-lua",
    -- OR "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons",
  },
},
{
  'chrisbra/csv.vim',
  ft = { 'csv' },
},
{
  'yuratomo/w3m.vim',
  lazy = false,
  priority = 1000
},
{
  'christoomey/vim-tmux-navigator',
  lazy = false,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
},
{
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    anti_conceal = {
      enabled = false,
    },
    heading = {
      enabled = true,
      render_modes = false,
      atx = true,
      setext = true,
      sign = false,
      icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      position = 'inline',
      signs = { '󰫎 ' },
      width = 'block',
      left_margin = 0,
      left_pad = 0,
      right_pad = 0,
      min_width = 0,
      border = false,
      border_virtual = false,
      border_prefix = false,
      above = '▄',
      below = '▀',
      backgrounds = {
        'RenderMarkdownH1Bg',
        'RenderMarkdownH2Bg',
        'RenderMarkdownH3Bg',
        'RenderMarkdownH4Bg',
        'RenderMarkdownH5Bg',
        'RenderMarkdownH6Bg',
      },
      foregrounds = {
        'RenderMarkdownH1',
        'RenderMarkdownH2',
        'RenderMarkdownH3',
        'RenderMarkdownH4',
        'RenderMarkdownH5',
        'RenderMarkdownH6',
      },
      custom = {},
    },

    code = {
      width = 'block',
      left_pad = 1,
      right_pad = 2,
    }
  },
  ft = { 'markdown', 'quarto' },
},
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
},
{
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
},
{
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
    statuscolumn = { },
    toggle = { },
    win = { },
    statuscolumn = { enabled = false },
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
},
}
