return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  config = function()
    local oil = require("oil")
    oil.setup({
      show_hidden = true,
      default_file_explorer = true, -- this replaces netrw but won't auto-open
    })
    vim.api.nvim_set_keymap('n', 'te', ":Oil<CR>", { noremap = true, silent = true })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        vim.opt_local.number = true         -- show absolute number
        vim.opt_local.relativenumber = true -- enable relative numbers
      end,
    })
  end
}
