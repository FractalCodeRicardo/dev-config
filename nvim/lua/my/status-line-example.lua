-- %f	File path
-- %F	Full file path
-- %t	Filename only
-- %m	Modified marker
-- %r	Read-only marker
-- %y	Filetype
-- %l	Line
-- %c	Column
-- %L	Total lines
-- %P	Percentage through file
-- %n	Buffer number
--
--Modes
--  n = "NORMAL",
-- i = "INSERT",
-- v = "VISUAL",
-- V = "V-LINE",
-- [""] = "V-BLOCK",
-- R = "REPLACE",
-- c = "COMMAND",
-- t = "TERMINAL",
--
--Separators
--  right-pointing solid
--   right-pointing thin
--   left-pointing solid
--   left-pointing thin

vim.api.nvim_set_hl(0, "GreenLine", {
    fg = "#ffffff",
    bg = "#009999"
})

vim.api.nvim_set_hl(0, "BlackLine", {
    fg = "#009999",
    bg = "#000000"
})

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

local function current_branch()
    local res = vim.fn.systemlist(
        "git branch --show-current"
    )

    if #res == 0 then
        return "None"
    end

   return "Branch: " .. res[1] 
end

local function lsp_name()
    local clients = vim.lsp.get_clients(
        {bufnr=0}
    )

    if #clients == 0 then
        return "No LSP"
    end

    return "LSP: " .. clients[1].name
end

_G.mode_name = mode_name
_G.current_branch = current_branch
_G.lsp_name = lsp_name

vim.o.statusline =
    "%#GreenLine# %{v:lua.mode_name()}  " ..
    "%#BlackLine# %{v:lua.current_branch()}  " ..
    "%#GreenLine# %f  " ..
    "%#BlackLine# %{v:lua.lsp_name()}  " ..
    "%#GreenLine# %= " ..
    "%l %c"
