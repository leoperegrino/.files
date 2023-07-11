local M = {}

local awful = require("awful")
local gears = require("gears")

local globals = require('user.globals')
local client = globals.client
local modkey = globals.modkey


M.layout = gears.table.join(
	awful.button({ }, 1, function () awful.layout.inc( 1) end),
	awful.button({ }, 3, function () awful.layout.inc(-1) end),
	awful.button({ }, 4, function () awful.layout.inc( 1) end),
	awful.button({ }, 5, function () awful.layout.inc(-1) end)
)


M.mouse = gears.table.join(
	-- awful.button({ }, 3, function () menu:toggle() end),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
)


-- Create a wibox for each screen and add it
M.taglist = gears.table.join(
	awful.button(
		{ },
		1,
		function(t) t:view_only() end
	),
	awful.button(
		{ modkey },
		1,
		function(t) if client.focus then client.focus:move_to_tag(t) end end
	),
	awful.button(
		{ },
		3,
		awful.tag.viewtoggle
	),
	awful.button(
		{ modkey },
		3,
		function(t) if client.focus then client.focus:toggle_tag(t) end end
	),
	awful.button(
		{ },
		4,
		function(t) awful.tag.viewnext(t.screen) end
	),
	awful.button(
		{ },
		5,
		function(t) awful.tag.viewprev(t.screen) end
	)
)


M.tasklist = gears.table.join(
	awful.button(
		{ },
		1,
		function (c)
			if c == client.focus then
				c.minimized = true
			else
				c:emit_signal( "request::activate", "tasklist", { raise = true })
			end
		end
	),
	awful.button(
		{ },
		3,
		function() awful.menu.client_list({ theme = { width = 250 } }) end
	),
	awful.button(
		{ },
		4,
		function () awful.client.focus.byidx(1) end
	),
	awful.button(
		{ },
		5,
		function () awful.client.focus.byidx(-1) end
	)
)


function M.titlebars(c) return gears.table.join(
	awful.button(
		{ },
		1,
		function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end
	),
	awful.button(
		{ },
		3,
		function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end
	)
)
end


M.client = gears.table.join(
	awful.button(
		{ },
		1,
		function (c) c:emit_signal("request::activate", "mouse_click", { raise = true }) end
	),
	awful.button(
		{ modkey },
		1,
		function (c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
			awful.mouse.client.move(c)
		end
	),
	awful.button(
		{ modkey },
		3,
		function (c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
			awful.mouse.client.resize(c)
		end
	)
)


return M
