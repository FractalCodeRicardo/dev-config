return {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        -- lazy = true,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require('lspconfig')
    end
}
