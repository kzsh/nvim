--==========================================================
-- Load Lazy.nvim plugins
--==========================================================

return {
'lewis6991/impatient.nvim',
-- {
--   'elihunter173/dirbuf.nvim'
-- }
{
  enabled = false,
  'ojroques/nvim-bufdel',
  cmd = 'BufDel',
},
-- {
--   'folke/which-key.nvim',
--   opts = {},
--   event = 'BufReadPost',
-- },
'mattn/webapi-vim',
{
  'kevinhwang91/nvim-bqf',
  dependencies = {
    'junegunn/fzf',
  },
},
{
  'numToStr/Comment.nvim',
  init = function()
    require('Comment').setup()
  end,
  event = 'VeryLazy',
},
-- {
--  'andymass/vim-matchup',
--  init = function()
--    -- vim.g.matchup_matchparen_offscreen = { method = "popup" }
--  end,
--  event = 'VeryLazy',
-- },
{
  'romainl/vim-cool',
  enabled = false,
  event = 'VeryLazy'
},
{ 'wellle/targets.vim', event = 'VeryLazy' },
{
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
  },
    init = function()
      local telescope = require('telescope')
      telescope.setup({
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
          }
        },
      })
      telescope.load_extension('fzf')

      local cwd = function () return vim.fn.expand('%:p:h') end
      local git_root_dir = function ()
        return vim.fn.systemlist("git rev-parse --show-toplevel")[1]
      end

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>;f', builtin.find_files, {})
      vim.keymap.set('n', '<leader>;F', function() builtin.find_files({ cwd = cwd() }) end, {})
      vim.keymap.set('n', '<leader>;af', function() builtin.find_files({ cwd = git_root_dir() }) end, {})
      vim.keymap.set('n', '<leader>;hf', function() builtin.find_files({ hidden = true, cwd = git_root_dir() }) end, {})
      vim.keymap.set('n', '<leader>ff', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>af', function() builtin.live_grep({ cwd = git_root_dir() }) end, {})
      vim.keymap.set('n', '<leader>FF', function() builtin.live_grep({ cwd = cwd() }) end, {})
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, {})
      vim.keymap.set('n', '<leader>;;', builtin.buffers, {})
      vim.keymap.set('n', '<leader>;h', builtin.help_tags, {})
    end,
    cmd = 'Telescope',
},
{
  'nvim-telescope/telescope-fzf-native.nvim',
  build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
},
{
    'hrsh7th/nvim-cmp',
    dependencies = {
      'dcampos/cmp-snippy',
      'doxnit/cmp-luasnip-choice',
      'hrsh7th/cmp-buffer',
      -- 'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/vim-vsnip',
      -- 'lukas-reineke/cmp-under-comparator',
      -- 'onsails/lspkind.nvim',
    },
    init = function()
      local cmp = require('cmp')
      cmp.setup({
        -- ignore LSP attempts to make a selection in advance of the user
        preselect = cmp.PreselectMode.None,
        confirmation = {
         completeopt = 'longest,menuone,preview,noselect'
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.config.disable,
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-e>"] = cmp.mapping.abort(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          -- ['<Tab>'] = cmp.config.disable,--{
          --     -- i = ...,
          --     c = cmp.config.disable
          -- },
          -- ['<C-Space>'] = cmp.mapping.complete(),
          -- ['<C-e>'] = cmp.mapping.abort(),
          -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'under_comparator' },
          { name = 'nvim_lsp', keyword_length = 2 },      -- from language server
          { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
          { name = 'path' },                              -- file paths
          { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
          { name = 'buffer', keyword_length = 2 },        -- source current buffer
          { name = 'calc'},
          { name = 'cmdline' },
        }),
        -- window = {
        --   completion = cmp.config.window.bordered(),
        --   documentation = cmp.config.window.bordered(),
        -- },
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })
    end,
    event = 'InsertEnter',
},
{
  'lewis6991/hover.nvim',
  event = 'BufReadPost',
  config = function()
    require('hover').setup {
      init = function()
        require 'hover.providers.lsp'
      end,
    }

    vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
    vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' })
  end,
},

-- Show +/-/~ in the gutter
{
  'lewis6991/gitsigns.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = true,
  event = 'VeryLazy',
},
-- 'airblade/vim-gitgutter',

-- Add :ConvertColorTo to convert css colors
'amadeus/vim-convert-color-to',

--Per directory vim-config
'chazy/dirsettings',

-- General purpose linter
-- {
--   'dense-analysis/ale',
--   config = true
-- },

-- Create missing directories when editing file paths that don't exist
{
  'duggiefresh/vim-easydir',
  event = 'VeryLazy',
},

'editorconfig/editorconfig-vim',

-- Experimental in-line images in vim (not used)
-- 'edluffy/hologram.nvim',

-- Syntax highlighting - replaced by treesitter syntax highlighting
-- 'ianks/vim-tsx',

-- Execute ripgrep in vim (supports, custom <Leader>ff)
-- 'jremmen/vim-ripgrep',

-- Support many traversal behaviors
-- 'junegunn/fzf.vim',
{
  'junegunn/fzf',
  build = ":call fzf#install()"
},

-- Distraction-free vim config -- often used in presentation
{
  'junegunn/goyo.vim',

  init = function()
    vim.cmd([[
      function! s:goyo_enter()
        setlocal linebreak wrap
      endfunction

      function! s:goyo_leave()
        setlocal nolinebreak nowrap
      endfunction

      autocmd! User GoyoEnter nested call <SID>goyo_enter()
      autocmd! User GoyoLeave nested call <SID>goyo_leave()
    ]])
  end,
  cmd = 'Goyo',
},
{
  -- Generalized text aligner
  'junegunn/vim-easy-align',
  init = function()
    vim.cmd([[
    "==========================================================
    " EasyAlign config
    "==========================================================
    augroup TableFormatting
      au FileType markdown vmap <Leader><Bar> :EasyAlign*<Bar><Enter>
      " Start interactive EasyAlign in visual mode (e.g. vipga)
      xmap ga <Plug>(EasyAlign)

      " Start interactive EasyAlign for a motion/text object (e.g. gaip)
      nmap ga <Plug>(EasyAlign)
    augroup END
    ]])
  end,
  event = 'VeryLazy',
},

-- Display marks in gutter (does more, but I don't use that)
'kshenoy/vim-signature',

-- Display binary in a hexdump format
'mattn/vim-xxdcursor',

'brenoprata10/nvim-highlight-colors',
'teal-language/vim-teal',
{
  'b0o/incline.nvim',
  opts = {
    hide = {
      cursorline = true,
      focused_win = false,
      only_win = false
    },
  },
  event = 'VeryLazy',
},
-- {
--   'ethanholz/nvim-lastplace',
--   config = function()
--     require('nvim-lastplace').setup {}
--     vim.api.nvim_exec_autocmds('BufWinEnter', { group = 'NvimLastplace' })
--   end,
--   event = 'User ActuallyEditing',
-- },

-- define and store snippets
{
  'dcampos/nvim-snippy',
  init = function()
    require('snippy').setup({
      mappings = {
        is = {
          ['<Tab>'] = 'expand_or_advance',
          ['<S-Tab>'] = 'previous',
        },
        -- nx = {
        --   ['<leader>x'] = 'cut_text',
        -- },
      },
    })
  end
},
-- {
--   'sirver/ultisnips',
--   config = function()
--     vim.cmd([[
--       "==========================================================
--       " ultisnips
--       "==========================================================
--       let g:UltiSnipsUsePythonVersion = 3
--       let g:UltiSnipsExpandTrigger = '<tab>'
--       " let g:UltiSnipsJumpForwardTrigger = '<tab>'
--       " let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
--
--       " shortcut to go to next position
--       let g:UltiSnipsJumpForwardTrigger='<c-s-j>'
--
--       " shortcut to go to previous position
--       let g:UltiSnipsJumpBackwardTrigger='<c-s-k>'
--       let g:UltiSnipsSnippetDirectories=["ulti-snippets"]
--
--     ]])
--
--   end
-- },

-- The TPope corner
{
  'tpope/vim-abolish',
  event = 'BufRead',
  init = function()
    -- vim.cmd([[nmap cr  <Plug>(abolish-coerce-word)]])
  end
},
'tpope/vim-commentary',
'tpope/vim-dadbod',
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
  'kevinhwang91/nvim-bqf',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  ft = {'qf'}
},
{
  'tpope/vim-repeat',
  event = 'BufRead',
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
      'RRethy/nvim-treesitter-textsubjects',
    }
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
-- {
--   'codota/tabnine-nvim',
--   build: './dl_binaries.sh',
-- }
-- {
--   'Shougo/vimproc.vim',
--   build = 'make'
-- },
{
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'RRethy/nvim-treesitter-textsubjects',
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
        additional_vim_regex_highlighting = {'vimscript', 'gitcommit', 'gitrebase'},
      },

      incremental_selection = {
        enable = false,
      },
      ident = { enable = true },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
      },
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
        "markdown",
        "markdown_inline",
      },
    }
  end
},
'nvim-treesitter/playground',
{
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
},
'folke/neodev.nvim',
{
  'lervag/vimtex',
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
  end,
  -- ft = { 'tex' },
  lazy = false,
},
'barreiroleo/ltex_extra.nvim',
{
  'dstein64/vim-startuptime',
  cmd = 'StartupTime',
  init = function()
    vim.g.startuptime_tries = 15
  end,
},

-- Support for avro syntax
{
  'dln/avro-vim',
  ft = {'avdl'}
},

--Clojure
{
  'guns/vim-clojure-static',
  ft = {'clojure'}
},
{
  'kien/rainbow_parentheses.vim',
  ft = {'clojure'}
},

{
  'godlygeek/tabular',
  ft = {'cucumber'}
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
  'tpope/vim-git',
  ft = {'gitconfig', 'gituser', 'gitignore_global'}
},
{
  'jparise/vim-graphql',
  ft = {'graphql'}
},
{
  'mustache/vim-mustache-handlebars',
  ft = {'handlebars'}
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
  'jghauser/follow-md-links.nvim',
  ft = {'markdown'},
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  }
},
{
  'darfink/vim-plist',
  ft = {'plist'}
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
  'lervag/vimtex',
  ft = {'tex'}
},
{
  'cespare/vim-toml',
  branch = 'main',
  ft = {'toml'}
},
{
  enabled = false,
  'Vigemus/iron.nvim',
  config = function()
    local iron = require("iron.core")

    iron.setup({
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          sh = {
            -- Can be a table or a function that
            -- returns a table (see below)
            command = {"bash"}
          },
          javascript = {
            command = function(meta)
              local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
              return { 'node', filename}
            end
          }
        },
        -- How the repl window will be displayed
        -- See below for more information
        repl_open_cmd = require('iron.view').right(40),
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_until_cursor = "<space>su",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    })

    -- iron also has a list of commands, see :h iron-commands for all available commands
    vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
    vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
    vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
    vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
end
},
{
  'simrat39/rust-tools.nvim',
  ft = {'rust'},
  config = function()
    local rt = require("rust-tools")
    rt.setup({
      server = {
        on_attach = function(_, bufnr)
          -- Hover actions
          vim.keymap.set("n", "<S-k>", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
      },
    })
  end
},
{
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    lspconfig.bashls.setup({
      capabilities = capabilities
    })

    lspconfig.cssls.setup({
      capabilities = capabilities
    })
    lspconfig.cssmodules_ls.setup({
      capabilities = capabilities
    })
    lspconfig.tsserver.setup({
      capabilities = capabilities
    })
    lspconfig.svelte.setup ({
      capabilities = capabilities
    })
    lspconfig.eslint.setup({
      capabilities = capabilities
    })

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      check = {
        command = "clippy";
      },
      diagnostics = {
        enable = true;
      }
    })

    vim.api.nvim_create_autocmd({"BufWritePre"}, {
      callback = function(ev)
        vim.lsp.buf.format()
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
          vim.lsp.buf.format { async = false }
        end, opts)
      end,
    })
  end,
  dependencies = {
    -- 'jose-elias-alvarez/null-ls.nvim',
    -- 'jose-elias-alvarez/typescript.nvim',
    'mfussenegger/nvim-jdtls',
    'iamcco/diagnostic-languageserver',
  }
},
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
        chatgpt = {
          api_key = vim.env.OPENAI_API_KEY,
        },
      },
    })
  end,
  dependencies = {
    'muniftanjim/nui.nvim',
    'elpiloto/significant.nvim',
  }
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
      require("mason").setup({
        PATH = "prepend", -- "skip" seems to cause the spawning error
      })
      require("mason-lspconfig").setup()
    end,
    priority = 900, -- make sure to load this before all the other start plugins
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    }
  },
  -- 'kyazdani42/nvim-web-devicons',
  {
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
    'github/copilot.vim',
    enabled = false,
    cmd = 'Copilot',

  },
  {
    'Shatur/neovim-tasks',
    dependencies = {
      'nvim-lua/plenary.nvim',
    }
  },
  {
    'chrisbra/csv.vim',
     event = "BufRead",
     ft = {'csv'}
  }
}
