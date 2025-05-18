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
                notifier= {},
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


        map.set('n',"gg", function()
            snacks.lazygit.open();
        end, {})
    end

}
