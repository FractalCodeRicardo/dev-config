return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
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
    enabled = false,
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
    enabled = false,
    lazy = false,
    config = function()
      local nightfox = require("nightfox");
      nightfox.setup({
        options = {
          transparent = false
        }
      })

      vim.cmd("colorscheme duskfox")
    end
  },

  {
    "scottmckendry/cyberdream.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        variant = "dark",
        transparent = false
      });

      vim.cmd("colorscheme cyberdream")
    end
  },
  -- Using Lazy
  {
    "navarasu/onedark.nvim",
    enabled = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'deep'
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
        variant = "dawn",
        styles = {
          transparency = true
        }
      })
    end
  },
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    config = function()
      local kanagawa = require("kanagawa");
      kanagawa.setup({
        -- theme = "wave",
        transparent = true
      })

      vim.o.background = "dark"
    end
  },
  {
    "cpea2506/one_monokai.nvim",
    enabled = false
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
      vim.o.background = "dark"
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

      vim.cmd("colorscheme leaf")
    end
  },
  {
    "bluz71/vim-moonfly-colors",
    enabled = false,
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd("colorscheme moonfly")
    end
  },


  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    enabled = false,
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
        options = {
          transparent = true
        }
      })
    end,
  },
  {
    'marko-cerovac/material.nvim',
    enabled = false,
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
      vim.g.material_style = "lighter"
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
      require("vague").setup({
        -- optional configuration here
      })
      vim.cmd("colorscheme vague")
    end
  },
  {
    'Mofiqul/vscode.nvim',
    enabled = false,
    config = function()
      local vscode = require("vscode");
      vscode.setup();
      vim.o.background = "light"
    end
  },
  {
    'maxmx03/fluoromachine.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    enabled = false,
    config = function()
      local fm = require 'fluoromachine'

      fm.setup {
        glow = true,
        theme = 'retrowave',
        transparent = true,
      }
    end
  },
  {
    "eldritch-theme/eldritch.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      local eldritch = require("eldritch");

      eldritch.setup({
        transparent = false
      })

      vim.cmd("colorscheme eldritch")
    end
  },
  {
    "tiagovla/tokyodark.nvim",
    enabled = false,
    opts = {
      -- custom options here
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- calling setup is optional

     vim.cmd("colorscheme tokyodark")
    end,
  },
  {
    "bluz71/vim-nightfly-colors",
    enabled = false,
    name = "nightfly",
    lazy = false,
    priority = 1000,
    config = function ()
     vim.cmd("colorscheme nightfly")
    end
  },
  {
    "samharju/synthweave.nvim",
    enabled = false,
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme("synthweave")
      -- transparent version
      -- vim.cmd.colorscheme("synthweave-transparent")
    end
  },

  {
    "neanias/everforest-nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
      })
      vim.o.background = "light";
    end,
  },
  {
    "olimorris/onedarkpro.nvim",
    enabled = false,
    priority = 1000, -- Ensure it loads first
  },
  {
    "Mofiqul/dracula.nvim",
    enabled = false
  },
  {
    "shaunsingh/nord.nvim",
    enabled = false
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    enabled = false,
  },
  {
    "sainnhe/sonokai",
    enabled = false,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'AlexvZyl/nordic.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require('nordic').load()
    end
  },
  {
    'sainnhe/edge',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.edge_enable_italic = true
      vim.o.background = "light"
    end
  },
  {
    "savq/melange-nvim",
    enabled = false,
  },
  -- Using lazy.nvim
  {
    'ribru17/bamboo.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
        transparent = true
      }
      require('bamboo').load()

    end,
  },
  {
    'rmehri01/onenord.nvim',
    enabled = false,
    config = function()
      require('lualine').setup {

        options = {
          theme = 'onenord'
        }

      }
      vim.o.background = "light"
    end
  },
  {
    "zenbones-theme/zenbones.nvim",
    enabled = false,

    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.zenbones_darken_comments = 45
      vim.o.background = "light"
    end
  },
  {
    "miikanissi/modus-themes.nvim",
    priority = 1000,
    enabled = false,
    config = function()
      vim.o.background = "light"
    end

  },
  {
    "ramojus/mellifluous.nvim",
    enabled = false,
    config = function()
      require("mellifluous").setup({}) -- optional, see configuration section.
      vim.o.background = "light"
    end,
  }


}
