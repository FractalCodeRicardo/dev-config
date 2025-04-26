return
-- lazy.nvim
{
    "folke/snacks.nvim",
    ---@type snacks.Config
    config = function()
        local snacks = require("snacks")
        snacks.setup( -- lazy.nvim
            {
                explorer = {},
                dashboard = {},
                lazygit = {},
                picker = {
                    sources = {
                        explorer = {
                                auto_close = true
                        }
                    }
                }
            }
        );

        local map = vim.keymap;
        map.set('n',"te", function()
            snacks.explorer()
        end, {})
    end

}
