return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        local function get_csproj_name()
            local files = vim.fn.globpath(vim.fn.getcwd(), "**/*.csproj", false, true)

            if #files == 0 then
                print("No .csproj files found.")
                return nil
            end

            if #files == 1 then
                return vim.fn.fnamemodify(files[1], ":t:r")
            end

            local options = {}
            for idx, file in ipairs(files) do
                table.insert(options, string.format("%d: %s", idx, file))
            end

            local choice = vim.fn.inputlist(options)

            if choice > 0 and choice <= #files then
                return vim.fn.fnamemodify(files[choice], ":t:r") -- Get filename without extension
            end

            print("Invalid selection.")
            return nil
        end

        local function get_dll_path(project_name)
            local dll_path = vim.fn.getcwd() .. "/" .. project_name .. "/bin/Debug/net8.0/" .. project_name .. ".dll"

            return dll_path
        end

        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    local project = get_csproj_name()

                    if project == nil then
                        print("Opción cancelada.")
                        return nil
                    end

                    local dll = get_dll_path(project)
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

        local function get_netcoredbg_path()
            local os = vim.loop.os_uname().sysname
            local data_path = vim.fn.stdpath("data")
            local window_path = "/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe"
            local linux_path = "/mason/bin/netcoredbg"

            if os == "Windows_NT" then
                return data_path .. window_path
            end

            return data_path .. linux_path
        end


        dap.adapters.coreclr = {
            type = 'executable',
            command = get_netcoredbg_path(),
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
