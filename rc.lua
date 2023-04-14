-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
-- Give focus to new clients
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local dpi = require('beautiful').xresources.apply_dpi

_G.modkey = require('configurations.mod').modKey
_G.altkey = require('configurations.mod').altKey
require('configurations.client-rules')

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

require('layout')

-- NOTICE:
--
-- tags = workspaces = virtual desktops
-- root is the desktop
-- clients are apps such as firefox, terminal, etc.
-- naughty is notifications
-- wibox is the most primitive building block of awesomeWM
-- widgets are customized wibox
-- gears are libraries for lua
-- beautiful is theme configurations
-- 
-- awesomeWM has commands:
-- blocking -> synchronous (wait for command to finish),
-- non-blocking -> asynchronous (do not wait and keep executing)
--
-- Mouse keys - {
--      1 = left click
--      2 = middle click
--      3 = right click
--      4 = wheel up
--      5 = wheel down
-- }
--
-- use DPI whenever possible. It will allow the desktop to scale
--
-- LUA:
-- _G is a global variable. It is optional to write it, but I often do.
-- Lua has tables instead of arrays
-- string concatenation is done using '..'
-- Conventionally variables named '_' are variables that are not used.
-- if require('...') is a directory, then it searches for init.lua
--


-- Set keys
_G.root.keys(require("configurations.keys"))

-- Desktop mouse bindings
_G.root.buttons(gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end


-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}



-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)
