local wezterm = require 'wezterm'
local projects = require 'projects'

local mux = wezterm.mux

-- wezterm.on("gui-startup", function()
--       local tab, pane, window = mux.spawn_window{}
--       window:gui_window():maximize()
-- end)

local function is_windows()
    return wezterm.target_triple:find("windows")
end

local function get_shell()
    if is_windows() then
        return { "pwsh.exe", "-NoLogo" }
    end

    return { "/bin/bash" }
end

local function get_fzf_command()
    if is_windows() then
        return { "pwsh.exe", "-NoLogo", "-Command", "fzf | ForEach-Object { nvim $_ }" }
    end
    return { 'bash', '-c', 'nvim "$(fzf)"' }
end

local function perform_open_tab(window, pane, title, opts)
        local action = wezterm.action.SpawnCommandInNewTab(opts)
        window:perform_action(action, pane)

        wezterm.time.call_after(0.2, function()
            local tab = window:active_tab()
            if tab then
                tab:set_title(title)
            end
        end)
end

local function open_tab_action(title, opts)
    wezterm.log_info("Opening tab " .. title)
    wezterm.log_info(opts)

     return wezterm.action_callback(function(window, pane)
        perform_open_tab(window, pane, title, opts)
    end)
end

local function open_fzf_action()
    local commands = get_fzf_command()
    return open_tab_action("fzf search", {args = commands})
end

local function get_projects_choices()
    local choices = {}
    for _, project in ipairs(projects) do
        table.insert(choices, { label = project.id .. " - " .. project.name, id = project.id })
    end

    return choices
end

local function get_project_by_id(id)
    for _, project in ipairs(projects) do
        if project.id == id then
            return project
        end
    end

    return nil
end

local function select_project()
    local choices =get_projects_choices()

    return wezterm.action_callback(function(window, pane)
        window:perform_action(
            wezterm.action.InputSelector {
                action = wezterm.action_callback(function(window2, pane2, id)
                    local project = get_project_by_id(id)
                    wezterm.log_info("select_project")
                    wezterm.log_info(project)
                    if project ~= nil then
                        perform_open_tab(window2, pane2, project.name, {cwd = project.path})
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
    default_prog = get_shell(),

    -- Appearance
    font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
    font_size = 14.0,
    color_scheme = "Catppuccin Mocha", -- You can change this to any built-in color scheme

    -- Tab bar settings
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,

    -- Window settings
    window_decorations = "RESIZE|TITLE",
    window_frame = {
        active_titlebar_bg = '#333333',
        inactive_titlebar_bg = '#222222',
    },
    window_padding = {
        left = 0,
        right = 0,
        top = 1,
        bottom= 0
    },
    window_background_opacity = 0.9, -- slight transparency
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
            action = open_fzf_action(),
        },
        {
            key = 'I',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.ShowDebugOverlay,
        }
    }
}
