return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local theme = require('lualine.themes.auto')

    require("lualine").setup({
      options = {
        theme = "palenight",
        -- component_separators = '',
        -- section_separators = { left = '', right = '' },
      },
    }
  )
  end
}
