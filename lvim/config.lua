-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Enable powershell as your default shell
--
local is_windows = vim.loop.os_uname().version:match("Windows")

if is_windows then
  vim.opt.shell = "pwsh.exe"
  vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

  -- Set a compatible clipboard manager
  vim.g.clipboard = {
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
  }
end




-- KEYS
-- jk to enter normal mode
lvim.keys.insert_mode["jk"] = "<Esc>"

-- Save with ctrl + s
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
lvim.keys.insert_mode["<C-s>"] = "<Esc>:w<CR>"
lvim.keys.visual_mode["<C-s>"] = "<Esc>:w<CR>"

-- open terminal in horizontal split
vim.api.nvim_set_keymap('n', '<C-t>', ':split | term<CR>', { noremap = true, silent = true })


-- KEYS FOR DAP
-- F5 to continue debugging
vim.api.nvim_set_keymap('n', '<F5>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
-- F10 to step over
vim.api.nvim_set_keymap('n', '<F10>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
-- F11 to step into
vim.api.nvim_set_keymap('n', '<F11>', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
-- F12 to step out
vim.api.nvim_set_keymap('n', '<F12>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true })


-- CODE
lvim.format_on_save.enabled = true

-- DAP Configuration
local dap = require("dap")

-- Adapter for .NET Core
dap.adapters.coreclr = {
  type = 'executable',
  command = '/home/ricardo/netcoredbg/netcoredbg', -- Path to netcoredbg
  args = { '--interpreter=vscode' },
}

-- Configuration for C# Debugging
dap.configurations.cs = {
  {
    type = 'coreclr',
    name = 'Launch',
    request = 'launch',
    program = function()
      local dir = vim.fn.getcwd();
      local project_name = vim.fn.fnamemodify(dir, ':t');
      local dll_path = dir .. '/bin/Debug/net8.0/' .. project_name .. '.dll';
      vim.notify(dll_path);
      return dll_path;
    end,
  },
}

require("lvim.lsp.manager").setup("omnisharp", {
  cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  filetypes = { "cs", "vb" }, -- C# and VB file types
  root_dir = function(fname)
    return vim.fn.getcwd()    -- Use the current working directory as the root
  end,
  settings = {
    omnisharp = {
      enableRoslynAnalyzers = true,   -- Enable Roslyn analyzers (optional)
      organizeImportsOnFormat = true, -- Automatically organize imports on save (optional)
    }
  }
})