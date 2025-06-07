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


function M.get_netcoredbg_path()
    local os = vim.loop.os_uname().sysname
    local data_path = vim.fn.stdpath("data")
    local window_path = "/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe"
    local linux_path = "/mason/bin/netcoredbg"

    if os == "Windows_NT" then
        return data_path .. window_path
    end

    return data_path .. linux_path
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



return M
