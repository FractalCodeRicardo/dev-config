local options = { noremap = true }
local map = vim.keymap

map.set("i", "jk", "<Esc>", options)
-- ctr + backspace delete word
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<A-z>', '<', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-x>', '>', { noremap = true, silent = true })
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


--map.set("n", "q", ":cclose<cr>", options)
-- LSP
map.set("n", "<C-F2>", vim.lsp.buf.rename, options)
map.set('n', 'gd', vim.lsp.buf.definition, {})
map.set('n', 'gr', vim.lsp.buf.references, {})
map.set("n", "<S-A-f>", vim.lsp.buf.format, options)
map.set("n", "<C-q>", vim.lsp.buf.code_action, options)
map.set('n', '<C-k>', vim.lsp.buf.hover, options)
map.set('n', '<C-.', vim.lsp.buf.code_action, options)
map.set('n', '<A-l>', ':BufferLineCycleNext<CR>', options)
map.set('n', '<A-h>', ':BufferLineCyclePrev<CR>', options)
map.set('n', '<C-w>', ':bdelete<CR>', options)
map.set('n', '<A-w>', ':BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>', options)
