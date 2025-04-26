return {
    "ibhagwan/fzf-lua",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local map = vim.keymap;
        local options = {};
        local fzf = require('fzf-lua')

        fzf.setup({
                winopts = { preview = { layout = "vertical" } }
            }
        )

        map.set('n', 'gr', fzf.lsp_references, options)
        map.set('n', '<C-q>', fzf.lsp_code_actions, options)

        map.set('n', '<C-p>', fzf.files, options)
        map.set('n', '<C-g>', fzf.live_grep, options)
        map.set('n', '<C-f>', fzf.grep_curbuf, options)

        map.set('n', '<C-e>', function()
            fzf.lsp_workspace_diagnostics({
                min_severity = vim.diagnostic.severity.WARN,
                max_severity = vim.diagnostic.severity.ERROR,
            })
        end, options)

        fzf.register_ui_select();
    end
}
