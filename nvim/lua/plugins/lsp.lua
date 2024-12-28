return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "folke/neodev.nvim",
    },
    config = function()
        require("neodev").setup()
        require("lspconfig").lua_ls.setup({})
        local os = require('os')
        local omnisharp_server_location = os.getenv('OMNISHARP_LANGUAGE_SERVER')

        require("lspconfig").omnisharp.setup({
           -- cmd = { "dotnet", omnisharp_server_location }
            cmd = { "dotnet", "/home/ricardo/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" }
        })
    end
}
