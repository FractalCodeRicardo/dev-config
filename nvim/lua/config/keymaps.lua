local options = { noremap = true, silent = true }
local map = vim.keymap
local utils = require("my.utils")

--tab to indent
map.set('v', '<Tab>', '>', options)
map.set('v', '<S-Tab>', '<', options)

-- jk to normal mode
map.set("i", "jk", "<Esc>", options)

-- ctr + backspace delete word
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-W>', { noremap = true, silent = true })
--ctrl + A select all
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG<CR>', options);

-- alt + z and x to <>
vim.api.nvim_set_keymap('i', '<A-z>', '<', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-x>', '>', { noremap = true, silent = true })

-- navigate buffers
map.set('n', '<C-h>', '<C-w><Left>', options)
map.set('n', '<C-l>', '<C-w><Right>', options)
map.set('n', '<C-k>', '<C-w><Up>', options)
map.set('n', '<C-j>', '<C-w><Down>', options)
-- Resize vertically
vim.keymap.set("n", "<C-w><Left>",  ":vertical resize -5<CR>", options)
vim.keymap.set("n", "<C-w><Right>", ":vertical resize +5<CR>", options)

-- Resize horizontally
vim.keymap.set("n", "<C-w><Up>",    ":resize -5<CR>", options)
vim.keymap.set("n", "<C-w><Down>",  ":resize +5<CR>", options)
-- undo
-- overlaps suspend
-- map.set('n', '<C-z>', 'u', options)

-- Save with ctrl + s
map.set({ "n", "v", "i" }, "<C-S>", "<C-c>:wa<cr>", { silent = true, desc = "Save" })

--map.set("n", "q", ":cclose<cr>", options)
-- LSP
map.set("n", "<F2>", vim.lsp.buf.rename, options)

map.set('n', 'gd', vim.lsp.buf.definition, {})
map.set('n', 'gi', vim.lsp.buf.implementation, {})
map.set("n", "<C-q>", vim.lsp.buf.code_action, options)
map.set('n', 'gt', vim.lsp.buf.document_symbol, options)

-- go to definition split
map.set('n', 'gs', function()
      vim.cmd('vsplit')
      vim.cmd('wincmd l')
      vim.lsp.buf.definition()
end, options)

map.set("n", "<Leader>f", vim.lsp.buf.format, options)
map.set('n', '<C-.', vim.lsp.buf.code_action, options)
map.set('n', '<gh', vim.lsp.buf.signature_help, options)
map.set('n', '<A-l>', ':BufferLineCycleNext<CR>', options)
map.set('n', '<A-h>', ':BufferLineCyclePrev<CR>', options)
map.set('n', '<C-w>', ':bdelete<CR>', options)
map.set('n', '<A-w>', ':BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>', options)
map.set('n', 'E', vim.diagnostic.open_float, options)
map.set('n', 'ne', '<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>', options)
map.set('n', 'nw', '<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARNING})<CR>', options)

-- Clipboard
-- Copy
vim.keymap.set('v', '<C-c>', '"+y')
vim.keymap.set('n', '<C-c>', '"+yy')

-- Cut
-- vim.keymap.set('v', '<C-x>', '"+d')

-- Paste
vim.keymap.set({ 'n', 'v' }, '<C-v>', '"+p')
vim.keymap.set('i', '<C-v>', '<C-r>+')

--tree
-- map.set("n", "te", ":Neotree toggle<CR>", options)
-- map.set("n", "te", function() require('mini.files').open() end, options)

--suspend
vim.keymap.set('n', '<Leader>z', '<C-z>', { noremap = true, silent = true })

vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { silent = true })

vim.keymap.set("n", "<leader>eb", utils.eval_buffer)
