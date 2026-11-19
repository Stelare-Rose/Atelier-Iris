local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.enable_wayland = true

config.font = wezterm.font_with_fallback({
  { family = "MonaspiceNe Nerd Font Propo", weight = "Regular" },
  "Symbols Nerd Font",
})
config.font_size = 11

config.default_cursor_style = 'SteadyUnderline'
config.window_background_opacity = 0.92

config.color_schemes = {
  ['Milk Tea'] = {
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
  },
  ['Tiramisu'] = {
    background = '#403732',
    foreground = '#F0E8DA',
    cursor_bg = '#CCA3D6',
    cursor_fg = '#403732',
    cursor_border = '#DBB4D3',
    selection_fg = '#F8F4E9',
    selection_bg = '#6B564B',
    ansi = {
      '#383029',
      '#CF8282',
      '#9CCC96',
      '#E3CD7F',
      '#9BB0DE',
      '#DBB4D3',
      '#90CDDE',
      '#DECEC1',
    },
    brights = {
      '#6B564B',
      '#CF8282',
      '#99CFAC',
      '#D4A266',
      '#9BB0DE',
      '#EDB7CA',
      '#90CDDE',
      '#F8F4E9',
    },
  },
}

local scheme_file = os.getenv('HOME') .. '/.cache/camelia/color-scheme'
wezterm.add_to_config_reload_watch_list(scheme_file)

local function current_scheme()
  local file = io.open(scheme_file, 'r')
  if not file then
    return 'Milk Tea'
  end

  local value = file:read('*a')
  file:close()

  if value:find('dark') then
    return 'Tiramisu'
  end
  return 'Milk Tea'
end

config.color_scheme = current_scheme()

config.window_decorations = "NONE"
config.enable_tab_bar = false

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_content_alignment = {
  horizontal = 'Center',
  vertical = 'Center',
}

config.warn_about_missing_glyphs = false

local act = wezterm.action

wezterm.on('toggle-presentation-mode', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if not overrides.font_size then
    overrides.font_size = 20.0
  else
    overrides.font_size = nil
  end
  window:set_config_overrides(overrides)
end)

wezterm.on('toggle-solid-bg', function(window, pane)
  local overrides = window:get_config_overrides() or {}

  if overrides.window_background_opacity == 1.0 then
    overrides.window_background_opacity = nil
    overrides.colors = nil
  else
    overrides.window_background_opacity = 1.0
    overrides.colors = { background = '#302821' }
  end

  window:set_config_overrides(overrides)
end)

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
  { key = 'V', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
}

return config
