-- local awful = require('awful')
-- local beautiful = require('beautiful')
-- local wibox = require('wibox')
-- local gears = require('gears')

-- screen.connect_signal("request::wallpaper", function(s)
--     awful.wallpaper {
--         screen = s,
--         widget = {
--             {
--                 image  = gears.filesystem.get_random_file_from_dir(
--                     "~/Pictures/wallpapers/Anime",
--                     {},
--                     true
--                 ),
--                 resize = true,
--                 widget = wibox.widget.imagebox,
--             },
--             valign = "center",
--             halign = "center",
--             tiled  = false,
--             widget = wibox.container.tile,
--         }
--     }
-- end)