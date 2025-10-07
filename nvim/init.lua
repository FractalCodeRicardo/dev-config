vim.g.mapleader = " "      -- Set space as leader
vim.g.maplocalleader = " " -- Set space as local leader

require("config.lazy")
require("config.keymaps")
require("config.options")
-- vim.cmd("colorscheme gruvbox-material")
-- vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme one_monokai")
-- vim.cmd("colorscheme onedark")
-- vim.cmd("colorscheme catppuccin-macchiato")
-- vim.cmd("colorscheme duskfox")
-- vim.cmd("colorscheme rose-pine")
vim.cmd.colorscheme("tokyonight-storm")

-- Fix unreadable unused code color
vim.defer_fn(function()
    -- Method 1: for new Treesitter highlight names
    vim.api.nvim_set_hl(0, "@lsp.code.unused", { fg = "#a9b1d6" })     -- normal text color
    vim.api.nvim_set_hl(0, "@lsp.typemod.variable.unused", { fg = "#a9b1d6" })
    vim.api.nvim_set_hl(0, "@lsp.typemod.parameter.unused", { fg = "#a9b1d6" })

    -- Method 2: for some LSPs that use DiagnosticUnnecessary
    vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "#a9b1d6" })
end, 100)


vim.lsp.enable("lua_ls")
vim.lsp.enable("tsserver")
vim.lsp.enable("rust_analyzer")
-- vim.lsp.disable("roslyn_ls")

vim.fn.setenv("DAP_LOG_LEVEL", "TRACE")
vim.fn.setenv("DAP_LOG_FILE", vim.fn.stdpath("cache") .. "/dap.log")

vim.opt.runtimepath:append("~/dev/eyes-wide-bright/")
