return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-mini/mini.nvim'
  },   -- if you use the mini.nvim suite
  config = function ()
    require("render-markdown").setup({})

  end


}
