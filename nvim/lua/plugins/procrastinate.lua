return {
  {
    "eandrju/cellular-automaton.nvim",
    enabled = true
  },
  {
    "NStefan002/donut.nvim",
    enabled = true,
    version = "*",
    lazy = false,
  },
  {
    "seandewar/actually-doom.nvim",
    enabled = false
  },
  {
    "folke/drop.nvim",
    enabled = false,
    opts = {
    }
  },
  {
    "seandewar/killersheep.nvim",
    enabled = true,
    config = function()
      require("killersheep").setup {
        gore = true,         -- Enables/disables blood and gore.
        keymaps = {
          move_left = "h",   -- Keymap to move cannon to the left.
          move_right = "l",  -- Keymap to move cannon to the right.
          shoot = "<Space>", -- Keymap to shoot the cannon.
        }
      }
    end
  },
  {
    "rhysd/vim-syntax-christmas-tree",
    enabled = false
  },
  {
    "koron/nyancat-vim",
    enabled = false
  },
  {
    "idanarye/vim-smile",
    enabled = false
  },
  {
    "Febri-i/snake.nvim",
    enabled = false,
    dependencies = {
      "Febri-i/fscreen.nvim"
    },
    opts = {}
  },
  {
    'jim-fx/sudoku.nvim',
    enabled = false,
    cmd = "Sudoku",
    config = function()
      require("sudoku").setup({
        -- configuration ...
      })
    end
  },
  {
    'szymonwilczek/vim-be-better',
    enabled = false,
    config = function()
      -- Optional: Enable logging for debugging
      vim.g.vim_be_better_log_file = 1
    end
  },
  {
    "seandewar/nvimesweeper",
    cmd = "Nvimesweeper",
  }

}
