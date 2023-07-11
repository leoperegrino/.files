local M = {}

local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local menubar = require("menubar")
local wibox = require("wibox")

local globals = require('user.globals')
local screen = globals.screen
local terminal = globals.terminal

-- local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
-- local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
-- local fs_widget = require("awesome-wm-widgets.fs-widget.fs-widget")


local function set_wallpaper(s)
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end


local function for_each_screen(buttons) return function(s)

	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.prompt_box = awful.widget.prompt()

	-- Create an imagebox widget which will contain an icon indicating
	-- which layout we're using. We need one layoutbox per screen.
	s.layout_box = awful.widget.layoutbox(s)
	s.layout_box:buttons(buttons.layout)

	s.taglist = awful.widget.taglist({
		screen  = s,
		filter  = awful.widget.taglist.filter.all,
		buttons = buttons.taglist
	})

	s.tasklist = awful.widget.tasklist({
		screen  = s,
		filter  = awful.widget.tasklist.filter.currenttags,
		buttons = buttons.tasklist,
		style    = {
			shape_border_width = 1,
			shape_border_color = '#777777',
			shape  = gears.shape.rounded_bar,
		}
	})

	s.wibox = awful.wibar({
		position = "top",
		screen = s
	})

	local text_clock = wibox.widget.textclock()

	local separator = wibox.widget.textbox("      ")

	local calendar = calendar_widget({
		placement = 'top_right',
		start_sunday = false,
		previous_month_button = 1,
		next_month_button = 3,
	})

	text_clock:connect_signal("button::press",
		function(_, _, _, button)
			if button == 1 then calendar.toggle() end
		end
	)

	s.wibox:setup({
		layout = wibox.layout.align.horizontal,
		-- Left widgets
		{
			layout = wibox.layout.fixed.horizontal,
			-- launcher,
			s.taglist,
			s.prompt_box,
		},
		-- Middle widget
		s.tasklist,
		-- Right widgets
		{
			layout = wibox.layout.fixed.horizontal,
			cpu_widget(),
			brightness_widget{
				margin = 30,
				type = 'arc',
				tooltip = true,
				program = 'xbacklight',
				step = 10,
			},
			separator,
			wibox.widget.systray(),
			text_clock,
			separator,
			batteryarc_widget(),
			logout_menu_widget(),
			s.layout_box,
		},
	})
end end


function M.setup(buttons)
	menubar.utils.terminal = terminal
	-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
	screen.connect_signal("property::geometry", set_wallpaper)
	awful.screen.connect_for_each_screen(for_each_screen(buttons))
end


return M
