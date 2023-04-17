local naughty = require('naughty')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi

-- Naughty presets
naughty.config.padding = 8
naughty.config.spacing = 8

naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = 1
naughty.config.defaults.position = 'bottom_left'
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.ontop = true
naughty.config.defaults.font = 'Roboto Regular 10'
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.shape = gears.shape.rounded_rect
naughty.config.defaults.border_width = 0
naughty.config.defaults.hover_timeout = nil

naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
      urgency = "critical",
      title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
      message = message
  }
end)

function log_this(text, title)
  title = title or ""
  naughty.notification(
    {
      title = 'Log: ' .. title,
      text = text
    }
  )
end
