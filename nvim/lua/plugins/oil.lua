return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  config = function()
    local oil = require("oil")
    oil.setup({
      show_hidden = true,
      default_file_explorer = true,
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
