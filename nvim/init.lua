vim.g.mapleader = " "  -- Set space as leader
vim.g.maplocalleader = " "  -- Set space as local leader

require("config.lazy")
require("config.keymaps")
require("config.options")
vim.cmd("colorscheme tokyonight-night")
--vim.cmd("colorscheme catppuccin-mocha")
-- vim.cmd("colorscheme onedark")
--vim.cmd("colorscheme one_monokai")
--vim.cmd("colorscheme kanagawa")


