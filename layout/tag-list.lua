local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button(
        {},
        1,
        function(t)
            t:view_only()
        end
    ),
    awful.button(
        {modkey},
        1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),

    awful.button(
        {},
        3,
        awful.tag.viewtoggle
    ),

    awful.button(
        {modkey},
        3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    )
)

local TagList = function(s)
   return awful.widget.taglist { 
       screen  = s,
       filter  = awful.widget.taglist.filter.all,
       buttons = taglist_buttons
   }
end

return TagList
