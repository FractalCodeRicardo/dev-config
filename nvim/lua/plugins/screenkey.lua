return {
  "NStefan002/screenkey.nvim",
  lazy = false,
  version = "*",   -- or branch = "main", to use the latest commit
  config = function()
    local screenkey = require("screenkey")
    screenkey.setup({
      win_opts = {
        col = 120,
        row = 35   
      }
    })
  end
  }












