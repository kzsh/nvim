--==========================================================
-- Load Lazy.nvim plugins
--==========================================================

local cwd = function () return vim.fn.expand('%:p:h') end
local git_root_dir = function ()
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
    {'<leader>go', ':Goyo<CR>'},
  },
},
{
  -- Generalized text aligner
  'junegunn/vim-easy-align',
  keys = {
    {'ga', '<Plug>(EasyAlign)', ft = 'markdown', mode = 'x'},
    {'ga', '<Plug>(EasyAlign)', ft = 'markdown'},
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
  ft = {'gitconfig', 'gituser', 'gitignore_global'}
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
},
'tpope/vim-unimpaired',
{
  'tpope/vim-classpath',
  ft = {'clojure'},
},
{
  'tpope/vim-fireplace',
  ft = {'clojure'}
},
{
  'tpope/vim-cucumber',
  ft = {'cucumber'}
},
{
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-treesitter/nvim-treesitter-textobjects',
    }
},
{
  'cespare/vim-toml',
    branch = 'main',
    ft = {'toml'},
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
    require'nvim-treesitter.configs'.setup {
        highlight = {
            enable = true,
        },

        incremental_selection = {
            enable = false,
        },
        endwise = {
            enable = true,
        },
        additional_vim_regex_highlighting = {'vimscript', 'gitcommit', 'gitrebase'},

        playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
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
              ['@function.outer'] = 'V', -- linewise
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
  ft = {'tex'},
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
  ft = {'cypher'}
},
{
  'jimmyhchan/dustjs.vim',
  ft = {'dustjs', 'dust'}
},
{
  'mustache/vim-mustache-handlebars',
  ft = {'handlebars'}
},
{
  'jparise/vim-graphql',
  ft = {'graphql'}
},
{
  'towolf/vim-helm',
  ft = {'helm', 'yaml'}
},
{
  'udalov/kotlin-vim',
  ft = {'kotlin'}
},
{
  'dkarter/bullets.vim',
  ft = {'markdown'}
},
{
  'jeetsukumaran/vim-pursuit',
  branch = 'main',
  ft = {'markdown'},
},
{
  'plasticboy/vim-markdown',
  enabled = false,
  ft = {'markdown'},
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
  ft = {'plist'}
},
{
  'noprompt/vim-yardoc',
  ft = {'ruby'}
},
{
  'rust-lang/rust.vim',
  ft = {'rust'}
},
{
  'lifepillar/pgsql.vim',
  ft = {'sql'}
},
{
  'mitsuse/autocomplete-swift',
  ft = {'swift'}
},
{
  'cespare/vim-toml',
  ft = {'toml'}
},
{
  'rhysd/reply.vim',
  ft = {'Repl', 'ReplAuto', 'ReplSend'}
},
{
  'simrat39/rust-tools.nvim',
  ft = {'rust'},
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
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')
    -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

    lspconfig.bashls.setup({
      capabilities = capabilities
    })

    -- lspconfig.clangd.setup({
    --   format_on_save = false,
    --   on_attach = function(client, bufnr)
    --     client.server_capabilities.signatureHelpProvider = false
    --     on_attach(client, bufnr)
    --   end,
    --   capabilities = capabilities,
    -- })

    -- lspconfig.cssls.setup({
    --   capabilities = capabilities
    -- })

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities
    })

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities
    })

    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      format = false,
    })

    -- lspconfig.cssmodules_ls.setup({
    --   capabilities = capabilities
    -- })

    -- lspconfig.stylelint_lsp.setup({
    --   capabilities = capabilities,
    --   filetypes = {'css', 'less', 'scss'}
    -- })

    lspconfig.jdtls.setup({
      capabilities = capabilities,
      code_actions = {
        enable = true,
        apply_on_save = {
          enable = true,
          types = { "directive", "problem", "suggestion", "layout" },
        },
        disable_rule_comment = {
          enable = true,
          location = "separate_line", -- or `same_line`
        },
      },
      diagnostics = {
        enable = true,
        report_unused_disable_directives = false,
        run_on = "save", -- or `type`
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(ev)
        vim.lsp.buf.format({
          filter = function(client) return client.name ~= "ts_ls" end
        })
      end
    })

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
  dependencies = {
    'jose-elias-alvarez/null-ls.nvim',
    'jose-elias-alvarez/typescript.nvim',
    'mfussenegger/nvim-jdtls',
    'iamcco/diagnostic-languageserver',
  }
},
-- {
--   'codota/tabnine-nvim',
--   build: './dl_binaries.sh',
-- },
{
  'dense-analysis/neural',
  event = 'VeryLazy',
  cmd = 'Neural',
  config = function()
    require('neural').setup({
      selected = 'chatgpt',
      source = {
        openai = {
          api_key = vim.env.OPENAI_API_KEY,
        },
        -- chatgpt = {
        --   api_key = vim.env.OPENAI_API_KEY,
        -- },
      },
    })
  end,
  dependencies = {
    'muniftanjim/nui.nvim',
    'elpiloto/significant.nvim',
  }
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
    enabled = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
  'Tsuzat/NeoSolarized.nvim',
    enabled = false,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[
      colorscheme NeoSolarized
      highlight OctoEditable guibg=#1a1a26
      highlight OctoGreyFloat guifg=#2a354c guibg=#1a1a26
      highlight OctoBlueFloat guifg=#58a6ff guibg=#1a1a26
      highlight OctoYellowFloat guifg=#d3c846 guibg=#1a1a26
      highlight OctoPurpleFloat guifg=#6f42c1 guibg=#1a1a26
      highlight OctoRedFloat guifg=#da3633 guibg=#1a1a26
      highlight OctoGreenFloat guifg=#238636 guibg=#1a1a26
      " let g:neosolarized_contrast = "normal"
      " let g:neosolarized_visibility = "normal"
      ]])
    end,
  },
  {
  'morhetz/gruvbox',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    enabled = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    'NLKNguyen/papercolor-theme',
    enabled = false,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme PaperColor ]])
    end,
  },
  {
    "williamboman/mason.nvim",
    init = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
    opts = {
      ensure_installed = {
        "bash-language-server",
        "bashls",
        -- "clangd",
        "css-lsp",
        "cssls",
        "cssmodules-language-server",
        "cssmodules_ls",
        "java-language-server",
        "java_language_server",
        "stylelint",
        "stylelint-lsp",
        "stylelint_lsp",
        "typescript-language-server",
        "tsserver",
      }
    },
    priority = 900, -- make sure to load this before all the other start plugins
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    }
  },
  -- 'kyazdani42/nvim-web-devicons',
  {
    enabled = false,
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- 'kyazdani42/nvim-web-devicons',
    },
    init = function()
      require"octo".setup({
        default_remote = {"origin"}; -- order to try remotes
        ssh_aliases = {},                        -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
        reaction_viewer_hint_icon = "";         -- marker for user reactions
        user_icon = " ";                        -- user icon
        timeline_marker = "";                   -- timeline marker
        timeline_indent = "2";                   -- timeline indentation
        right_bubble_delimiter = "]";            -- bubble delimiter (from example: )
        left_bubble_delimiter = "[";             -- bubble delimiter (from example: )
        github_hostname = "";                    -- GitHub Enterprise host
        snippet_context_lines = 4;               -- number or lines around commented lines
        gh_env = {},                             -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
        timeout = 5000,                          -- timeout for requests between the remote server
        ui = {
          use_signcolumn = true,                 -- show "modified" marks on the sign column
        },
        issues = {
          order_by = {                           -- criteria to sort results of `Octo issue list`
            field = "CREATED_AT",                -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
            direction = "DESC"                   -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
          }
        },
        pull_requests = {
          order_by = {                           -- criteria to sort the results of `Octo pr list`
            field = "CREATED_AT",                -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
            direction = "DESC"                   -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
          },
          always_select_remote_on_create = false -- always give prompt to select base remote repo when creating PRs
        },
        file_panel = {
          size = 10,                             -- changed files panel rows
          use_icons = false                       -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
        },
        mappings = {
        -- issue = {
        --   close_issue = { lhs = "<leader>ic", desc = "close issue" },
        --   reopen_issue = { lhs = "<leader>io", desc = "reopen issue" },
        --   list_issues = { lhs = "<leader>il", desc = "list open issues on same repo" },
        --   reload = { lhs = "<C-r>", desc = "reload issue" },
        --   open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
        --   copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
        --   add_assignee = { lhs = "<leader>aa", desc = "add assignee" },
        --   remove_assignee = { lhs = "<leader>ad", desc = "remove assignee" },
        --   create_label = { lhs = "<leader>lc", desc = "create label" },
        --   add_label = { lhs = "<leader>la", desc = "add label" },
        --   remove_label = { lhs = "<leader>ld", desc = "remove label" },
        --   goto_issue = { lhs = "<leader>gi", desc = "navigate to a local repo issue" },
        --   add_comment = { lhs = "<leader>ca", desc = "add comment" },
        --   delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
        --   next_comment = { lhs = "]c", desc = "go to next comment" },
        --   prev_comment = { lhs = "[c", desc = "go to previous comment" },
        --   react_hooray = { lhs = "<leader>rp", desc = "add/remove 🎉 reaction" },
        --   react_heart = { lhs = "<leader>rh", desc = "add/remove ❤️ reaction" },
        --   react_eyes = { lhs = "<leader>re", desc = "add/remove 👀 reaction" },
        --   react_thumbs_up = { lhs = "<leader>r+", desc = "add/remove 👍 reaction" },
        --   react_thumbs_down = { lhs = "<leader>r-", desc = "add/remove 👎 reaction" },
        --   react_rocket = { lhs = "<leader>rr", desc = "add/remove 🚀 reaction" },
        --   react_laugh = { lhs = "<leader>rl", desc = "add/remove 😄 reaction" },
        --   react_confused = { lhs = "<leader>rc", desc = "add/remove 😕 reaction" },
        -- },
          pull_request = {
            checkout_pr = { lhs = "<leader>gco", desc = "checkout PR" },
            -- merge_pr = { lhs = "<leader>pm", desc = "merge commit PR" },
            -- squash_and_merge_pr = { lhs = "<leader>psm", desc = "squash and merge PR" },
            list_commits = { lhs = "<leader>li", desc = "list PR commits" },
            list_changed_files = { lhs = "<leader>lf", desc = "list PR changed files" },
            show_pr_diff = { lhs = "<leader>di", desc = "show PR diff" },
            -- add_reviewer = { lhs = "<leader>va", desc = "add reviewer" },
            -- remove_reviewer = { lhs = "<leader>vd", desc = "remove reviewer request" },
            -- close_issue = { lhs = "<leader>ic", desc = "close PR" },
            -- reopen_issue = { lhs = "<leader>io", desc = "reopen PR" },
            -- list_issues = { lhs = "<leader>il", desc = "list open issues on same repo" },
            reload = { lhs = "<C-r>", desc = "reload PR" },
            open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
            -- copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
            goto_file = { lhs = "gf", desc = "go to file" },
            -- add_assignee = { lhs = "<leader>aa", desc = "add assignee" },
            -- remove_assignee = { lhs = "<leader>ad", desc = "remove assignee" },
            -- create_label = { lhs = "<leader>lc", desc = "create label" },
            -- add_label = { lhs = "<leader>la", desc = "add label" },
            -- remove_label = { lhs = "<leader>ld", desc = "remove label" },
            -- goto_issue = { lhs = "<leader>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<leader>ca", desc = "add comment" },
            delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            -- react_hooray = { lhs = "<leader>rp", desc = "add/remove 🎉 reaction" },
            -- react_heart = { lhs = "<leader>rh", desc = "add/remove ❤️ reaction" },
            -- react_eyes = { lhs = "<leader>re", desc = "add/remove 👀 reaction" },
            -- react_thumbs_up = { lhs = "<leader>r+", desc = "add/remove 👍 reaction" },
            -- react_thumbs_down = { lhs = "<leader>r-", desc = "add/remove 👎 reaction" },
            -- react_rocket = { lhs = "<leader>rr", desc = "add/remove 🚀 reaction" },
            -- react_laugh = { lhs = "<leader>rl", desc = "add/remove 😄 reaction" },
            -- react_confused = { lhs = "<leader>rc", desc = "add/remove 😕 reaction" },
          },
          review_thread = {
            goto_issue = { lhs = "<leader>gi", desc = "navigate to a local repo issue" },
            add_comment = { lhs = "<leader>ca", desc = "add comment" },
            add_suggestion = { lhs = "<leader>sa", desc = "add suggestion" },
            delete_comment = { lhs = "<leader>cd", desc = "delete comment" },
            next_comment = { lhs = "]c", desc = "go to next comment" },
            prev_comment = { lhs = "[c", desc = "go to previous comment" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            -- react_hooray = { lhs = "<leader>rp", desc = "add/remove 🎉 reaction" },
            -- react_heart = { lhs = "<leader>rh", desc = "add/remove ❤️ reaction" },
            -- react_eyes = { lhs = "<leader>re", desc = "add/remove 👀 reaction" },
            -- react_thumbs_up = { lhs = "<leader>r+", desc = "add/remove 👍 reaction" },
            -- react_thumbs_down = { lhs = "<leader>r-", desc = "add/remove 👎 reaction" },
            -- react_rocket = { lhs = "<leader>rr", desc = "add/remove 🚀 reaction" },
            -- react_laugh = { lhs = "<leader>rl", desc = "add/remove 😄 reaction" },
            -- react_confused = { lhs = "<leader>rc", desc = "add/remove 😕 reaction" },
          },
          submit_win = {
            approve_review = { lhs = "<C-a>", desc = "approve review" },
            comment_review = { lhs = "<C-m>", desc = "comment review" },
            request_changes = { lhs = "<C-r>", desc = "request changes review" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
          },
          review_diff = {
            add_review_comment = { lhs = "<leader>ca", desc = "add a new review comment" },
            add_review_suggestion = { lhs = "<leader>sa", desc = "add a new review suggestion" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            next_thread = { lhs = "]t", desc = "move to next thread" },
            prev_thread = { lhs = "[t", desc = "move to previous thread" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<leader><leader>", desc = "toggle viewer viewed state" },
          },
          file_panel = {
            next_entry = { lhs = "j", desc = "move to next changed file" },
            prev_entry = { lhs = "k", desc = "move to previous changed file" },
            select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
            refresh_files = { lhs = "R", desc = "refresh changed files panel" },
            focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
            toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
            select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
            select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
            close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            toggle_viewed = { lhs = "<leader><leader>", desc = "toggle viewer viewed state" },
          }
        }
      })
    end,
  },
  {
    'chrisbra/csv.vim',
    ft = {'csv'},
  }
}
