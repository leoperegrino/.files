local M = {}

local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")

local globals = require('user.globals')
local awesome = globals.awesome
local client = globals.client
local modkey = globals.modkey
local terminal = globals.terminal


local global_keys = gears.table.join(
	awful.key(
		{ modkey },
		"s",
		hotkeys_popup.show_help,
		{ description="show help", group="awesome" }
	),
	awful.key(
		{ modkey },
		"Left",
		awful.tag.viewprev,
		{ description = "view previous", group = "tag" }
	),
	awful.key(
		{ modkey },
		"Right",
		awful.tag.viewnext,
		{ description = "view next", group = "tag" }
	),
	awful.key(
		{ modkey },
		"Escape",
		awful.tag.history.restore,
		{ description = "go back", group = "tag" }
	),
	awful.key(
		{ modkey },
		"j",
		function () awful.client.focus.byidx( 1) end,
		{description = "focus next by index", group = "client"}
	),
	awful.key(
		{ modkey },
		"k",
		function () awful.client.focus.byidx(-1) end,
		{ description = "focus previous by index", group = "client" }
	),
	-- Layout manipulation
	awful.key(
		{ modkey, "Shift"   },
		"j",
		function () awful.client.swap.byidx(  1)    end,
		{ description = "swap with next client by index", group = "client" }
	),
	awful.key(
		{ modkey, "Shift"   },
		"k",
		function () awful.client.swap.byidx( -1)    end,
		{ description = "swap with previous client by index", group = "client" }
	),
	awful.key(
		{ modkey, "Control" },
		"j",
		function () awful.screen.focus_relative( 1) end,
		{ description = "focus the next screen", group = "screen" }
	),
	awful.key(
		{ modkey, "Control" },
		"k",
		function () awful.screen.focus_relative(-1) end,
		{ description = "focus the previous screen", group = "screen" }
	),
	awful.key(
		{ modkey },
		"u",
		awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }
	),
	awful.key(
		{ modkey },
		"Tab",
		function ()
			awful.client.focus.history.previous()
			if client.focus then client.focus:raise() end
		end,
		{ description = "go back", group = "client" }
	),
	-- Standard program
	awful.key(
		{ modkey            },
		"Return",
		function () awful.spawn(terminal) end,
		{ description = "open a terminal", group = "launcher" }
	),
	awful.key(
		{ modkey, "Shift" },
		"r",
		awesome.restart,
		{ description = "reload awesome", group = "awesome" }
	),
	awful.key(
		{ modkey, "Shift"   },
		"q",
		awesome.quit,
		{ description = "quit awesome", group = "awesome" }
	),
	awful.key(
		{ modkey,           },
		"l",
		function () awful.tag.incmwfact( 0.05)          end,
		{ description = "increase master width factor", group = "layout" }
	),
	awful.key(
		{ modkey,           },
		"h",
		function () awful.tag.incmwfact(-0.05)          end,
		{ description = "decrease master width factor", group = "layout" }
	),
	awful.key(
		{ modkey, "Shift"   },
		"h",
		function () awful.tag.incnmaster( 1, nil, true) end,
		{ description = "increase the number of master clients", group = "layout" }
	),
	awful.key(
		{ modkey, "Shift"   },
		"l",
		function () awful.tag.incnmaster(-1, nil, true) end,
		{ description = "decrease the number of master clients", group = "layout" }
	),
	awful.key(
		{ modkey, "Control" },
		"h",
		function () awful.tag.incncol( 1, nil, true)    end,
		{ description = "increase the number of columns", group = "layout" }
	),
	awful.key(
		{ modkey, "Control" },
		"l",
		function () awful.tag.incncol(-1, nil, true)    end,
		{ description = "decrease the number of columns", group = "layout" }
	),
	awful.key(
		{ modkey,           },
		"space",
		function () awful.layout.inc( 1)                end,
		{ description = "select next", group = "layout" }
	),
	awful.key(
		{ modkey, "Shift"   },
		"space",
		function () awful.layout.inc(-1)                end,
		{ description = "select previous", group = "layout" }
	),
	awful.key(
		{ modkey, "Shift" },
		"n",
		function ()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal(
				"request::activate", "key.unminimize", {raise = true}
				)
			end
		end,
		{ description = "restore minimized", group = "client" }
	),
	-- Prompt
	awful.key(
		{ modkey            },
		"r",
		function () awful.screen.focused().mypromptbox:run() end,
		{ description = "run prompt", group = "launcher" }
	),
	awful.key(
		{ modkey            },
		"x",
		function ()
			awful.prompt.run {
				prompt       = "Run Lua code: ",
				textbox      = awful.screen.focused().mypromptbox.widget,
				exe_callback = awful.util.eval,
				history_path = awful.util.get_cache_dir() .. "/history_eval"
			}
		end,
		{ description = "lua execute prompt", group = "awesome" }
	)
	-- ),
	-- Menubar
	-- awful.key(
	-- 	{ modkey            },
	-- 	"p",
	-- 	function() menubar.show() end,
	-- 	{ description = "show the menubar", group = "launcher" }
	-- )
)


M.client_keys = gears.table.join(
	awful.key(
		{ modkey,           },
		"f",
		function (c) c.fullscreen = not c.fullscreen c:raise() end,
		{ description = "toggle fullscreen", group = "client" }
	),
	awful.key(
		{ modkey, },
		"q",
		function (c) c:kill() end,
		{ description = "close", group = "client" }
	),
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle                     ,
		{ description = "toggle floating", group = "client" }
	),
	awful.key(
		{ modkey, "Control" },
		"Return",
		function (c) c:swap(awful.client.getmaster()) end,
		{ description = "move to master", group = "client" }
	),
	awful.key(
		{ modkey,           },
		"o",
		function (c) c:move_to_screen() end,
		{ description = "move to screen", group = "client" }
	),
	awful.key(
		{ modkey,           },
		"t",
		function (c) c.ontop = not c.ontop end,
		{ description = "toggle keep on top", group = "client" }
	),
	awful.key(
		{ modkey,           },
		"n",
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		function (c) c.minimized = true end,
		{ description = "minimize", group = "client" }
	),
	awful.key(
		{ modkey,           },
		"m",
		function (c) c.maximized = not c.maximized c:raise() end ,
		{ description = "(un)maximize", group = "client" }
	),
	awful.key(
		{ modkey, "Control" },
		"m",
		function (c) c.maximized_vertical = not c.maximized_vertical c:raise() end ,
		{ description = "(un)maximize vertically", group = "client" }
	),
	awful.key(
		{ modkey, 'Mod1' },
		"#65", -- space keycode
		function (c) awful.titlebar.toggle(c) end,
		{ description = 'toggle title bar', group = 'client'}
	),
	awful.key(
		{ modkey, "Shift"   },
		"m",
		function (c) c.maximized_horizontal = not c.maximized_horizontal c:raise() end ,
		{ description = "(un)maximize horizontally", group = "client " }
	)
)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	global_keys = gears.table.join(
		global_keys,
		-- View tag only.
		awful.key(
			{ modkey                     },
			"#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{ description = "view tag #"..i, group = "tag" }
		),
		-- Toggle tag display.
		awful.key(
			{ modkey, "Control"          },
			"#" .. i + 9,
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			{ description = "toggle tag #" .. i, group = "tag" }
		),
		-- Move client to tag.
		awful.key(
			{ modkey, "Shift"            },
			"#" .. i + 9,
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{ description = "move focused client to tag #"..i, group = "tag" }
		),
		-- Toggle tag on focused client.
		awful.key(
			{ modkey, "Control", "Shift" },
			"#" .. i + 9,
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			{ description = "toggle focused client on tag #" .. i, group = "tag"}
		)
	)
end


local xf86 = gears.table.join(
	awful.key(
		{ },
		"XF86MonBrightnessDown",
		function () awful.spawn.with_shell('[ $(echo "$(xbacklight -get) > 9" | bc) -eq 1 ] && xbacklight -dec 9', false)
		end
	),
	awful.key(
		{ },
		"XF86MonBrightnessUp",
		function () awful.util.spawn("xbacklight -inc 9", false)
		end
	),
	awful.key(
		{ },
		"XF86AudioMicMute",
		function () awful.util.spawn("pamixer --default-source", false)
		end
	),
	awful.key(
		{ },
		"XF86AudioPrev",
		function () awful.util.spawn("mpc prev", false)
		end
	),
	awful.key(
		{ },
		"XF86AudioNext",
		function () awful.util.spawn("mpc next", false)
		end
	),
	awful.key(
		{ },
		"XF86AudioPause",
		function () awful.util.spawn("mpc toggle", false)
		end
	),
	awful.key(
		{ },
		"XF86AudioPlay",
		function () awful.util.spawn("mpc toggle", false)
		end
	),
	awful.key(
		{ },
		"XF86AudioMute",
		function () awful.util.spawn("pamixer -t", false)
		end
	),
	awful.key(
		{ },
		"XF86AudioLowerVolume",
		function () awful.util.spawn("pamixer -d 2", false)
		end
	),
	awful.key(
		{ },
		"XF86AudioRaiseVolume",
		function () awful.util.spawn("pamixer -i 2", false)
		end
	),
	awful.key(
		{ },
		"XF86Favorites",
		function () awful.util.spawn("randwp", false)
		end
	),
	awful.key(
		{ },
		"Print",
		function () awful.util.spawn("printscn", false)
		end
	)
)


M.global_keys = gears.table.join(
		awful.key(
			{ "Mod1" },
			"#65", -- space keycode
			function ()
				local myscreen = awful.screen.focused()
				myscreen.mywibox.visible = not myscreen.mywibox.visible
			end,
			{ description = "toggle statusbar" }
		),
		awful.key(
			{ modkey },
			"c",
			function () naughty.destroy_all_notifications() end,
			{ description = "close all notifications popup"}
		),
		global_keys,
		xf86
	)


return M
