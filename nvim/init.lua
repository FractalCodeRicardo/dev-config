
vim.g.mapleader = " "  -- Set space as leader
vim.g.maplocalleader = " "  -- Set space as local leader

require("config.lazy")
require("config.keymaps")
require("config.options")
-- vim.cmd("colorscheme onedark")
-- vim.cmd("colorscheme catppuccin-macchiato")
vim.cmd("colorscheme duskfox")
-- vim.cmd("colorscheme tokyonight-night")

vim.lsp.enable("lua_ls")
vim.lsp.enable("tsserver")
vim.lsp.enable("rust_analyzer")
-- vim.lsp.disable("roslyn_ls")



