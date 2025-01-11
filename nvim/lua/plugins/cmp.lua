return {
    {
        'hrsh7th/cmp-nvim-lsp',
        event = { "BufReadPre", "BufNewFile" },
        -- event = "VeryLazy",
    },
    {
        'hrsh7th/nvim-cmp',
        -- event = "VeryLazy",
        dependencies = {
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
        },
        config = function()
            local cmp = require 'cmp'
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'nvim_lsp_signature_help' }
                    },
                    {
                        { name = 'buffer' },
                        { name = 'path' }
                    })
            })
        end
    }
}
