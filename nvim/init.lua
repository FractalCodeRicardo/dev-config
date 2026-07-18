vim.g.mapleader = " "      -- set space as leader
vim.g.maplocalleader = " " -- Set space as local leader

require("config.lazy")
require("config.keymaps")
require("config.options")
require("config.commands")
require("my.surround")
-- require("my.pairs")
require("my.terminal")
require("my.compilers")
-- require("my.autocomplete")
--require("my.evalbuffer")

vim.lsp.enable("lua_ls")
vim.lsp.enable("astro")
vim.lsp.enable("ts_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable('jdtls')
vim.lsp.enable('kotlin_lsp')
vim.lsp.enable('lemminx')
vim.lsp.enable('clangd')
vim.lsp.enable('html-lsp')
vim.lsp.enable('glsl_analyzer')

vim.fn.setenv("DAP_LOG_LEVEL", "TRACE")
vim.fn.setenv("DAP_LOG_FILE", vim.fn.stdpath("cache") .. "/dap.log")

