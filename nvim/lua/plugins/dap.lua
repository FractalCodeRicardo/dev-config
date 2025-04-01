return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local utils = require("my.utils")

        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    local project = utils.get_csproj_name()

                    if project == nil then
                        print("Opción cancelada.")
                        return nil
                    end

                    local dll = utils.get_dll_path(project)
                    print("Debugging " .. project .. " with " .. dll)
                    return dll
                end,
            },
            {
                type = "coreclr",
                name = "Attach to Process",
                request = "attach",
                processId = function()
                    return require("dap.utils").pick_process()
                end
            }
        }

        dap.adapters.coreclr = {
            type = 'executable',
            command = utils.get_netcoredbg_path(),
            args = { '--interpreter=vscode' }
        }


        dapui.setup()

        -- Automatically open/close UI when debugging starts/stops
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
            require("neo-tree.command").execute({ action = "close" })
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
            require("neo-tree.command").execute({ action = "open" })
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
            require("neo-tree.command").execute({ action = "open" })
        end

        -- Keybindings
        local maps = vim.keymap;
        maps.set('n', '<F5>', dap.continue, { desc = "Start/Continue Debugging" })
        maps.set('n', '<F10>', dap.step_over, { desc = "Step Over" })
        maps.set('n', '<F11>', dap.step_into, { desc = "Step Into" })
        maps.set('n', '<F12>', dap.step_out, { desc = "Step Out" })
        maps.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
        maps.set('n', '<Leader>B', function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Set Conditional Breakpoint" })
        maps.set('n', '<Leader>dr', dap.repl.open, { desc = "Open Debug Console (REPL)" })
        maps.set('n', '<Leader>dx', dap.terminate, { desc = "Stop Debugging" })
        maps.set('n', '<Leader>du', dapui.toggle, { desc = "Toggle DAP UI" })
        maps.set('n', '<Leader>de', function() dapui.eval() end, { desc = "Open Expressions Panel" })
        maps.set('n', '<Leader>ds', function() dapui.open({ layout = 2 }) end, { desc = "Open Scopes Panel" })
    end
}
