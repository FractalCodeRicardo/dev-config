local options = { noremap = true }
local map = vim.keymap

map.set("i", "jk", "<Esc>", options)
-- ctr + backspace delete word
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', { noremap = true, silent = true })


--nvim tree
map.set('n', '<C-h>', '<C-w><Left>', options)
map.set('n', '<C-l>', '<C-w><Right>', options)
map.set('n', '<C-z>', 'u', options)

-- telescope
--local builtin = require('telescope.builtin')
--map.set('n', '<leader>ff', builtin.find_files, {})
--map.set('n', '<C-f>', builtin.live_grep, { noremap = false })
--map.set('n', '<leader>fb', builtin.buffers, {})
--map.set('n', '<leader>fh', builtin.help_tags, {})


-- Save with ctrl + s
map.set({ "n", "v", "i" }, "<C-S>", "<C-c>:update<cr>", { silent = true, desc = "Save" })

-- LSP

map.set("n", "<C-S-f>", vim.lsp.buf.format, options)
