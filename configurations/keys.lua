local awful = require('awful')
local gears = require('gears')
require('awful.autofocus')
local beautiful = require('beautiful')
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

local default_cmd = require('configurations.default-cmd')

local modkey = require('configurations.mod').modkey
local altkey = require('configurations.mod').altkey

--- Modifiers are in {...}
--- Keys are in '...'

--- Description and group only shows on Show help
--- Everything starting with _G is a global variable

-- Key bindings
awful.keyboard.append_global_keybindings({
  -------------------------------  AWESOME  ---------------------------------------------------
  awful.key({modkey}, 'F1', hotkeys_popup.show_help, {description = 'Show help', group = 'awesome'}),
  
  awful.key({modkey, 'Shift'}, 'r', _G.awesome.restart, {description = 'reload awesome', group = 'awesome'}),
  awful.key({modkey, 'Shift'}, 'q', _G.awesome.quit, {description = 'quit awesome', group = 'awesome'}),
  
  -------------------------------  HOTKEYS  ---------------------------------------------------
  -- Speakers
  awful.key(
    {'Control', 'Shift'},
    'F1',
    function()
       awful.spawn.with_shell("pactl set-default-sink alsa_output.usb-C-Media_Electronics_Inc._USB_PnP_Sound_Device-00.analog-stereo; " .. "pactl set-default-source alsa_input.usb-C-Media_Electronics_Inc._USB_PnP_Sound_Device-00.mono-fallback")
    end,
    {description = 'switch to speakers', group = 'hotkeys'}
  ),
  
  -- Headphones
  awful.key(
    {'Control', 'Shift'},
    'F2',
    function()
       awful.spawn.with_shell("pactl set-default-sink alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink; " .. "pactl set-default-source alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__source")
    end,
    {description = 'switch to headphones', group = 'hotkeys'}
  ),
  
  -- Screenshot
  awful.key(
    {},
    'Print',
    function()
      awful.spawn.with_shell(default_cmd.region_screenshot)
    end,
    {description = 'Screenshot an area', group = 'hotkeys'}
  ),

  awful.key(
    {'Control'},
    'Home',
    function()
        awful.spawn.with_shell(default_cmd.set_wallpaper)
    end,
    {description = 'Change background', group = 'hotkeys'}
  ),

  awful.key(
    {'Control'},
    '\\',
    function()
        awful.spawn.with_shell('nitrogen --random --set-zoom ~/Pictures/wallpapers/.pictures')
    end
  ), 

  awful.key(
    {modkey},
    'd',
    function()
        awful.spawn('passmenu') 
    end,
    {description = 'dmenu for pass', group = 'hotkeys'}
  ),
  
  
  -------------------------------  LAUNCHER  ---------------------------------------------------
  
  -- Browser
  awful.key(
    {modkey},
    'b',
    function()
      awful.util.spawn(default_cmd.browser)
    end,
    {description = 'Open browser', group = 'launcher'}
  ),

  -- Terminal
  awful.key(
    {modkey},
    'x',
    function()
      awful.spawn(default_cmd.terminal)
    end,
    {description = 'Open terminal', group = 'launcher'}
  ),
  
  -- File Manager
  awful.key(
    {modkey},
    'e',
    function()
      awful.spawn(default_cmd.file_explorer)
    end,
    {description = 'Open file browser', group = 'launcher'}
  ),
  
  -- Menu
  awful.key(
    {modkey},
    'r',
    function()
      awful.spawn(default_cmd.menu)
    end,
    {description = 'Open menu', group = 'launcher'}
  ),
  
  -------------------------------  LAYOUT  ---------------------------------------------------

  awful.key(
    {altkey, 'Shift'},
    'Right',
    function()
      awful.tag.incmwfact(0.05)
    end,
    {description = 'Increase master width factor', group = 'layout'}
  ),
  
  awful.key(
    {altkey, 'Shift'},
    'Left',
    function()
      awful.tag.incmwfact(-0.05)
    end,
    {description = 'Decrease master width factor', group = 'layout'}
  ),
  
  awful.key(
    {altkey, 'Shift'},
    'Down',
    function()
      awful.client.incwfact(0.05)
    end,
    {description = 'Decrease master height factor', group = 'layout'}
  ),
  
  awful.key(
    {altkey, 'Shift'},
    'Up',
    function()
      awful.client.incwfact(-0.05)
    end,
    {description = 'Increase master height factor', group = 'layout'}
  ),
  
  awful.key(
    {modkey, 'Shift'},
    'Left',
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    {description = 'Increase the number of master clients', group = 'layout'}
  ),
  
  awful.key(
    {modkey, 'Shift'},
    'Right',
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    {description = 'Decrease the number of master clients', group = 'layout'}
  ),
  
  awful.key(
    {modkey, 'Control'},
    'Left',
    function()
      awful.tag.incncol(1, nil, true)
    end,
    {description = 'Increase the number of columns', group = 'layout'}
  ),
  
  awful.key(
    {modkey, 'Control'},
    'Right',
    function()
      awful.tag.incncol(-1, nil, true)
    end,
    {description = 'Decrease the number of columns', group = 'layout'}
  ),
  
  awful.key(
    {modkey},
    'space',
    function()
      awful.layout.inc(1)
    end,
    {description = 'Select next', group = 'layout'}
  ),
  
  awful.key(
    {modkey, 'Shift'},
    'space',
    function()
      awful.layout.inc(-1)
    end,
    {description = 'Select previous', group = 'layout'}
  ) 
})

-------------------------------  ALT+TAB  ---------------------------------------------------

local hist_c
awful.keygrabber {
  keybindings = {
      {
          {altkey},
          "Tab",
          function ()
            --    awful.client.focus.history.previous()
              awful.client.focus.byidx(-1)
              local c = client.focus
              if c then
                  c:raise()
              end
            --    awful.client.focus.history.delete(c)
          end
      },
      {
          {altkey, "Shift"},
          "Tab",
          function ()
              awful.client.focus.byidx(1)
              if client.focus then
                  client.focus:raise()
              end
          end
      },
  },
  stop_key           = "Alt_L",
  stop_event         = "release",
  start_callback     = function ()
      --hist_c = client.focus
      --log_this(tostring(hist_c))
  end,
  stop_callback      = function ()
      --awful.client.focus.history.add(hist_c)
      --log_this(tostring(hist_c))
  end,
  export_keybindings = true,
}

  -------------------------------  TAG  ---------------------------------------------------

awful.keyboard.append_global_keybindings({
  awful.key {
    modifiers = { "Control", modkey },
    key = "z",
    on_press = function()
        local screen = awful.screen.focused()
        local tag = screen.tags[1]
        if tag then
            tag:view_only()
        end
    end,
    description = "Only view tag",
    group = "tag"
  },

  awful.key {
    modifiers = { "Control", modkey },
    key = "x",
    on_press = function()
        local screen = awful.screen.focused()
        local tag = screen.tags[2]
        if tag then
            tag:view_only()
        end
    end,
    description = "Only view tag",
    group = "tag"
  },

  awful.key {
    modifiers = { "Control", modkey },
    key = "c",
    on_press = function()
        local screen = awful.screen.focused()
        local tag = screen.tags[3]
        if tag then
            tag:view_only()
        end
    end,
    description = "Only view tag",
    group = "tag"
  },

  awful.key {
    modifiers = { "Control", modkey },
    key = "v",
    on_press = function()
        local screen = awful.screen.focused()
        local tag = screen.tags[4]
        if tag then
            tag:view_only()
        end
    end,
    description = "Only view tag",
    group = "tag"
  },

  awful.key {
    modifiers = { "Control", modkey },
    key = "b",
    on_press = function()
        local screen = awful.screen.focused()
        local tag = screen.tags[5]
        if tag then
            tag:view_only()
        end
    end,
    description = "Only view tag",
    group = "tag"
  },


  awful.key {
    modifiers = { "Control", altkey },
    key = "z",
    on_press = function()
        if client.focus then
            local tag = client.focus.screen.tags[1]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end,
    description = "Switch client to tag",
    group = "tag"
  },

  awful.key {
    modifiers = { "Control", altkey },
    key = "x",
    on_press = function()
        if client.focus then
            local tag = client.focus.screen.tags[2]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end,
    description = "Switch client to tag",
    group = "tag"
  },

  awful.key {
    modifiers = { "Control", altkey },
    key = "c",
    on_press = function()
        if client.focus then
            local tag = client.focus.screen.tags[3]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end,
    description = "Switch client to tag",
    group = "tag"
  },

  awful.key {
    modifiers = { "Control", altkey },
    key = "v",
    on_press = function()
        if client.focus then
            local tag = client.focus.screen.tags[4]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end,
    description = "Switch client to tag",
    group = "tag"
  },

  awful.key {
    modifiers = { "Control", altkey },
    key = "b",
    on_press = function()
        if client.focus then
            local tag = client.focus.screen.tags[5]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end,
    description = "Switch client to tag",
    group = "tag"
  },


  --awful.key {
  --    modifiers   = { modkey },
  --    keygroup    = "numrow",
  --    description = "only view tag",
  --    group       = "tag",
  --    on_press    = function (index)
  --        local screen = awful.screen.focused()
  --        local tag = screen.tags[index]
  --        if tag then
  --            tag:view_only()
  --        end
  --    end,
  --},
  --awful.key {
  --    modifiers = { modkey, "Shift" },
  --    keygroup    = "numrow",
  --    description = "move focused client to tag",
  --    group       = "tag",
  --    on_press    = function (index)
  --        if client.focus then
  --            local tag = client.focus.screen.tags[index]
  --            if tag then
  --                client.focus:move_to_tag(tag)
  --            end
  --        end
  --    end,
  --}
})
