-- return {
--    'navarasu/onedark.nvim',
--    opts = {
--       style = "darker"
--
--    }
-- }
return {
   {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {
         transparent = true
      },
   },
   { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
   {
      'ful1e5/onedark.nvim',
      config = function()
         -- Example config in Lua
         require("onedark").setup({
            function_style = "italic",
            sidebars = { "qf", "vista_kind", "terminal", "packer" },

            colors = { hint = "orange0", error = "#ff0000" },

            overrides = function(c)
               return {
                  htmlTag = { fg = c.red0, bg = "#282c34", sp = c.hint, style = "underline" },
                  DiagnosticHint = { link = "LspDiagnosticsDefaultHint" },
                  -- this will remove the highlight groups
                  TSField = {},
               }
            end
         })
      end
   },
   {
      "cpea2506/one_monokai.nvim",
   },
   {
      "rebelot/kanagawa.nvim",
      opts = {
         theme = "wave"
      }
   }


}
