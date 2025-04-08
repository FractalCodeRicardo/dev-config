return {
    cmd = { "lua-language-server" },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" } -- Recognizes `vim` as a global to avoid warnings
            }
        }
    }
}
