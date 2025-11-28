return {
  {
    "mason-org/mason.nvim",
    lazy = true,
    config = function()
      require('mason').setup({
        registries = {
          'github:Crashdummyy/mason-registry',
          'github:mason-org/mason-registry',
        },
      })
    end
  },

  {
    "mason-org/mason-lspconfig.nvim",
    lazy = true,
    dependencies = {
      "mason-org/mason.nvim"
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
}
