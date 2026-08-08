local cwd = function() return vim.fn.expand('%:p:h') end
local git_root_dir = function()
  return vim.fn.systemlist("git rev-parse --show-toplevel")[1]
end

return {
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
      { '<leader>;f', function() require('telescope.builtin').find_files() end },
      { '<leader>;F', function()
        require('telescope.builtin').find_files({ cwd = cwd() })
      end },
      { '<leader>;af', function()
        require('telescope.builtin').find_files({ cwd = git_root_dir() })
      end },
      { '<leader>af', function()
        require('telescope.builtin').live_grep({ cwd = git_root_dir() })
      end },
      { '<leader>ff', require('telescope.builtin').live_grep },
      { '<leader>FF', function()
        require('telescope.builtin').live_grep({ cwd = cwd() })
      end },
      { '<leader>fw', require('telescope.builtin').grep_string },
      { '<leader>;;', require('telescope.builtin').buffers },
      { '<leader>;h', require('telescope.builtin').help_tags },
    },
    cmd = 'Telescope',
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true, -- Only load when Telescope is called
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
}
