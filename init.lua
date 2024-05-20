require("config.lazy")
require("config.keymaps")

require("mason").setup()
require("mason-lspconfig").setup()
local lspconfig = require "lspconfig"

lspconfig.omnisharp_mono.setup {}

require("tokyonight").setup({
	style="storm"
})

vim.cmd("colorscheme onedark")

vim.wo.number = true

require("toggleterm").setup({
	open_mapping = [[<c-t>]]
})

require("feline").setup()
