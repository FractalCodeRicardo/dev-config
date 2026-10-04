terminal    = "kitty"
fileManager = "thunar"
menu        = "wofi --show run"
mainMod = "SUPER" 

hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia")
  --hl.exec_cmd("waybar")
  --hl.exec_cmd("hyprpaper")
end)

hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "1.2",
})


hl.config({
  general = {
    gaps_in = 3,
    gaps_out = 8,
    border_size = 1,
    col = {
      active_border = {
        colors = {
          -- "rgba(d79921ff)", -- Gruvbox yellow
          -- "rgba(fe8019ff)", -- Gruvbox orange
          --
          -- "rgba(6b03fcff)", -- Tokyo night
          -- "rgba(6b03fcee)",
          --
          -- "rgba(348c04ff)",  -- Lemon green
          -- "rgba(348c04ee)",  -- Slight transparency
          --
            "rgba(b79cedff)",
            "rgba(b79cedcc)",
        },
        angle = 1,
      },
      inactive_border = "rgba(00000011)",
    },
  },

  decoration = {
    rounding = 12,
    rounding_power = 5,
    active_opacity = 1,
    inactive_opacity = 0.90,

    shadow = {
      enabled = true,
      range = 1,
      render_power = 1,
      color = 0xee1a1a1a,
    },

    blur = {
      enabled = true,
      size = 1,
      passes = 1,
      vibrancy = 0.1696,
      ignore_opacity = false,
      xray = false
    },
  },
})

require("animations")
require("keyboard")
require("multimedia")
require("noctalia")
require("rules")


