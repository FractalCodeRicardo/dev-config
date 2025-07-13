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
            -- vim.cmd.colorscheme("tokyonight")
            -- vim.cmd.colorscheme("tokyonight-night")
            -- vim.cmd.colorscheme("tokyonight-storm")
            -- vim.cmd.colorscheme("tokyonight-moon")
            -- vim.cmd.colorscheme("tokyonight-day")

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
        lazy = false
    },

    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
    },
    -- Using Lazy
    {
        "navarasu/onedark.nvim",
        enable = false,
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
        enable = false,
        config = function()
            -- do whatever you want for further customization~
        end
    },
    {
	"rose-pine/neovim",
	name = "rose-pine",
        enable = false,
        config = function()
            local rose = require("rose-pine")
            rose.setup({
                -- disable_background = true,
            })

            -- vim.cmd("colorscheme rose-pine")
            -- vim.cmd("colorscheme rose-pine-main")
            -- vim.cmd("colorscheme rose-pine-moon")
            vim.cmd("colorscheme rose-pine-dawn")
        end

    }
}
