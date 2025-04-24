return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = {},
    config = function()
        local map = vim.keymap;
        local options = {};
        local fzf = require('fzf-lua');
        map.set('n', 'gr', fzf.lsp_references, options)
        map.set('n', '<C-q>', fzf.lsp_code_actions, options)
        map.set('n', '<C-p>', fzf.files, options)
        map.set('n', '<C-e>', function()
            require('fzf-lua').lsp_workspace_diagnostics({
                min_severity = vim.diagnostic.severity.WARN,
                max_severity = vim.diagnostic.severity.ERROR,
            })
        end, options)
        map.set('n', '<C-f>', fzf.live_grep, options)
    end
}
