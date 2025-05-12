
vim.g.mapleader = " "  -- Set space as leader
vim.g.maplocalleader = " "  -- Set space as local leader

require("config.lazy")
require("config.keymaps")
require("config.options")
--vim.cmd("colorscheme duskfox")
vim.cmd("colorscheme tokyonight-storm")

vim.lsp.enable("omnisharp")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")



