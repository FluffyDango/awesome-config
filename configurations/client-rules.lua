local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')

-- Focus on clients when clicked
-- Move clients when holding modkey and left mouse button
-- Resize clients when holding modkey and right mouse button
local client_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

local client_keys = gears.table.join(
    awful.key(
      {modkey},
      'q',
      function()
        local c = _G.client.focus
        if c then
          c:kill()
        end
      end,
      {description = 'close client', group = 'client'}
    ),

    awful.key(
      {modkey},
      'f',
      function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      {description = 'toggle fullscreen', group = 'client'}
    )
)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { 
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = client_keys,
            buttons = client_buttons,
            screen = awful.screen.preferred,
            placement = awful.placement.centered+awful.placement.no_offscreen,
            size_hints_honor = false
        }
    },

    -- Floating clients.
    {
        rule_any = {
          instance = {
              "DTA",  -- Firefox addon DownThemAll.
              "copyq",  -- Includes session name in class.
              "pinentry",
          },
          class = {
              "Steam",
              "discord",
              "Arandr",
              "Blueman-manager",
              "Gpick",
              "Kruler",
              "MessageWin",  -- kalarm.
              "Sxiv",
              "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
              "Wpa_gui",
              "veromix",
              "xtightvncviewer"
          },

          -- Note that the name property shown in xprop might be set slightly after creation of the client
          -- and the name shown there might not match defined rules here.
          name = {
              "Event Tester",  -- xev.
          },
          role = {
              "AlarmWindow",  -- Thunderbird's calendar.
              "ConfigManager",  -- Thunderbird's about:config.
              "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          }
      },
      properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    { 
        rule_any = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = true }
    },

    -- Rules for making specific apps auto move to these tags
    -- usually 'class' works, but you can try 'instance' also
    {
        rule = { class = "Steam" },
        properties = { tag = "3" }
    },
    {
        rule = { class = "discord" },
        properties = { tag = "4" }
    },
    {
        rule = { instance = "teams" },
        properties = { tag = "4" }
    },
}
