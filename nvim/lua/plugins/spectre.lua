return {
  enabled = true,
  "nvim-pack/nvim-spectre",
  lazy = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("spectre").setup({})
  end
}
