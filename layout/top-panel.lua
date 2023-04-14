local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')

local dpi = require('beautiful').xresources.apply_dpi

local TagList = require('layout.tag-list')

-- Clock 24h format
local textclock = wibox.widget.textclock('<span font="12">%H:%M </span>')
-- Clock 12AM/PM format
-- local textclock = wibox.widget.textclock('<span font="12">%I:%M %p</span>')

local month_calendar = awful.widget.calendar_popup.month({
  screen = s,
  start_sunday = false,
  spacing = dpi(10),
  margin = dpi(2)
})
month_calendar:attach(textclock)

local systray = wibox.widget.systray()
  --systray:set_horizontal(true)
  --systray:set_base_size(20)
  --systray.forced_height = 20
--systray = wibox.container.margin(systray, dpi(3), dpi(6), dpi(6), dpi(3))


local LayoutBox = function(s)
    local layoutBox = awful.widget.layoutbox(s)

    layoutBox:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                end
            ),
            awful.button(
                {},
                4,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                5,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )

    return layoutBox
end

local TopPanel = function(s)
    -- Create the wibox
    local panel = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    panel:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            TagList(s)
        },
        nil,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            systray,
            textclock,
            LayoutBox(s)
        },
    }
    return panel
end

return TopPanel
