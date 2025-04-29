return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires =  {"nvim-lua/plenary.nvim"},
    config = function ()
       local harpoon = require("harpoon")
        harpoon:setup()
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>hv", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    end
}
