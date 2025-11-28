return
{
    "folke/snacks.nvim",
    enabled = false,
    ---@type snacks.Config
    config = function()
        local snacks = require("snacks")
        snacks.setup( -- lazy.nvim
            {
                -- explorer = {},
                notifier = {},
                lazygit = {},
                picker = {
                    hidden = true,
                    ignored = true,
                    sources = {
                         files = {
                            hidden = true,
                            ignored = true,
                            },
                        explorer = {
                            auto_close = true
                        }
                    }
                }
            }
        );


        vim.api.nvim_create_user_command("Git", function()
            snacks.lazygit.open();
        end, {})
    end

}
