-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4N
--

-- Keys
-- jk to enter normal mode  
lvim.keys.insert_mode["jk"] = "<Esc>"

-- Save with ctrl + s
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
lvim.keys.insert_mode["<C-s>"] = "<Esc>:w<CR>"
lvim.keys.visual_mode["<C-s>"] = "<Esc>:w<CR>"



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
