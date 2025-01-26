return {
   {
      "williamboman/mason.nvim",
      -- event = "VeryLazy",
      lazy = true,
      config = function()
         require('mason').setup()
      end
   },

   {
      "williamboman/mason-lspconfig.nvim",
      -- event = "VeryLazy",
      lazy = true,
      dependencies = {
         "williamboman/mason.nvim"
      },
      opts = {
         auto_install = true,
      },
      config = function()
         require('mason-lspconfig').setup({
            ensure_installed = { "lua_ls" }
         })
      end
   },
   {
      "neovim/nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
      -- event = "VeryLazy",
      -- lazy = true,
      dependencies = {
         "williamboman/mason.nvim",
         "williamboman/mason-lspconfig.nvim",
      },
      config = function()
         local capabilities = require('cmp_nvim_lsp').default_capabilities()
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

         --omnisharp
         lspconfig.omnisharp.setup({
            capabilities = capabilities,
            enable_roslyn_analysers = true,
            enable_import_completion = true,
            organize_imports_on_format = true,
            enable_decompilation_support = true,
            filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' }
         })


         --typscript
         -- Configure tsserver for React and JavaScript
         lspconfig.ts_ls.setup({
            capabilities = capabilities,
         })

         lspconfig.jsonls.setup{}

        -- lspconfig.powershell_es.setup {}
      end
   }

}
