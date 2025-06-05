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
    end


}
