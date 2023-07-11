local M = {}

local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local wibox = require("wibox")

local globals = require('user.globals')
local awesome = globals.awesome
local client = globals.client


-- Signal function to execute when a new client appears.
function M.manage()
	client.connect_signal("manage",
		function (c)
			-- Set the windows at the slave,
			-- i.e. put it at the end of others instead of setting it master.
			-- if not awesome.startup then awful.client.setslave(c) end
			local user_position = c.size_hints.user_position
			local program_position = c.size_hints.program_position
			local startup = awesome.startup

			if startup and not user_position and not program_position then
				-- Prevent clients from being unreachable after screen count changes.
				awful.placement.no_offscreen(c)
			end
		end
	)
end


-- Add a titlebar if titlebars_enabled is set to true in the rules.
function M.request_titlebars(buttons)
	client.connect_signal("request::titlebars",
		function(c)
			local titlebars_buttons = buttons.titlebars(c)
			awful.titlebar(c):setup({
				{ -- Left
					awful.titlebar.widget.iconwidget(c),
					buttons = titlebars_buttons,
					layout  = wibox.layout.fixed.horizontal
				},
				{ -- Middle
					{ -- Title
						align  = "center",
						widget = awful.titlebar.widget.titlewidget(c)
					},
					buttons = titlebars_buttons,
					layout  = wibox.layout.flex.horizontal
				},
				{ -- Right
					-- awful.titlebar.widget.floatingbutton (c),
					-- awful.titlebar.widget.maximizedbutton(c),
					-- awful.titlebar.widget.stickybutton   (c),
					-- awful.titlebar.widget.ontopbutton    (c),
					awful.titlebar.widget.closebutton    (c),
					layout = wibox.layout.fixed.horizontal()
				},
				layout = wibox.layout.align.horizontal
			})
		end
	)
end


-- Enable sloppy focus, so that focus follows mouse.
function M.mouse_enter()
	client.connect_signal("mouse::enter",
		function(c)
			c:emit_signal(
				"request::activate",
				"mouse_enter",
				{ raise = false }
			)
		end
	)
end


function M.focus()
	client.connect_signal("focus",
		function(c)
			c.border_color = beautiful.border_focus
		end
	)
end


function M.unfocus()
	client.connect_signal("unfocus",
		function(c)
			c.border_color = beautiful.border_normal
		end
	)
end


function M.error()
	local in_error = false
	awesome.connect_signal("debug::error",
		function (err)
			-- Make sure we don't go into an endless error loop
			if in_error then return end
			in_error = true

			naughty.notify({
				preset = naughty.config.presets.critical,
				title = "Oops, an error happened!",
				text = tostring(err)
			})
			in_error = false
		end
	)
end


function M.setup(buttons)
	M.error()
	M.manage()
	M.request_titlebars(buttons)
	M.mouse_enter()
	M.focus()
	M.unfocus()
end


return M
