return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
        require("which-key").setup()
    end
}
