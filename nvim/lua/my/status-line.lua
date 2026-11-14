local function mode_name()
    local names = {
        n = "NORMAL",
        i = "INSERT",
        v = "VISUAL",
        V = "V-LINE",
        [""] = "V-BLOCK",
        R = "REPLACE",
        c = "COMMAND",
        t = "TERMINAL",
    }
    return names[vim.fn.mode()]
end

_G.status_line_mode_name = mode_name


vim.o.statusline =
    "%{v:lua.status_line_mode_name()}  " ..
    "%f  " ..
    "%= " ..
    "%l %c"
