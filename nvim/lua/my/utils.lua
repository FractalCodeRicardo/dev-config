local M = {}

function M.get_csproj_name()
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

function M.get_dll_path(project_name)
    local dll_path = vim.fn.getcwd() .. "/" .. project_name .. "/bin/Debug/net8.0/" .. project_name .. ".dll"

    return dll_path
end

function M.im_on_windows()
    local os = vim.loop.os_uname().sysname
    if os == "Windows_NT" then
        return true
    end

    return false
end
function M.get_netcoredbg_path()
    local data_path = vim.fn.stdpath("data")
    local window_path = "/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe"
    local linux_path = "/mason/bin/netcoredbg"
    local path = ""

    if M.im_on_windows()  then
      path = data_path .. window_path
    else
        path = data_path .. linux_path
    end

    -- print("netcoredbg path: " ..path)
    return  path
end

function M.get_lua_debugger()
    local data_path = vim.fn.stdpath("data")
    local file_path = "/mason/packages/local-lua-debugger-vscode/extension/extension/debugAdapter.js"

    return data_path .. file_path
end

function M.get_lua_extension_folder()
    local data_path = vim.fn.stdpath("data")
    local extension_path = "/mason/packages/local-lua-debugger-vscode"

    return data_path .. extension_path
end

function M.get_omnisharp()
    local data_path = vim.fn.stdpath("data")
    local file_path = "/mason/packages/omnisharp/OmniSharp"

    return data_path .. file_path
end

function M.get_codelldb()
    local data_path = vim.fn.stdpath("data")
    local file_path = "/mason/packages/codelldb/codelldb"

    return data_path .. file_path
end

function M.find_file(callback)
    local fzf = require('fzf-lua');
    fzf.files({
        git_icons = false,
        file_icons = false,
        prompt = 'Select File: ',
        cmd = "fd --type f --no-ignore",
        actions = {
            ['default'] = function(selected)
                local file = vim.fn.getcwd() .. "/" .. selected[1]
                callback(file)
            end
        }
    })
end

function M.set_debug_assembly(file)
    vim.g["debug_assembly"] = file
end

function M.get_debug_assembly()
    return vim.g["debug_assembly"]
end

function M.configure_debug_assembly(callback)
    local assembly = M.get_debug_assembly()

    local askFile = function()
        M.find_file(function(file)
            M.set_debug_assembly(file)
            callback()
        end)
    end

    if assembly == nil then
        askFile()
        return
    end

    if vim.fn.confirm('Change debug assembly?\n' .. assembly, '&yes\n&no', 2) == 1 then
        askFile()
    end
end

function M.eval_buffer()
-- Get all lines from current buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local chunk = table.concat(lines, "\n")

  -- Open (or reuse) a scratch buffer for results
  local buf_name = "LuaOutput"
  local buf = vim.fn.bufnr(buf_name)
  if buf == -1 then
    buf = vim.api.nvim_create_buf(false, true) -- [listed=false, scratch=true]
    vim.api.nvim_buf_set_name(buf, buf_name)
  end

  -- Create a split if it's not visible
  local win = vim.fn.bufwinnr(buf)
  if win == -1 then
    vim.cmd("botright split")
    vim.api.nvim_win_set_buf(0, buf)
    vim.api.nvim_win_set_height(0, 10)
  end

  -- Clear previous content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  -- Run Lua code
  local ok, result = pcall(load(chunk))

  -- Collect output
  local output = {}
  if ok then
    if result ~= nil then
      table.insert(output, vim.inspect(result))
    else
      table.insert(output, "✔ Buffer executed successfully")
    end
  else
    table.insert(output, "❌ Error: " .. result)
  end

  -- Write output to the scratch buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
end

return M
