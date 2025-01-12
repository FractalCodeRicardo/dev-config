--return {
--   'navarasu/onedark.nvim'
--}
return {
   {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
   },
   { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
   {
      'ful1e5/onedark.nvim',
      config = function()
         -- Example config in Lua
         require("onedark").setup({
            function_style = "italic",
            sidebars = { "qf", "vista_kind", "terminal", "packer" },

            -- Change the "hint" color to the "orange0" color, and make the "error" color bright red
            colors = { hint = "orange0", error = "#ff0000" },

            -- Overwrite the highlight groups
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
   }


}
