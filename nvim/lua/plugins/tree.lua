-- return {
--   "nvim-tree/nvim-tree.lua",
--   version = "*",
--   lazy = false,
--   dependencies = {
--     "nvim-tree/nvim-web-devicons",
--   },
--   config = function()
--     require("nvim-tree").setup {}
--   end,
-- }
--
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "folke/tokyonight.nvim"
    },
    config = function()
        require("neo-tree").setup({
            highlight_group = "NeoTreeNormalNC",
            window = {
                width = 30
            },
            filesystem = {
                use_libuv_file_watcher = true,
                filtered_items = {
                    visible = true,
                }
            }
        })
        vim.keymap.set("n", "te", ":Neotree toggle<CR>", { noremap = true, silent = true })

        -- transparency in NeoTree
        vim.cmd([[
            highlight NeoTreeNormal guibg=NONE ctermbg=NONE
            highlight NeoTreeNormalNC guibg=NONE ctermbg=NONE
            highlight NeoTreeEndOfBuffer guibg=NONE ctermbg=NONE
        ]])
    end,
}
