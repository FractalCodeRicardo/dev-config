return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      {
        '<C-p>',
        function()
          require('telescope.builtin').find_files()
        end,
        { desc = 'Find Files' }
      },

      {
        '<C-f>',
        function()
          require('telescope.builtin').live_grep()
        end,
        { desc = 'Find Grep' }
      },

      {
        '<C-e>',
        function()
          require('telescope.builtin').diagnostics({
            severity = { min = vim.diagnostic.severity.WARN },    -- WARN and ERROR only
          })
        end,
        { desc = 'Find Grep' }
      },
    }
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "andrew-george/telescope-themes",
    config = function()
      require("telescope").load_extension("themes")
    end,
  },
}
