return {
    "seblyng/roslyn.nvim",
    enabled = true,
    ft = "cs",
    opts = {
      config = {
        settings = {
          ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "fullSolution",
            dotnet_compiler_diagnostics_scope = "fullSolution"
          },

          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true
          }
        },
      },
    },


}
