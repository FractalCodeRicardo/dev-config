return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = "true",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "javascript",
          "typescript",
          "json",
          "html",
          "css",
          "c_sharp",
          "rust"
        },
        highlight = {
          enable = true,
        },
      })
    end,
  }
}

