return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    -- lazy = true,
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        local lspconfig = require('lspconfig')


        -- Lua
        lspconfig.lua_ls.setup({
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

        --            omnisharp
        lspconfig.omnisharp.setup({
            capabilities = capabilities,
            enable_editorconfig_support = true,
            enable_roslyn_analyzers = true,
            organize_imports_on_format = true,
            enable_import_completion = true,
            sdk_include_prereleases = true,
            analyze_open_documents_only = false,
            filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' }
        })
        --typscript
        -- Configure tsserver for React and JavaScript
        --
        lspconfig.ts_ls.setup({
            capabilities = capabilities,
        })

        lspconfig.jsonls.setup {}
        -- lspconfig.powershell_es.setup {}
        --
    end
}
