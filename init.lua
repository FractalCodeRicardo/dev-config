require("config.lazy")
require("config.keymaps")

require("tokyonight").setup({
	style="storm"
})

vim.cmd("colorscheme tokyonight-storm")

vim.wo.number = true

require("toggleterm").setup({
	open_mapping = [[<c-t>]]
})
