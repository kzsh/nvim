return {
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    { "mason-org/mason-lspconfig.nvim",
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
      opts = {},
    },
  },
  config = function()
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
}
