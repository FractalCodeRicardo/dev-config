return {
    'feline-nvim/feline.nvim',
    branch = '0.5-compat',
    config = function()
        require("feline").setup()
    end
}
