local awful = require('awful')

local modkey = require('configurations.mod').modkey
local altkey = require('configurations.mod').altkey

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key(
            { modkey },
            "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}
        ),

        awful.key(
            { modkey },
            "q",
            function (c)
                c:kill()
            end,
            {description = "close", group = "client"}
        ),

        awful.key(
            { modkey, "Control" },
            "space", 
            awful.client.floating.toggle                     ,
            {description = "toggle floating", group = "client"}
        ),

        awful.key(
            { modkey },
            "o",
            function (c)
                c:move_to_screen()
            end,
            {description = "move to screen", group = "client"}
        ),

        awful.key(
            { modkey },
            "t",
            function (c)
                c.ontop = not c.ontop
            end,
            {description = "toggle keep on top", group = "client"}
        ),

        awful.key(
            { modkey },
            "Up",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end,
            {description = "(un)maximize", group = "client"}
        ),
    })
end)