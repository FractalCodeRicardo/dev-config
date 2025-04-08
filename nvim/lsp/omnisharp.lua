local capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
    cmd = {
        "omnisharp",
        "--languageserver",
        "--hostPID", tostring(vim.fn.getpid())
    },
     capabilities = capabilities,
    filetypes = { 'cs', 'vb' },
    root_markers = {".sln"}
}
