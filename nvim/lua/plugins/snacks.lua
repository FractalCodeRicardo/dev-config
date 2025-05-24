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
                notifier = {},
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
        map.set('n', "te", function()
            snacks.explorer()
        end, {})

        vim.api.nvim_create_user_command("Git", function()
            snacks.lazygit.open();
        end, {})
    end

}
