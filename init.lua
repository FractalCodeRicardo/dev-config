require("config.lazy")
require("config.keymaps")

require("tokyonight").setup({
	style="storm"
})

vim.cmd("colorscheme onedark")

vim.wo.number = true

require("toggleterm").setup({
	open_mapping = [[<c-t>]]
})
