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
        enabled = true,
        lazy = true,
        name = "catppuccin",
        priority = 1000,
        config = function()
            local catpuccin = require("catppuccin")
            catpuccin.setup({
                transparent_background = true
            })
        end
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true
    },

    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
    },
    -- Using Lazy
    {
        "navarasu/onedark.nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('onedark').setup {
                style = 'cool'
            }
            -- Enable theme
            require('onedark').load()
        end
    },
    {
        'nyngwang/nvimgelion',
        config = function()
            -- do whatever you want for further customization~
        end
    }
}
