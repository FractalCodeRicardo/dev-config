local opt = vim.opt;

opt.expandtab = true
opt.shiftwidth = 2

-- Needed for feline plugin
--opt.termguicolors = true
opt.pumheight = 10
vim.wo.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.ignorecase = true
opt.smartcase = true
vim.o.winborder = 'rounded'
-- opt.cursorline = true
-- opt.colorcolumn=90

opt.fillchars = { fold = " " }
opt.foldmethod = "indent"
opt.foldenable = false
opt.foldlevel = 99

-- Enable diagnostics
vim.diagnostic.config({
    virtual_text = true,   -- Show inline diagnostics
    signs = true,          -- Show signs in the gutter
    underline = true,      -- Underline errors
    update_in_insert = true, -- Don't update diagnostics in insert mode
    severity_sort = true,  -- Sort diagnostics by severity
})

vim.api.nvim_create_user_command("Dotnet", function()
    vim.cmd("compiler dotnet")
    vim.cmd("make")
    vim.cmd("copen")
end, {})

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
-- I → skip the intro message
-- c → suppress completion messages
-- F → suppress file info messages

-- remove "Press enter to continue message"
vim.opt.more = false

