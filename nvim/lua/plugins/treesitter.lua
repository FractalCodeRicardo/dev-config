return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = "true",
    build = ":TSUpdate",
    config = function()

      local treesitter =require("nvim-treesitter")

      treesitter.install {
          "javascript",
          "typescript",
          "json",
          "html",
          "css",
          "c_sharp",
          "rust"
      }

    end,
  }
}

