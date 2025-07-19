return {
    "seblyng/roslyn.nvim",
    enabled = true,
    ft = "cs",
    config = function()
        vim.lsp.config("roslyn", {
            on_attach = function()
                print("This will run when the server attaches!")
            end,
            settings = {
                -- ["csharp|inlay_hints"] = {
                --     csharp_enable_inlay_hints_for_implicit_object_creation = true,
                --     csharp_enable_inlay_hints_for_implicit_variable_types = true,
                -- },
                -- ["csharp|code_lens"] = {
                --     dotnet_enable_references_code_lens = true,
                -- },
                -- ["csharp|background_analysis"] = {
                --     dotnet_analyzer_diagnostics_scope = "fullSolution",
                --     dotnet_compiler_diagnostics_scope = "fullSolution"
                -- },
                --
                -- ["csharp|completion"] = {
                --     dotnet_show_completion_items_from_unimported_namespaces = true
                -- }
            },

        })
        local roslyn = require("roslyn");
        roslyn.setup();

        vim.api.nvim_create_autocmd({ "InsertLeave" }, {
            pattern = "*",
            callback = function()
                local clients = vim.lsp.get_clients({ name = "roslyn" })
                if not clients or #clients == 0 then
                    return
                end

                local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
                for _, buf in ipairs(buffers) do
                    vim.lsp.util._refresh("textDocument/diagnostic", { bufnr = buf })
                end
                print("Client refresh ")
            end,
        })
    end


}
