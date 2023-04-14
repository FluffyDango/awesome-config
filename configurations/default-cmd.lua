local filesystem = require('gears.filesystem')
local with_dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi

local rofi_command = 'env /usr/bin/rofi -dpi ' .. get_dpi() .. ' -width ' .. with_dpi(400) .. ' -show drun -theme ' .. filesystem.get_configuration_dir() .. '/theme/rofi.rasi -run-command "/bin/bash -c -i \'shopt -s expand_aliases; {cmd}\'" -no-config -drun-match-fields name -no-tokenize'

return {
    terminal = 'gnome-terminal',
    browser = 'firefox',
    file_explorer = 'nemo',
    menu = rofi_command,
    region_screenshot = 'flameshot gui',
    fullscreen_screenshot = 'flameshot screen -p ~/Pictures/screenshots',
    set_wallpaper = 'nitrogen --random --set-zoom --save ~/Pictures/wallpapers/Anime'

}
