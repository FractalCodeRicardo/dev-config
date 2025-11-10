return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    enabled = false,
    priority = 1000,
    config = function()
      local tokyo = require("tokyonight")
      tokyo.setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
        on_highlights = function(hl, c)
          hl["@lsp.code.unused"] = { fg = c.comment, italic = true }
        end
      })
      -- vim.cmd.colorscheme("tokyonight")
      -- vim.cmd.colorscheme("tokyonight-night")
      -- vim.cmd.colorscheme("tokyonight-storm")
      -- vim.cmd.colorscheme("tokyonight-moon")
      -- vim.cmd.colorscheme("tokyonight-day")

      -- Transparent background fix
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    end,
  },
  {
    "catppuccin/nvim",
    enabled = true,
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      local catpuccin = require("catppuccin")
      catpuccin.setup({
        flavour = "mocha",
        transparent_background = true
      })
    end
  },
  {
    "EdenEast/nightfox.nvim",
    enabled = true,
    lazy = false,
    config = function()
      local nightfox = require("nightfox");
      nightfox.setup({
        options = {
          transparent = true
        }
      })
    end
  },

  {
    "scottmckendry/cyberdream.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        transparent = true
      });
    end
  },
  -- Using Lazy
  {
    "navarasu/onedark.nvim",
    enabled = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'warmer'
      }
      -- Enable theme
      require('onedark').load()
    end
  },
  {
    'nyngwang/nvimgelion',
    enabled = false,
    config = function()
      -- do whatever you want for further customization~
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    enabled = false,
    config = function()
      local rose = require("rose-pine")
      rose.setup({
        -- disable_background = true,
      })
    end
  },
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    config = function()
      local kanagawa = require("kanagawa");
      kanagawa.setup({
        theme = "wave"
      })
    end
  },
  {
    "cpea2506/one_monokai.nvim",
    enabled = true 
  },
  {
    'sainnhe/gruvbox-material',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true

      -- foreground option can be material, mix, or original
      vim.g.gruvbox_material_foreground = "material"

      --background option can be hard, medium, soft
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_better_performance = 1
      vim.cmd.colorscheme('gruvbox-material')
    end
  },

  {
    "Tsuzat/NeoSolarized.nvim",
    enabled = false,
    lazy = true,     -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
    end
  },
  {
    "daschw/leaf.nvim",
    enabled = true,
    config = function()
      local leaf = require("leaf");

      leaf.setup({
        contrast = "high",
        transparent = false
      })
    end
  },
  {
    "bluz71/vim-moonfly-colors",
    enabled = true,
    name = "moonfly",
    lazy = false,
    priority = 1000
  },

  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    enabled = false,
    config = function()
      local github = require("github-theme");
      github.setup({
        options = {
          transparent = true
        }
      });
    end
  },
  {
    'marko-cerovac/material.nvim',
    config = function()
      local material = require("material")
      material.setup({
        disable = {
          colored_cursor = false, -- Disable the colored cursor
          borders = false,        -- Disable borders between vertically split windows
          background = true,      -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = false,    -- Prevent the theme from setting terminal colors
          eob_lines = false       -- Hide the end-of-buffer lines
        }
      });
      --Lua:
      vim.g.material_style = "deep ocean"
    end
  },

  {
    "dgox16/oldworld.nvim",
    enabled = false,
    config = function()
      require("oldworld").setup({})
    end
  },
  {
    "vague-theme/vague.nvim",
    enabled = false,
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        -- optional configuration here
      })
      vim.cmd("colorscheme vague")
    end
  },
  {
    'Mofiqul/vscode.nvim',
    enabled = false
  },
  {
    'maxmx03/fluoromachine.nvim',
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      local fm = require 'fluoromachine'

      fm.setup {
        glow = true,
        theme = 'retrowave',
        transparent = false,
      }
    end
  },
  {
    "eldritch-theme/eldritch.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {},
  }

}
