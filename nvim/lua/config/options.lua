local opt = vim.opt;

opt.expandtab = true
opt.shiftwidth = 2

-- Needed for feline plugin
--opt.termguicolors = true

vim.wo.number = true
opt.relativenumber = true
opt.termguicolors = true

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
  update_in_insert = false, -- Don't update diagnostics in insert mode
  severity_sort = true, -- Sort diagnostics by severity
})
