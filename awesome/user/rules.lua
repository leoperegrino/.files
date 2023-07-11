-- Rules to apply to new clients (through the "manage" signal).
local M = {}

local awful = require("awful")
local beautiful = require("beautiful")


function M.setup(keybindings, buttons)
	local no_overlap = awful.placement.no_overlap
	local no_offscreen = awful.placement.no_offscreen

	-- All clients will match this rule.
	local all = {
		rule = { },
		properties = {
			size_hints_honor = false,
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = keybindings.client_keys,
			buttons = buttons.client,
			screen = awful.screen.preferred,
			placement = no_overlap + no_offscreen
		}
	}

    -- Floating clients.
	local floating = {
		rule_any = {
			instance = {
				"DTA",    -- Firefox addon DownThemAll.
				"copyq",  -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin",  -- kalarm.
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer"
			},
			-- Note that the name property shown in xprop might be set
			-- slightly after creation of the client and the name shown
			-- there might not match defined rules here.
			name = {
				"Event Tester",  -- xev.
			},
			role = {
				"AlarmWindow",   -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
			}
		},
		properties = { floating = true }
	}

	-- Add titlebars to normal clients and dialogs
	local titlebars = {
		rule_any = {
			type = { "normal", "dialog" }
		},
		properties = { titlebars_enabled = false }
	}


	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- local firefox = {
	-- 	rule = {
	-- 		class = "Firefox"
	-- 	},
	-- 	properties = { screen = 1, tag = "2" }
	-- },

	awful.rules.rules = {
		all,
		floating,
		titlebars,
	}
end


return M
