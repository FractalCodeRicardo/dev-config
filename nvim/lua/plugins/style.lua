return {
    {

        "folke/tokyonight.nvim",
        lazy = true,
        enabled = false,
        priority = 1000,
        config = function()
            local tokyo = require("tokyonight")
            tokyo.setup({
                transparent = true,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                },
                on_highlights = function(hl, c)
                    hl["@lsp.code.unused"] = { fg = c.comment, italic = true }
                end
            })
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
        enabled = true,
        lazy = false,
        name = "catppuccin",
        priority = 1000,
        config = function()
            local catpuccin = require("catppuccin")
            catpuccin.setup({
                flavour = "mocha",
                transparent_background = true
            })
        end
    },
    {
        "EdenEast/nightfox.nvim",
        enabled = true,
        lazy = false,
        config = function()
            local nightfox = require("nightfox");
            nightfox.setup({
                options = {
                    transparent = true
                }
            })
        end
    },

    {
        "scottmckendry/cyberdream.nvim",
        enabled = false,
        lazy = false,
        priority = 1000,
    },
    -- Using Lazy
    {
        "navarasu/onedark.nvim",
        enabled = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('onedark').setup {
                style = 'warmer'
            }
            -- Enable theme
            require('onedark').load()
        end
    },
    {
        'nyngwang/nvimgelion',
        enabled = false,
        config = function()
            -- do whatever you want for further customization~
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        enabled = false,
        config = function()
            local rose = require("rose-pine")
            rose.setup({
                -- disable_background = true,
            })
        end
    },
    {
        "rebelot/kanagawa.nvim",
        enabled = true,
        config = function()
            local kanagawa = require("kanagawa");
            kanagawa.setup({
                theme = "wave"
            })
        end
    },
    {
        "cpea2506/one_monokai.nvim",
        enabled = false
    },
    {
        'sainnhe/gruvbox-material',
        enabled = true,
        lazy = false,
        priority = 1000,
        config = function()
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.
            vim.g.gruvbox_material_enable_italic = true

            -- foreground option can be material, mix, or original
            vim.g.gruvbox_material_foreground = "material"

            --background option can be hard, medium, soft
            vim.g.gruvbox_material_background = "medium"
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_better_performance = 1
            vim.cmd.colorscheme('gruvbox-material')
        end
    },

    {
        "Tsuzat/NeoSolarized.nvim",
        enabled = false,
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
        end
    },
    {
        "daschw/leaf.nvim",
        enabled = false,
        config = function()
            local leaf = require("leaf");

            leaf.setup({
                contrast = "high",
                transparent = false
            })
        end
    }

}
