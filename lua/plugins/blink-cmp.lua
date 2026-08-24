return {
  'saghen/blink.cmp',
  version = '1.*', -- tags ship the prebuilt Rust fuzzy matcher; branches require cargo
  -- nvim-lspconfig pulls capabilities from here at startup, so lazy-loading buys nothing
  lazy = false,
  opts = {
    -- C-y accepts, C-n/C-p select, C-space shows menu then docs
    keymap = {
      preset = 'default',
      ['<C-k>'] = false, -- keep insert-mode digraphs
      ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    appearance = { nerd_font_variant = 'mono' },

    signature = { enabled = true },

    completion = {
      -- matches completeopt=noselect: nothing is chosen until you say so
      list = { selection = { preselect = false, auto_insert = false } },
      documentation = { auto_show = true, auto_show_delay_ms = 250 },
      menu = { border = 'rounded' },
      -- appends () to accepted functions, using semantic tokens to avoid
      -- doing so where the name is used as a value
      accept = { auto_brackets = { enabled = true } },
    },

    sources = {
      -- no `buffer`: word-scraped completions match any token in any visible
      -- buffer, including prose in comments. `lsp.fallbacks` defaults to
      -- { 'buffer' }, but a fallback to a provider absent from this list is
      -- dropped when the source tree is built, so omission is enough.
      default = { 'lsp', 'path' },
      per_filetype = {
        lua = { inherit_defaults = true, 'lazydev' },
      },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },

    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
