local options = { noremap = true, silent=true }
local map = vim.keymap




--tab to indent 
map.set('v', '<Tab>', '>', options)

map.set('v', '<S-Tab>', '<', options)

-- jk to normal mode 
map.set("i", "jk", "<Esc>", options)

-- ctr + backspace delete word
vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', { noremap = true, silent = true })

--ctrl + A select all
vim.api.nvim_set_keymap('n', '<C-a>','ggVG<CR>', options);

-- alt + z and x to <>
vim.api.nvim_set_keymap('i', '<A-z>', '<', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<A-x>', '>', { noremap = true, silent = true })

-- navigate buffers
map.set('n', '<C-h>', '<C-w><Left>', options)
map.set('n', '<C-l>', '<C-w><Right>', options)

-- undo
-- overlaps suspend
--map.set('n', '<C-z>', 'u', options)

-- Save with ctrl + s
map.set({ "n", "v", "i" }, "<C-S>", "<C-c>:wa<cr>", { silent = true, desc = "Save" })


--map.set("n", "q", ":cclose<cr>", options)
-- LSP
map.set("n", "<F2>", vim.lsp.buf.rename, options)
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
map.set('n', '<A-e>', vim.diagnostic.open_float, options)
map.set('n', 'ne', '<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>', options)
