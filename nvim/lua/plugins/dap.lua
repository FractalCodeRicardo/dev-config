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
            local csproj_files = vim.fn.globpath(vim.fn.getcwd(), "**/*.csproj", false, true)

            if #csproj_files == 0 then
                print("No .csproj files found.")
                return nil
            elseif #csproj_files == 1 then
                return vim.fn.fnamemodify(csproj_files[1], ":t:r")
            else
                local options = {}
                for idx, file in ipairs(csproj_files) do
                    table.insert(options, string.format("%d: %s", idx, file))
                end

                local choice = vim.fn.inputlist(options)

                if choice > 0 and choice <= #csproj_files then
                    return vim.fn.fnamemodify(csproj_files[choice], ":t:r") -- Get filename without extension
                else
                    print("Invalid selection.")
                    return nil
                end
            end
        end


        local function get_dll_path(project_name)
            local dll_path = vim.fn.getcwd() .. "/" .. project_name .. "/bin/Debug/net8.0/" .. project_name .. ".dll"

            return dll_path
        end

        dap.adapters.coreclr = {
            type = 'executable',
            command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
            args = { '--interpreter=vscode' }
        }

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
        }

        dapui.setup()

        -- Automatically open/close UI when debugging starts/stops
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- Keybindings
        vim.keymap.set('n', '<F5>', dap.continue, { desc = "Start/Continue Debugging" })
        vim.keymap.set('n', '<F10>', dap.step_over, { desc = "Step Over" })
        vim.keymap.set('n', '<F11>', dap.step_into, { desc = "Step Into" })
        vim.keymap.set('n', '<F12>', dap.step_out, { desc = "Step Out" })
        vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
        vim.keymap.set('n', '<Leader>B', function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Set Conditional Breakpoint" })
        vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = "Open Debug Console (REPL)" })
        vim.keymap.set('n', '<Leader>dx', dap.terminate, { desc = "Stop Debugging" })
        vim.keymap.set('n', '<Leader>du', dapui.toggle, { desc = "Toggle DAP UI" })
        vim.keymap.set('n', '<Leader>de', function() dapui.eval() end, { desc = "Open Expressions Panel" })
        vim.keymap.set('n', '<Leader>ds', function() dapui.open({ layout = 2 }) end, { desc = "Open Scopes Panel" })
    end
}
