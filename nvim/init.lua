vim.g.mapleader = " "      -- set space as leader
vim.g.maplocalleader = " " -- Set space as local leader

require("config.lazy")
require("config.keymaps")
require("config.options")
require("config.commands")
require("my.surround")
require("my.pairs")
require("my.terminal")
require("my.autocomplete")

vim.cmd("colorscheme moonfly")

vim.lsp.enable("lua_ls")
vim.lsp.enable("astro")
vim.lsp.enable("tsserver")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable('jdtls')

vim.fn.setenv("DAP_LOG_LEVEL", "TRACE")
vim.fn.setenv("DAP_LOG_FILE", vim.fn.stdpath("cache") .. "/dap.log")
