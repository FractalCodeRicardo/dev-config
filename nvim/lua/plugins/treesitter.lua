return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "javascript",
          "typescript",
          "json",
          "html",
          "css",
          "c_sharp"
        },
        highlight = {
          enable = true,
        },
      })
    end,
  }
}

