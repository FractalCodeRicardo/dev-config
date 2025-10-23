vim.g.mapleader = " "      -- set space as leader
vim.g.maplocalleader = " " -- Set space as local leader

require("config.lazy")
require("config.keymaps")
require("config.options")
-- vim.cmd("colorscheme gruvbox-material")
-- vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme one_monokai")
-- vim.cmd("colorscheme onedark")
-- vim.cmd("colorscheme catppuccin-macchiato")
vim.cmd("colorscheme duskfox")
-- vim.cmd("colorscheme NeoSolarized")
-- vim.cmd("colorscheme rose-pine")
-- vim.cmd.colorscheme("tokyonight-storm")
-- vim.cmd.colorscheme("leaf")
-- vim.cmd("colorscheme cyberdream")
-- vim.cmd("colorscheme moonfly")



vim.lsp.enable("lua_ls")
vim.lsp.enable("astro")
vim.lsp.enable("tsserver")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable('jdtls')
vim.fn.setenv("DAP_LOG_LEVEL", "TRACE")
vim.fn.setenv("DAP_LOG_FILE", vim.fn.stdpath("cache") .. "/dap.log")
