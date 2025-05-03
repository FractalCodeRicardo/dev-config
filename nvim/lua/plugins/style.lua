return {
    {
        "folke/tokyonight.nvim",
        lazy = true,
        enabled = true,
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            }
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")

            -- Transparent background fix
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
            vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
        end,
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
