-- vim: foldmethod=marker
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

local keybindings = require('user.keybindings')
local buttons = require('user.buttons')
local signals = require('user.signals')
local rules = require('user.rules')
local ui = require('user.ui')
local globals = require('user.globals')
local awesome = globals.awesome
local root = globals.root

require("awful.autofocus")


if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors
	})
end


beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

awful.layout.layouts = {
	awful.layout.suit.max,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.tile,
	-- awful.layout.suit.tile.left,
	-- awful.layout.suit.tile.bottom,
	-- awful.layout.suit.tile.top,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	-- awful.layout.suit.magnifier,
	-- awful.layout.suit.corner.nw,
	-- awful.layout.suit.floating,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
beautiful.useless_gap = 3
beautiful.gap_single_client = true

function beautiful.wallpaper()
	local wallpaper = os.getenv('HOME') .. '/pictures/wallpapers/a80amql3wtw61.png'
	awful.spawn.with_shell("wal -n --backend colorz -i " .. wallpaper)
	return wallpaper
end

beautiful.font = 'Noto Sans Mono 11'

awful.spawn.with_shell("pgrep picom || picom")
awful.spawn.with_shell("pgrep sxhkd || sxhkd")
awful.spawn.with_shell("pgrep clipmenud || clipmenud")
awful.spawn.with_shell("autorandr vertical-reverse")
awful.spawn.with_shell("pgrep pasystray || pasystray")
awful.spawn.with_shell("sleep 2 && rfbt")
awful.spawn.with_shell("pgrep mpDris2 || mpDris2 -j")
awful.spawn.with_shell("pgrep nm-applet || nm-applet")


root.buttons(buttons.mouse)
root.keys(keybindings.global_keys)
ui.setup(buttons)

rules.setup(keybindings, buttons)

signals.setup(buttons)
