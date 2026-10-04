
local suppressMaximizeRule = hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name           = "suppress-maximize-events",
  match          = { class = ".*" },

  suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})


-- Noctalia
-- Kitty
hl.window_rule({
  match = { class = "kitty" },
  float = true,
  center = true,
  size = { 1200, 600 },
})

-- Miniquad
hl.window_rule({
  match = { class = "miniquad-application" },
  float = true,
  center = true,
  size = { 800, 650 },
})

-- Ghostty
hl.window_rule({
  match = { class = "com.mitchellh.ghostty" },
  float = true,
  center = true,
  size = { 1400, 800 },
})


