local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-------------
-- Appearance
-------------

config.color_scheme = 'catppuccin-mocha'
config.window_background_opacity = 0.85

-- Change saturation and lightness of inactive panes
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.5,
}

-------
-- Font
-------

config.use_ime = true
config.font_size = 14

-- Specify fonts with priority
config.font = wezterm.font_with_fallback({
  { family = "Hack Nerd Font" },
  { family = "0xProto" },
  { family = "Osaka" },
})

---------
-- Screen
---------

local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})

  -- Starts full screen from the begining
  window:gui_window():toggle_fullscreen()

  pane:split { direction = 'Bottom', size = 0.1 }
  pane:split { direction = 'Left', size = 0.9 }
end)

config.hide_tab_bar_if_only_one_tab = true

--------------
-- Key binding
--------------

local act = wezterm.action

config.keys = {
  {
    key = '|',
    mods = 'SHIFT|CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '_',
    mods = 'SHIFT|CMD',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'r',
    mods = 'SHIFT|CMD',
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },
  {
    key = 'z',
    mods = 'SHIFT|CMD',
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    key = 'h',
    mods = 'SHIFT|CMD',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'SHIFT|CMD',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'SHIFT|CMD',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'SHIFT|CMD',
    action = act.ActivatePaneDirection 'Down',
  },
}

-- Resize pane
-- 1. Press Shift+Cmd+'r' to enter resize mode
-- 2. Press 'h' or 'j' or 'k' or 'l' to resize
-- 3. Press Esc to exit resize mode
config.key_tables = {
  resize_pane = {
    { key = 'h', action = wezterm.action.AdjustPaneSize {"Left", 1} },
    { key = 'j', action = wezterm.action.AdjustPaneSize {"Down", 1} },
    { key = 'k', action = wezterm.action.AdjustPaneSize {"Up", 1} },
    { key = 'l', action = wezterm.action.AdjustPaneSize {"Right", 1} },
    { key = 'Escape', action = 'PopKeyTable' },
  },
}

return config

