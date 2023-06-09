local awful = require('awful')
local gears = require('gears')
--local icons = require('theme.icons')

--local tags = {
--  {
--    icon = icons.chrome,
--    type = 'chrome',
--    screen = 1
--  },
--  {
--    icon = icons.code,
--    type = 'code',
--    screen = 1
--  },
--  {
--    icon = icons.social,
--    type = 'social',
--    screen = 1
--  },
--  {
--    icon = icons.game,
--    type = 'game',
--    screen = 1
--  },
--  {
--    icon = icons.folder,
--    type = 'files',
--    screen = 1
--  },
--  {
--    icon = icons.music,
--    type = 'music',
--    screen = 1
--  },
--  {
--    icon = icons.lab,
--    type = 'any',
--    screen = 1
--  }
--}

tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts({
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating
  })
end)

awful.screen.connect_for_each_screen(
    function(s)
        --for i, tag in pairs(tags) do
        for i=1, 9, 1 do
            awful.tag.add(
                i,
                {
                    --icon = tag.icon,
                    --icon_only = true,
                    layout = awful.layout.suit.tile,
                    gap_single_client = false,
                    gap = 4,
                    screen = s,
                    selected = i == 1
                }
            )
        end
    end
)
