return {
  'stevearc/conform.nvim',
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        html = { "prettier" },
      },
    })

    vim.keymap.set("n", "ff", function ()
     conform.format()
    end, {})
  end
}
