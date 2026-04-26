return {
  enabled = true,
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    require('mini.animate').setup()
  end
}
