local opt = vim.opt;

opt.expandtab = true
opt.shiftwidth = 4

-- Needed for feline plugin
--opt.termguicolors = true
opt.pumheight = 10
vim.wo.number = true
opt.relativenumber = true
opt.termguicolors = true
vim.o.winborder = 'rounded'

vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })

opt.fillchars = { fold = " " }
opt.foldmethod = "indent"
opt.foldenable = false
opt.foldlevel = 99

-- Enable diagnostics
vim.diagnostic.config({
  virtual_text = true, -- Show inline diagnostics
  signs = true,        -- Show signs in the gutter
  underline = true,    -- Underline errors
  update_in_insert = true, -- Don't update diagnostics in insert mode
  severity_sort = true, -- Sort diagnostics by severity
})

vim.fn.sign_define("DiagnosticSignError", { text = "❌", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",  { text = "⚠️", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",  { text = "ℹ️", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",  { text = "💡", texthl = "DiagnosticSignHint" })


-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     local supported = client:supports_method('textDocument/completion');
--
--     if not supported then
--         print("Autocompletion not supported " .. ev.data.client_id)
--     end
--
--     if supported then
--       print("Autocompletion supported");
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
--     end
--   end,
-- })

