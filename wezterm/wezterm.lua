local wezterm = require 'wezterm'
local projects = require 'projects'

local function open_fzf()
    return wezterm.action_callback(function(window, pane)
        window:perform_action(
            wezterm.action.SpawnCommandInNewTab {
                 args = {"pwsh.exe", "-NoLogo", "-Command", "fzf | ForEach-Object { nvim $_ }"},
            },
            pane
        )
        wezterm.time.call_after(0.1, function()
            local tab = window:active_tab()
            if tab then
                tab:set_title("FZF Search")
            end
        end)
    end)
end

local function select_project()
    local choices = {}
    for _, project in ipairs(projects) do
        table.insert(choices, { label = project.id .. " - " .. project.name, id = project.id })
    end

    return wezterm.action_callback(function(window, pane)
        window:perform_action(
            wezterm.action.InputSelector {
                action = wezterm.action_callback(function(window2, pane2, id)
                    for _, project in ipairs(projects) do
                        if project.id == id then
                            window2:perform_action(
                                wezterm.action.SwitchToWorkspace {
                                    name = project.name,
                                },
                                pane2
                            )
                            window2:perform_action(
                                wezterm.action.SpawnCommandInNewTab {
                                    cwd = project.path,
                                    label = project.name
                                },
                                pane2
                            )
                            wezterm.time.call_after(0.1, function()
                                local tab = window2:active_tab()
                                if tab then
                                    tab:set_title(project.name)
                                end
                            end)
                        end
                    end
                end),
                title = "Select a Project",
                choices = choices,
            },
            pane
        )
    end)
end

return {
    -- Set your default shell (like PowerShell, cmd, or WSL)
    default_prog = { "pwsh.exe", "-NoLogo" },

    -- Appearance
    font = wezterm.font("JetBrainsMono Nerd Font Propo", { weight = "Bold" }),
    font_size = 14.0,
    color_scheme = "Catppuccin Mocha", -- You can change this to any built-in color scheme

    -- Tab bar settings
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = true,

    -- Window settings
    window_decorations = "RESIZE|TITLE",
    window_background_opacity = 0.95, -- slight transparency
    initial_cols = 120,
    initial_rows = 30,

    -- Key bindings
    keys = {
        { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
        { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab { confirm = true } },
        -- Move to previous tab
        {
            key = "h",
            mods = "CTRL|SHIFT",
            action = wezterm.action.ActivateTabRelative(-1),
        },
        -- Move to next tab
        {
            key = "l",
            mods = "CTRL|SHIFT",
            action = wezterm.action.ActivateTabRelative(1),
        },
        {
            key = "N",
            mods = "CTRL|SHIFT",
            action = select_project(),
        },
        {
            key = "F",
            mods = "CTRL|SHIFT",
            action = open_fzf(),
        },
    },
}
