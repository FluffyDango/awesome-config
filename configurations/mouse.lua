local awful = require("awful")

-- Desktop mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
})