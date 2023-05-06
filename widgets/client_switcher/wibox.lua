local wibox = require "wibox"

client_switcher = wibox.widget {
    {
        {
            text = "foo",
            widget = wibox.widget.textbox
        },
        {
            text = "bar",
            widget = wibox.widget.textbox
        },
        layout = wibox.layout.fixed.vertical
    },
    bg = "#ff0000",
    widget = wibox.container.background,
    x = 50,
    y = 50,
    screen = screen.focused,
    width = 500,
    height = 500,
    visible = true,
    ontop = true
}

-- client_switcher:setup {
    
-- }