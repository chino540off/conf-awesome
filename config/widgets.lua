local awful		= require("awful")
local beautiful		= require("beautiful")
local vicious		= require("vicious")
local naughty		= require("naughty")

require("config.notify")

-- {{{ Wibox
-- {{{ Reusable separators
spacer			= widget({ type = "textbox"  })
spacer.text		= " "

separator		= widget({ type = "textbox" })
separator.text		= " | "

awesomewidget		= widget({ type = "imagebox" })
awesomewidget.image	= image(beautiful.awesome_icon)
-- }}}
-- Create a textclock widget
dateicon		= widget({ type = "imagebox" })
dateicon.image		= image(beautiful.calendar_icon)

datewidget		= widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, "%b %d, %R", 60)

-- Create a systray
mysystray		= widget({ type = "systray" })

-- Create a battery Widget
baticon			= widget({ type = "imagebox" })
baticon.image		= image(beautiful.battery_3)
batwidget		= widget({ type = "textbox" })
batnotifier		= Notifier.create("Battery", beautiful.battery_3)
vicious.register(batwidget, vicious.widgets.bat,
	function (widget, args)
		if args[1] == "-" then
			icon_path = ""

			if args[2] >= 75 then
				icon_path = beautiful.battery_3
			elseif args[2] >= 50 then
				icon_path = beautiful.battery_2
			elseif args[2] >= 25 then
				icon_path = beautiful.battery_1
			else
				icon_path = beautiful.battery_0
			end

			baticon.image = image(icon_path)
			batnotifier:icon_set(icon_path)

			if args[2] == 60 then
				batnotifier:notify("60%, please plug me")
			elseif args[2] == 30 then
				batnotifier:warning("30%, please plug me")
			elseif args[2] == 10 then
				batnotifier:alert("10%, please plug me")
			end
		else
			baticon.image = image(beautiful.battery_charging)
		end

		return args[2] .. "%"
	end, 60, "BAT0")

-- {{{ Volume level
volicon = widget({ type = "imagebox" })
volicon.image = image(beautiful.sound_3)
---- Initialize widgets
volwidget = widget({ type = "textbox" })
-- Enable caching
--vicious.enable_caching(vicious.widgets.volume)
---- Register widgets
vicious.register(volwidget, vicious.widgets.volume, "$1%", 2, "Master -c 1")
-- }}}

-- Create a wibox for each screen and add it
mywiboxup = {}
mywiboxdown = {}
mypromptbox = {}
mylayoutbox = {}

--	}}}
--	{{{2 Taglist
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
	awful.button({				}, 1, awful.tag.viewonly),
	awful.button({ modkey			}, 1, awful.client.movetotag),
	awful.button({				}, 3, awful.tag.viewtoggle),
	awful.button({ modkey			}, 3, awful.client.toggletag),
	awful.button({				}, 4, awful.tag.viewnext),
	awful.button({				}, 5, awful.tag.viewprev)
)

--	}}}
--	{{{2 Tasklist
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
	awful.button({				}, 1,
		function (c)
			if not c:isvisible() then
				awful.tag.viewonly(c:tags()[1])
			end
			client.focus = c
			c:raise()
		end),
	awful.button({				}, 3,
		function ()
			if instance then
				instance:hide()
				instance = nil
			else
				instance = awful.menu.clients({ width=250 })
			end
		end),
	awful.button({				}, 4,
		function ()
			awful.client.focus.byidx(1)
			if client.focus then
				client.focus:raise()
			end
		end),
	awful.button({				}, 5,
		function ()
			awful.client.focus.byidx(-1)
			if client.focus then
				client.focus:raise()
			end
		end)
)

--	}}}
--	{{{2 Wibox creation
for s = 1, screen.count() do
	-- Create a promptbox for each screen
	mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	mylayoutbox[s] = awful.widget.layoutbox(s)
	mylayoutbox[s]:buttons(awful.util.table.join(
		awful.button({			}, 1, function () awful.layout.inc(layouts, 1) end),
		awful.button({			}, 3, function () awful.layout.inc(layouts, -1) end),
		awful.button({			}, 4, function () awful.layout.inc(layouts, 1) end),
		awful.button({			}, 5, function () awful.layout.inc(layouts, -1) end)
	))
	-- Create a taglist widget
	mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
	-- Create a tasklist widget
	mytasklist[s] = awful.widget.tasklist(
		function(c)
			return awful.widget.tasklist.label.currenttags(c, s)
		end,
		mytasklist.buttons)
	-- Create the wibox
	mywiboxup[s] = awful.wibox({ position = "top", screen = s, height = 20 })
	-- Add widgets to the wibox - order matters
	mywiboxup[s].widgets = {
		{
			--mylauncher,
			awesomewidget,
			mytaglist[s],
			mylayoutbox[s],
			mypromptbox[s],
			layout = awful.widget.layout.horizontal.leftright
		},
		s == 1 and mysystray or nil,
		separator, datewidget, spacer, dateicon,
		separator, volwidget, spacer, volicon,
		separator, batwidget, spacer, baticon,
		--separator, membar.widget, memicon,
		separator,
		-- FIXME: create a bottom wibox.
		--mytasklist[s],
		layout = awful.widget.layout.horizontal.rightleft
	}

	mywiboxdown[s] = awful.wibox({ position = "bottom", screen = s, height = 20 })
	mywiboxdown[s].widgets = {
		{
			awesomewidget,
			layout = awful.widget.layout.horizontal.leftright
		},
		-- FIXME: create a bottom wibox.
		mytasklist[s],
		layout = awful.widget.layout.horizontal.rightleft
	}

end


-- }}}
-- Compute the maximum number of digit we need, limited to 9
--keynumber = 0
--for s = 1, screen.count() do
--	keynumber = math.min(9, math.max(#tags[s], keynumber));
--end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.


-- Set keys
shifty.taglist = mytaglist
