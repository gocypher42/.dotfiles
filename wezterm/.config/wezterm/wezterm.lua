local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()
config.window_close_confirmation = 'NeverPrompt'

-- font settings
config.font_size = 13
config.line_height = 1.2
-- wezterm.font("JetBrainsMono Nerd Font")
config.font = wezterm.font ('FiraMono Nerd Font')

-- Cursor
config.colors = {
  cursor_bg = "white",
  cursor_border = "white",
}

-- Appearance
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.6,
}

-- Miscellaneous settings
config.max_fps = 120
config.default_prog = { "pwsh.exe", "-nologo" }

-- Keybinds
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  { key = "w", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = false }) },

  -- splits
  { key = "=", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "_", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

  -- moving between panes
  { key = "LeftArrow", mods = "ALT", action = act.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "ALT", action = act.ActivatePaneDirection("Right") },
  { key = "UpArrow", mods = "ALT", action = act.ActivatePaneDirection("Up") },
  { key = "DownArrow", mods = "ALT", action = act.ActivatePaneDirection("Down") },

  -- resize panes
  { key = "LeftArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }), repeatable = true },
  { key = "DownArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }), repeatable = true },
  { key = "UpArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }), repeatable = true },
  { key = "RightArrow", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }), repeatable = true },
}

return config
