return {
  "NvChad/nvim-colorizer.lua",
  enabled = false,
  config = function ()
    vim.opt.termguicolors = true
    require("colorizer").setup()
  end
  }

