local options = { noremap = true }
local map = vim.keymap

map.set("i", "jk", "<Esc>", options)

--nvim tree
map.set('n', '<C-h>', '<C-w><Left>', options)  
map.set('n', '<C-l>', '<C-w><Right>', options)

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {noremap = false})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


map.set({ "n", "v", "i" }, "<C-S>", "<C-c>:update<cr>", { silent = true, desc = "Save" })

