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

  return { "/bin/zsh" }
end

local function get_fzf_command()
  if is_windows() then
    return "fzf | ForEach-Object { nvim $_ }"
  end
  return 'nvim "$(fzf)"'
end


local function get_fzf_open_dir_command()
  if is_windows() then
    return "not implemented yet, sorry"
  end
  return 'cd "$(find . -type d | fzf)"'
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

local function open_fzf_action()
  local commands = get_fzf_command()

  return wezterm.action_callback(function(window, pane)
    window:perform_action(wezterm.action.SendString(commands), pane)
  end)
end

local function open_fzf_directory()
  local commands = get_fzf_open_dir_command()

  return wezterm.action_callback(function(window, pane)
    window:perform_action(wezterm.action.SendString(commands), pane)
  end)
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
  local choices = get_projects_choices()

  return wezterm.action_callback(function(window, pane)
    window:perform_action(
      wezterm.action.InputSelector {
        action = wezterm.action_callback(function(window2, pane2, id)
          local project = get_project_by_id(id)
          wezterm.log_info("select_project")
          wezterm.log_info(project)
          if project ~= nil then
            perform_open_tab(window2, pane2, project.name, { cwd = project.path })
          end
        end),
        title = "Select a Project",
        choices = choices,
      },
      pane
    )
  end)
end


-- wezterm.on("gui-startup", function(cmd)
--   local _, _, window = wezterm.mux.spawn_window(cmd or {})
--   local screen = wezterm.gui.screens().active -- get active monitor info
--
--   -- leave 50px padding on each side
--   local margin = 150
--   local width = screen.width - (margin * 2)
--   local height = screen.height - (margin * 2)
--   local x = screen.x + margin
--   local y = screen.y + margin
--
--   window:gui_window():set_position(x, y)
--   window:gui_window():set_inner_size(width, height)
-- end)

return {
  -- Set your default shell (like PowerShell, cmd, or WSL)
  default_prog = get_shell(),

  -- Appearance
   font = wezterm.font("JetBrains Mono", { weight = "DemiBold" }),
  -- font = wezterm.font("FiraCode Nerd Font", { weight = "Regular" }),
  -- font = wezterm.font("Hack Nerd Font", { weight = "Regular" }),
  -- font = wezterm.font("Iosevka Term", { weight = "DemiBold" }),
  -- font_size = 22.0,

  -- font = wezterm.font("UbuntuMono Nerd Font", { weight = "Regular" }),
  -- font = wezterm.font("Mononoki Nerd Font", { weight = "Regular" }),
  -- font = wezterm.font("Maple Mono", { weight = "DemiBold" }),
  -- font = wezterm.font("Google Sans Code", { weight = "DemiBold" }),
  -- font = wezterm.font("Julia Mono", { weight = "Regular" }),
  -- font = wezterm.font("Monaspace Krypton NF", { weight = "Regular" }),
  -- font = wezterm.font("Monocraft", { weight = "DemiBold" }),
  font_size = 23.0,
  -- color_scheme = "Catppuccin Mocha", -- You can change this to any built-in color scheme
  -- color_scheme = "Catppuccin Latte", -- You can change this to any built-in color scheme
  -- color_scheme = "Kanagawa Dragon (Gogh)", -- You can change this to any built-in color scheme
  -- color_scheme = "Gruvbox dark, medium (base16)", -- You can change this to any built-in color scheme
  -- color_scheme = "Dracula",
  -- color_scheme = "Belge (terminal.sexy)",
  -- color_scheme = "synthwave",
  -- color_scheme = "sakura",
  -- color_scheme = "SynthwaveAlpha",
 -- color_scheme = 'Macintosh (base16)',
 -- color_scheme = 'Circus (base16)',
 color_scheme = 'tokyonight',
  -- Tab bar settings
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,

  -- Window settings
  window_decorations = "NONE",
  window_frame = {
    active_titlebar_bg = '#333333',
    inactive_titlebar_bg = '#222222',
  },
  window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5
  },
  window_background_opacity = 1, -- slight transparency
  initial_cols = 120,
  initial_rows = 30,
  warn_about_missing_glyphs = false,

  -- Key bindings
  keys = {
    {
      key = 's',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },
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
      key = "D",
      mods = "CTRL|SHIFT",
      action = open_fzf_directory(),
    },
    {
      key = 'I',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ShowDebugOverlay,
    }

  }
}
