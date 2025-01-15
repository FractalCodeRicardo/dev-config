return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
           local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
            require("toggleterm").setup({
                open_mapping = [[<c-t>]],
                shell = is_windows and "pwsh" or "/bin/bash"
            })
        end
    }
}
