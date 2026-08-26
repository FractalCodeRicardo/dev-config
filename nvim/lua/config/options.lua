local opt = vim.opt;

-- search is slow when true
opt.hlsearch = false
opt.expandtab = true
opt.shiftwidth = 2
--opt.autocomplete = true

opt.pumheight = 10
vim.wo.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.ignorecase = true
opt.smartcase = true
-- vim.o.winborder = 'rounded'
-- opt.cursorline = true
-- opt.colorcolumn=90

opt.fillchars = { fold = " " }
opt.foldmethod = "indent"
opt.foldenable = false
opt.foldlevel = 99

-- Enable diagnostics
vim.diagnostic.config({
  virtual_text = true,       -- Show inline diagnostics
  signs = true,              -- Show signs in the gutter
  underline = true,          -- Underline errors
  update_in_insert = true,   -- Don't update diagnostics in insert mode
  severity_sort = true,      -- Sort diagnostics by severity
})

-- vim.api.nvim_create_user_command("Dotnet", function()
--   vim.cmd("compiler dotnet")
--   vim.cmd("make")
--   vim.cmd("copen")
-- end, {})

local utils = require("my.utils")

if utils.im_on_windows() then
  --netcoredbg issue
  --https://github.com/mfussenegger/nvim-dap/discussions/1156
  vim.opt.shellslash = false
  vim.defer_fn(function()
    vim.opt.shellslash = false
  end, 5000)
end

vim.opt.shortmess:append { I = true, c = false, F = false }
vim.opt.shell = "/bin/zsh"

-- local ui2 = require("vim._core.ui2")
-- ui2.enable({
--   enable = true
-- })


vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", {})

