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
-- For debugging you can use global function log_this("message")
-- It is declared in notifications


-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Give focus to new clients
require("awful.autofocus")

local gears = require('gears')
local beautiful = require("beautiful")

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

require('configurations.notifications')
require('configurations.rules')
require('configurations.client')
require('configurations.keys')
require('configurations.mouse')
require('configurations.wallpaper')

require "widgets.client_switcher"

require('layout')
