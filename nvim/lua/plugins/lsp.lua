return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    -- lazy = true,
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
    },
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local lspconfig = require('lspconfig')

        -- Lua
        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT', -- Use LuaJIT for Neovim
                    },
                    diagnostics = {
                        globals = { 'vim' }, -- Recognize `vim` as a global
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true), -- Make LSP aware of Neovim runtime
                        checkThirdParty = false,                           -- Disable third-party library warnings
                    },
                    telemetry = {
                        enable = false, -- Disable telemetry for privacy
                    },
                },
            },
        })
        local utils = require("my.utils");
        -- local omnisharp_path = utils.get_omnisharp()
        -- omnisharp
        -- vim.lsp.config("omnisharp", {
        --     cmd = {
        --         "dotnet",
        --         omnisharp_path .. ".dll",
        --         "-z",
        --         "--hostPID",
        --         tostring(vim.fn.getpid()),
        --         "DotNet:enablePackageRestore=false",
        --         "--encoding",
        --         "utf-8",
        --         "--languageserver"
        --     },
        --     capabilities = capabilities,
        --     enable_editorconfig_support = true,
        --     enable_roslyn_analyzers = true,
        --     organize_imports_on_format = true,
        --     enable_import_completion = true,
        --     sdk_include_prereleases = true,
        --     analyze_open_documents_only = false,
        --     enable_decompilation_support = true,
        --     settings = {
        --         FormattingOptions = {
        --             EnableEditorConfigSupport = true
        --         },
        --         MsBuild = {},
        --         RenameOptions = {},
        --         RoslynExtensionsOptions = {
        --              enableDecompilationSupport = true
        --         },
        --         Sdk = {
        --             IncludePrereleases = true
        --         }
        --     },
        --     filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' },
        --     handlers = {
        --         ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
        --         ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
        --         ["textDocument/references"] = require('omnisharp_extended').references_handler,
        --         ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
        --     }
        -- })
        --typscript
        -- Configure tsserver for React and JavaScript
        --
        vim.lsp.config("ts_ls", {
            capabilities = capabilities,
        })


        vim.lsp.config("clangd", {})
        vim.lsp.config("rust_analyzer", {
            cmd = { "/usr/bin/rust-analyzer" }
        })
        vim.lsp.config("clangd", {})
        vim.lsp.config("jsonls", {})
        vim.lsp.config("powershell_es", {})

        vim.lsp.config("lemminx", {
            filetypes = { "xml", "axaml", "xsd", "xslt", "csproj" },
        })

        vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
            pattern = "*.axaml",
            callback = function()
                vim.bo.filetype = "xml"
            end,
        })
        --
    end
}
