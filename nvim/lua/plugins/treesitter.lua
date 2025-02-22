return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "c_sharp" },
            highlight = { enable = true },
            indent = { enable = true }
        }

        vim.o.foldmethod = 'manual'
        vim.o.foldenable = false
    end
}
