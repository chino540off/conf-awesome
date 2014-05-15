local awful  = require("awful")
local shifty = require("shifty")

-- {{{ Key bindings
-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
clientkeys = awful.util.table.join(
	awful.key({ modkey,			}, "f",		function (c) c.fullscreen = not c.fullscreen end),
	awful.key({ modkey, "Shift"		}, "c",		function (c) c:kill() end),
	awful.key({ modkey, "Control"		}, "space",	awful.client.floating.toggle),
	awful.key({ modkey, "Control"		}, "Return",	function (c) c:swap(awful.client.getmaster()) end),
	awful.key({ modkey,			}, "o",		awful.client.movetoscreen),
	awful.key({ modkey, "Shift"		}, "r",		function (c) c:redraw() end),
	awful.key({ modkey,			}, "n",		function (c) c.minimized = not c.minimized end),
	awful.key({ modkey,			}, "m",		function (c)
			c.maximized_horizontal = not c.maximized_horizontal
			c.maximized_vertical   = not c.maximized_vertical
		end)
)

clientbuttons = awful.util.table.join(
	awful.button({				}, 1,		function (c) client.focus = c; c:raise() end),
	awful.button({ modkey			}, 1,		awful.mouse.client.move),
	awful.button({ modkey			}, 3,		awful.mouse.client.resize)
)

-- }}}

shifty.config.clientkeys = clientkeys
