return {
    {
        "folke/tokyonight.nvim",
        lazy = true,
        enabled = false,
        priority = 1000,
        opts = {
            transparent = true
        },
        config = function()
            vim.cmd("colorscheme tokyonight-storm")
        end
    },
    {
        "catppuccin/nvim",
        enabled = false,
        lazy = true,
        name = "catppuccin",
        priority = 1000
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true
    },

}
