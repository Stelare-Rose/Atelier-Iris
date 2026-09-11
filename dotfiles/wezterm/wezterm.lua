local wezterm = require 'wezterm'
local config = {}

-- Font
config.font = wezterm.font("MonaspiceNe Nerd Font Propo", {weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 11

-- Colours and Background
config.default_cursor_style = 'SteadyUnderline'
config.window_background_opacity = 0.92
config.colors = {
	background = '#F7F4E9',
	foreground = '#3B3B3B',
	cursor_bg = '#CCA3D6',
	cursor_fg = '#F7F4E9',
	cursor_border = '#DBB4D3',
	selection_fg = '#2E2E2E',
	selection_bg = '#DBB4D3',
	ansi = {
		'#3B3B3B',
		'#BC6262',
		'#8CB372',
		'#D6BF6D',
		'#8099D1',
		'#D38EC5',
		'#77BBD0',
		'#D8D1BE',
	},
	brights = {
		'#3B3B3B',
		'#B55354',
		'#81B062',
		'#CCB256',
		'#6E88C3',
		'#C776B8',
		'#60ABC2',
		'#D8D1BE',
	},
}
-- Window Decor
config.window_decorations = "NONE"
config.enable_tab_bar = false

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0 
}
config.window_content_alignment = {
  horizontal = 'Center',
  vertical = 'Center',
}
-- Settings
config.warn_about_missing_glyphs = false

-- Actions
local act = wezterm.action

-- Presentation Mode
wezterm.on('toggle-presentation-mode', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.font_size then
    overrides.font_size = 20.0
  else
    overrides.font_size = nil
  end
  window:set_config_overrides(overrides)
end)

-- Black Solid Background
wezterm.on('toggle-solid-bg', function(window, pane)
  local overrides = window:get_config_overrides() or {}

  if overrides.window_background_opacity == 1.0 and overrides.colors and overrides.colors.background == '#38312d' then
    -- revert back to your normal config (clear overrides)
    overrides.window_background_opacity = nil
    overrides.colors = nil
  else
    overrides.window_background_opacity = 1.0
    overrides.colors = { background = '#302821' }
  end

  window:set_config_overrides(overrides)
end)

-- Keybinds
config.keys = {
  {
    key = 'P',
    mods = 'CTRL|SHIFT',
    action = act.EmitEvent 'toggle-presentation-mode',
  },
  {
    key = 'B',
    mods = 'CTRL|SHIFT',
    action = act.EmitEvent 'toggle-solid-bg',
  },
}


return config
