return {
   {
      "folke/tokyonight.nvim",
      lazy = true,
      priority = 1000,
      opts = {
         transparent = true
      },
      config = function ()
         vim.cmd("colorscheme tokyonight-storm")
      end
   },
   { "catppuccin/nvim", lazy = true, name = "catppuccin", priority = 1000 },
   {
     { "EdenEast/nightfox.nvim", lazy=true }
   },

}
