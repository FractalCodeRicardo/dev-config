vim.g.mapleader = " "      -- set space as leader
vim.g.maplocalleader = " " -- Set space as local leader

require("config.lazy")
require("config.keymaps")
require("config.options")
require("config.commands")
require("my.surround")
require("my.pairs")

-- vim.cmd("colorscheme catppuccin-macchiato")
-- vim.cmd("colorscheme catppuccin-latte")

-- vim.cmd.colorscheme("tokyonight-storm")
-- vim.cmd.colorscheme("tokyonight-day")

-- vim.cmd("colorscheme kanagawa")

-- vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme dayfox")


-- vim.cmd("colorscheme onedark")
-- vim.cmd("colorscheme gruvbox-material")

-- vim.cmd('colorscheme github_dark_default')
-- vim.cmd('colorscheme github_light')
-- vim.cmd('colorscheme github_light_colorblind')

-- vim.cmd("colorscheme everforest")
-- vim.cmd('colorscheme vscode')


-- vim.cmd("colorscheme cyberdream")
-- vim.cmd("colorscheme onedark_dark")
-- vim.cmd("colorscheme onelight")
-- vim.cmd("colorscheme dracula")
-- vim.cmd('colorscheme material')
-- vim.cmd('colorscheme nord')

-- vim.cmd('colorscheme oxocarbon')
-- vim.cmd('colorscheme sonokai')
-- vim.cmd('colorscheme solarized-osaka')
-- vim.cmd('colorscheme nordic')
-- vim.cmd("colorscheme moonfly")

-- vim.cmd.colorscheme('edge')
-- vim.cmd.colorscheme('melange')
-- vim.cmd.colorscheme('bamboo')
-- vim.cmd.colorscheme('onenord')
-- vim.cmd.colorscheme('zenbones')
-- vim.cmd.colorscheme('modus')

-- vim.cmd("colorscheme mellifluous")



-- vim.cmd("colorscheme nightfly")
-- vim.cmd("colorscheme one_monokai")
-- vim.cmd("colorscheme carbonfox")
-- vim.cmd("colorscheme NeoSolarized")
-- vim.cmd('colorscheme github_dark_colorblind')
-- vim.cmd('colorscheme vague')
-- vim.cmd('colorscheme fluoromachine')
-- vim.cmd('colorscheme eldritch')
vim.cmd.colorscheme("leaf")
-- vim.cmd("colorscheme moonfly")
-- vim.cmd('colorscheme oldworld')
-- vim.cmd.colorscheme("synthweave-transparent")



vim.lsp.enable("lua_ls")
vim.lsp.enable("astro")
vim.lsp.enable("tsserver")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable('jdtls')
vim.fn.setenv("DAP_LOG_LEVEL", "TRACE")
vim.fn.setenv("DAP_LOG_FILE", vim.fn.stdpath("cache") .. "/dap.log")

local temp = require("my.drawboard")
temp.init()
