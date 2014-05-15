local awful  = require("awful")
local shifty = require("shifty")

-- {{{ Key bindings
globalkeys = awful.util.table.join(
	awful.key({ modkey,			}, "Left",	awful.tag.viewprev),
	awful.key({ modkey,			}, "Right",	awful.tag.viewnext),
	awful.key({ modkey,			}, "Escape",	awful.tag.history.restore),

	awful.key({ modkey,			}, "Tab",	function ()
			awful.client.focus.byidx( 1)
			if client.focus then
				client.focus:raise()
			end
		end),
	-- awful.key({ modkey,           }, "k",
	--     function ()
	--         awful.client.focus.byidx(-1)
	--         if client.focus then client.focus:raise() end
	--     end),
	awful.key({ modkey,			}, "w",		function () mymainmenu:show(true) end),

	-- Layout manipulation
	awful.key({ modkey,			}, "Up",	function () awful.client.swap.byidx(1) end),
	awful.key({ modkey,			}, "Down",	function () awful.client.swap.byidx(-1) end),
	awful.key({ modkey, "Control"		}, "Tab",	function () awful.screen.focus_relative(1) end),
	awful.key({ modkey,			}, "u",		awful.client.urgent.jumpto),
	-- awful.key({ modkey,           }, "Tab",
	--     function ()
	--         awful.client.focus.history.previous()
	--         if client.focus then
	--             client.focus:raise()
	--         end
	--     end),

	-- Standard program
	awful.key({ modkey,			}, "Return",	function () awful.util.spawn(terminal) end),
	awful.key({ modkey, "Control"		}, "r",		awesome.restart),
	awful.key({ modkey, "Shift"		}, "q",		awesome.quit),

	awful.key({ modkey, "Control"		}, "Right",	function () awful.tag.incmwfact(0.05) end),
	awful.key({ modkey, "Control"		}, "Left",	function () awful.tag.incmwfact(-0.05) end),
	awful.key({ modkey, "Shift"		}, "h",		function () awful.tag.incnmaster(1) end),
	awful.key({ modkey, "Shift"		}, "l",		function () awful.tag.incnmaster(-1) end),
	awful.key({ modkey, "Control"		}, "h",		function () awful.tag.incncol(1) end),
	awful.key({ modkey, "Control"		}, "l",		function () awful.tag.incncol(-1) end),
	awful.key({ modkey,			}, "space",	function () awful.layout.inc(layouts,1) end),
	awful.key({ modkey, "Shift"		}, "space",	function () awful.layout.inc(layouts,-1) end),
	awful.key({ modkey,			}, "l",		function () awful.util.spawn("xtrlock") end),

	-- Prompt
	awful.key({ modkey			}, "r",		function () mypromptbox[mouse.screen]:run() end),
	awful.key({ modkey			}, "t",
		function ()
			awful.prompt.run({ prompt = "Tag Name: "},
			mypromptbox[mouse.screen].widget,
			function (s)
				shifty.add({ name = "[X. " .. s .. "]", rel_index = 1, persist = true })
			end)
		end),
	awful.key({ modkey			}, "x",		shifty.del)
)

-- Key loop
for i = 1, ( shifty.config.maxtags or 9 ) do
	table.foreach(awful.key({ modkey,			}, i,
		function () local t = awful.tag.viewonly(shifty.getpos(i)) end),
		function(_, k) table.insert(globalkeys, k) end)

	table.foreach(awful.key({ modkey, "Control"		}, i,
		function () local t = shifty.getpos(i); t.selected = not t.selected end),
		function(_, k) table.insert(globalkeys, k) end)

	table.foreach(awful.key({ modkey, "Control", "Shift"	}, i,
		function () if client.focus then awful.client.toggletag(shifty.getpos(i)) end end),
		function(_, k) table.insert(globalkeys, k) end)

	-- move clients to other tags
	table.foreach(awful.key({ modkey, "Shift"		}, i,
		function ()
			if client.focus then
				local c = client.focus
				slave = not ( client.focus == awful.client.getmaster(mouse.screen))
				t = shifty.getpos(i)
				awful.client.movetotag(t)
				awful.tag.viewonly(t)
				if slave then
					awful.client.setslave(c)
				end
			end
		end),
		function(_, k) table.insert(globalkeys, k) end)
end
-- }}}

root.keys(globalkeys)
shifty.config.globalkeys = globalkeys

