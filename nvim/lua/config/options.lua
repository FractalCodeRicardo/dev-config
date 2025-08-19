local opt = vim.opt;

opt.expandtab = true
opt.shiftwidth = 4

-- Needed for feline plugin
--opt.termguicolors = true
opt.pumheight = 10
vim.wo.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.ignorecase = true
opt.smartcase = true
vim.o.winborder = 'rounded'
opt.cursorline = true
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

--deprecated
-- vim.fn.sign_define("DiagnosticSignError", { text = "❌", texthl = "DiagnosticSignError" })
-- vim.fn.sign_define("DiagnosticSignWarn",  { text = "⚠️", texthl = "DiagnosticSignWarn" })
-- vim.fn.sign_define("DiagnosticSignInfo",  { text = "ℹ️", texthl = "DiagnosticSignInfo" })
-- vim.fn.sign_define("DiagnosticSignHint",  { text = "💡", texthl = "DiagnosticSignHint" })


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
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true})
--     end
--   end,
-- })

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

vim.api.nvim_create_user_command("RestartAll", function()
  vim.lsp.stop_client(vim.lsp.get_clients())
  vim.cmd("edit")
  print("✅ It's me, Good. I'm here behind you.")

end, { })
