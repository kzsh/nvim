-- Successor to the archived simrat39/rust-tools.nvim. Configures the
-- rust-analyzer client itself, so nvim-lspconfig must not also enable
-- 'rust_analyzer' -- two clients would attach to the same buffer.
--
-- It resolves vim.lsp.config['*'] under the name 'rust-analyzer' and deep-merges
-- it over its own defaults, so the blink capabilities set in nvim-lspconfig.lua
-- apply here without being repeated.
return {
  'mrcjkb/rustaceanvim',
  -- v9 requires Neovim >= 0.12; v8 is the last line supporting 0.11
  version = '^8',
  -- Lazy-loads itself as a filetype plugin; lazy.nvim must not defer it.
  lazy = false,
}
