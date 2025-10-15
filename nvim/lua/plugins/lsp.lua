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
            version = 'LuaJIT',             -- Use LuaJIT for Neovim
          },
          diagnostics = {
            globals = { 'vim' },             -- Recognize `vim` as a global
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),             -- Make LSP aware of Neovim runtime
            checkThirdParty = false,                                       -- Disable third-party library warnings
          },
          telemetry = {
            enable = false,             -- Disable telemetry for privacy
          },
        },
      },
    })
    local utils = require("my.utils");
    vim.lsp.config("tsserver", {
      capabilities = capabilities,
    })


    vim.lsp.config("clangd", {})
    vim.lsp.config("rust_analyzer", {
      cmd = { "/home/ricardo/.cargo/bin/rust-analyzer" }
    })
    vim.lsp.config("clangd", {})
    vim.lsp.config("jsonls", {})
    vim.lsp.config("powershell_es", {})
    vim.lsp.config("astro", {})

    -- local sysname = vim.uv.os_uname().sysname:lower()
    -- local iswin = not not (sysname:find("windows") or sysname:find("mingw"))
    -- vim.lsp.config("roslyn_ls", {
    --     cmd = {
    --         iswin and "roslyn.cmd" or "roslyn",
    --         "--logLevel=Information",
    --         "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
    --         "--stdio"
    --     }
    -- })

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
