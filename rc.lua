-- {{{ Includes
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("vicious")
-- Load Debian menu entries
require("debian.menu")
-- Custom libraries
require("revelation")
require("shifty")
require("wicked")
require("teardrop")



-- }}}
-- {{{ Variables definition
-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/themes/theme.lua")

-- Variables
terminal = "urxvtc"
browser="chromium-browser"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4"
modkey2 = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,		-- 1
    -- awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,	-- 2
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,		-- 3 
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,		-- 4
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.floating
}



-- }}}
-- {{{ Tags
-- {{{2 Tags definition
shifty.config.tags =
{
    ["[1. code]"] =   { layout = layouts[4],	position = 1, nopopup=true,	exclusive=false,	spawn="gvim --servername 1"},
    ["[2. sh]"] =     { layout = layouts[1],	position = 2, init = true, 				spawn=terminal},
    ["[3. misc]"] =   { layout = layouts[1],	position = 3, nopopup=true,	exclusive=true},
    ["[4. doc]"] =    { layout = layouts[4],	position = 4},
    ["[5. im]"] =     { layout = layouts[1],	position = 5, nopopup=true,	exclusive=true},
    ["[6. www]"] =    { layout = layouts[4],	position = 6, nopopup=true,	exclusive=false,	spawn = browser},
    ["[7. zik]"] =    { layout = layouts[4],	position = 7, nopopup=true,	exclusive=true},
    ["[8. media]"] =  { layout = layouts[1],	position = 8, nopopup=false,	exclusive=false},
    --["[default]"] =   { layout = layouts[1],	position = 9, init = true,				spawn=terminal}
}
-- }}}
-- {{{2 Applications
shifty.config.apps = {

	 { match = {"Gvim", "gvim" },      		tag = "[1. code]",	opacity = 0.90 },
	 { match = {terminal},				tag = "[2. sh]",	opacity = 0.85},
	 { match = {"Evince", "evince" },		tag = "[4. doc]",	opacity = 1.0 },
         { match = {"Pidgin"},				tag = "[5. im]",	float = true },
         { match = {"Chromium", browser} ,		tag = "[6. www]",	opacity = 0.95 } ,
	 { match = {"spotify"},				tag = "[7. zik]",	opacity = 1.0 },
	 { match = {"vlc"},				tag = "[8. media]",	opacity = 1.0 },
         { match = { "" },
			buttons = awful.util.table.join(
			awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
			awful.button({ modkey }, 1, awful.mouse.client.move),
			awful.button({ modkey }, 3, awful.mouse.client.resize),
			awful.button({ modkey }, 8, awful.mouse.client.resize))
  }
}
-- }}}
-- {{{2 Default layout
shifty.config.defaults = {
  layout = awful.layout.suit.tile,
  ncol = 1,
  mwfact = 0.50,
  floatBars=false,
}
-- }}}




-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu =
{
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu(
{
	items =
	{
		{ "awesome", myawesomemenu, beautiful.awesome_icon },
                { "Debian", debian.menu.Debian_menu.Debian },
		{ "open terminal", terminal }
        }
})

mylauncher = awful.widget.launcher(
{
	image = image(beautiful.awesome_icon),
	menu = mymainmenu
})



-- }}}
-- {{{ Wibox
-- {{{ Reusable separators
spacer			= widget({ type = "textbox"  })
spacer.text		= " "
separator		= widget({ type = "imagebox" })
separator.image		= image(beautiful.widget_sep)
awesomewidget		= widget({ type = "imagebox" })
awesomewidget.image	= image(beautiful.awesome_icon)
-- }}}
-- Create a textclock widget
dateicon		= widget({ type = "imagebox" })
dateicon.image		= image(beautiful.widget_date)
datewidget		= widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, "%R", 61)

-- Create a systray
mysystray		= widget({ type = "systray" })

-- Create a battery Widget
baticon			= widget({ type = "imagebox" })
baticon.image		= image(beautiful.widget_bat)
batwidget		= widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat, "$2%", 60, "BAT0")

-- {{{ Volume level
volicon = widget({ type = "imagebox" })
volicon.image = image(beautiful.widget_vol)
---- Initialize widgets
volwidget = widget({ type = "textbox" })
-- Enable caching
--vicious.enable_caching(vicious.widgets.volume)
---- Register widgets
vicious.register(volwidget, vicious.widgets.volume, "$1%", 2, "Master")
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
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )

--	}}}
--	{{{2 Tasklist
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

--	}}}
--	{{{2 Wibox creation
for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)
    -- Create the wibox
    mywiboxup[s] = awful.wibox({ position = "top", screen = s, height = 16 })
    -- Add widgets to the wibox - order matters
    mywiboxup[s].widgets =
    {
        {
            --mylauncher,
	    awesomewidget,
            mytaglist[s],
	    mylayoutbox[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        s == 1 and mysystray or nil,
        separator, datewidget, dateicon,
        separator, volwidget, spacer, volicon,
        separator, batwidget, baticon,
        --separator, membar.widget, memicon,
	separator,
	-- FIXME: create a bottom wibox.
        --mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }

    mywiboxdown[s] = awful.wibox({ position = "bottom", screen = s, height = 16 })
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
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))



-- }}}
-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    -- awful.key({ modkey,           }, "k",
    --     function ()
    --         awful.client.focus.byidx(-1)
    --         if client.focus then client.focus:raise() end
    --     end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),

    -- Layout manipulation
    awful.key({ modkey,		  }, "Up", function () awful.client.swap.byidx(  1) end),
    awful.key({ modkey,		  }, "Down", function () awful.client.swap.byidx( -1) end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus( 1)       end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus(-1)       end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    -- awful.key({ modkey,           }, "Tab",
    --     function ()
    --         awful.client.focus.history.previous()
    --         if client.focus then
    --             client.focus:raise()
    --         end
    --     end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey, "Control" }, "Right", function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey, "Control" }, "Left",  function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey, "Shift"   }, "z",     function () awful.util.spawn("gnome-screensaver-command -l") end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
--keynumber = 0
--for s = 1, screen.count() do
--	keynumber = math.min(9, math.max(#tags[s], keynumber));
--end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Key loop

for i=1, ( shifty.config.maxtags or 9 ) do
  table.foreach(awful.key({ modkey, }, i, function () local t = awful.tag.viewonly(shifty.getpos(i)) end), function(_, k) table.insert(globalkeys, k) end)
  table.foreach(awful.key({ modkey, "Control" }, i, function () local t = shifty.getpos(i); t.selected = not t.selected end), function(_, k) table.insert(globalkeys, k) end)
  table.foreach(awful.key({ modkey, "Control", "Shift" }, i, function () if client.focus then awful.client.toggletag(shifty.getpos(i)) end end), function(_, k) table.insert(globalkeys, k) end)
  -- move clients to other tags
  table.foreach(awful.key({ modkey, "Shift" }, i,
    function ()
      if client.focus then
        local c = client.focus
        slave = not ( client.focus == awful.client.getmaster(mouse.screen))
        t = shifty.getpos(i)
        awful.client.movetotag(t)
        awful.tag.viewonly(t)
        if slave then awful.client.setslave(c) end
      end
    end), function(_, k) table.insert(globalkeys, k) end)
end

-- Set keys
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys
shifty.taglist = mytaglist
shifty.init()



-- }}}
-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    --c:add_signal("mouse::enter", function(c)
    --    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
    --        and awful.client.focus.filter(c) then
    --        client.focus = c
    --    end
    --end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
