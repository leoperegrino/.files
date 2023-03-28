local fns = require('user.core.functions')

local fidget = require("fidget")

fns.hi.set('FidgetTitle', 'NONE', fns.hi.get_group('Title').fg)


fidget.setup {
	text = {
		spinner = "pipe",
		done = "✔",
		commenced = "Started",
		completed = "Completed",
	},
	align = {
		bottom = true,
		right = true,
	},
	timer = {
		spinner_rate = 125,
		fidget_decay = 2000,
		task_decay = 1000,
	},
	window = {
		relative = "win",
		blend = 100,
		zindex = nil,
	},
	fmt = {
		leftpad = true,
		stack_upwards = true,
		max_width = 0,
		fidget =                  -- function to format fidget title
			function(fidget_name, spinner)
				return string.format("%s %s", spinner, fidget_name)
			end,
		task =                    -- function to format each task line
			function(task_name, message, percentage)
				return string.format(
					"%s%s [%s]",
					message,
					percentage and string.format(" (%s%%)", percentage) or "",
					task_name
				)
			end,
	},
	sources = {
	},
	debug = {
		logging = false,
		strict = false,
	},
}
