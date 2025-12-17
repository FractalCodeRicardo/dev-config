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
          local assembly = utils.get_debug_assembly()
          print("Assembly file: " .. assembly)
          return assembly
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


    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          local assembly = utils.get_debug_assembly()
          print("Assembly file: " .. assembly)
          return assembly
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }

    dap.adapters.coreclr = {
      type = 'executable',
      command = utils.get_netcoredbg_path(),
      args = { '--interpreter=vscode' }
    }


    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = utils.get_codelldb(),
        args = { "--port", "${port}" },
      }
    }

    dapui.setup({
      -- layouts = { {
      --   elements = { {
      --     id = "watches",
      --     size = 1
      --   } },
      --   position = "bottom",
      --   size = 10
      -- }
      -- },
    })

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
    local maps = vim.keymap;
    maps.set('n', '<F5>',

      function()
        if utils.get_debug_assembly() == nil then
          utils.configure_debug_assembly(function()
            dap.continue()
          end)
        else
          dap.continue()
        end
      end
      , { desc = "Start/Continue Debugging" })
    maps.set('n', '<F6>', dap.step_over, { desc = "Step Over" })
    maps.set('n', '<F7>', dap.step_into, { desc = "Step Into" })
    maps.set('n', '<F8>', dap.step_out, { desc = "Step Out" })
    maps.set('n', '<Leader>db', function ()
      print("Breakpoint")
      dap.toggle_breakpoint()
    end, { desc = "Toggle Breakpoint" })
    maps.set('n', '<Leader>B', function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Set Conditional Breakpoint" })
    maps.set('n', '<Leader>dr', dap.repl.open, { desc = "Open Debug Console (REPL)" })
    maps.set('n', '<Leader>dt', dap.terminate, { desc = "Stop Debugging" })
    maps.set('n', '<Leader>du', dapui.toggle, { desc = "Toggle DAP UI" })
    maps.set('n', '<Leader>de', function() dapui.eval() end, { desc = "Open Expressions Panel" })
    maps.set('n', '<Leader>ds', function() dapui.open({ layout = 2 }) end, { desc = "Open Scopes Panel" })
  end
}
