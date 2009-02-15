-- {{{ Widget

---- {{{ Function Separator
      
  function separator ()
    return ("<span color='white'> | </span>");
  end

---- }}}

---- {{{ Function Imageget

  function imageget (path)
    return ("<bg image=\""..path.."\" resize=\"false\"/>      ");
  end

---- }}}

---- {{{ Create a taglist widget

  mytaglist = {}
  mytaglist.buttons = { button({ }, 1, awful.tag.viewonly),
			button({ modkey }, 1, awful.client.movetotag),
			button({ }, 3, function (tag) tag.selected = not tag.selected end),
			button({ modkey }, 3, awful.client.toggletag),
			button({ }, 4, awful.tag.viewnext),
			button({ }, 5, awful.tag.viewprev) }

---- }}}

---- {{{ Create a tasklist widget

  mytasklist = {}
  mytasklist.buttons = { button({ }, 1, function (c) client.focus = c; c:raise() end),
			 button({ }, 4, function () awful.client.focus.byidx(1) end),
			 button({ }, 5, function () awful.client.focus.byidx(-1) end) }

---- }}}

---- {{{ Create a textbox widget

  mytextbox = widget({ type = "textbox", name = "mytextbox", align = "right" })

---- }}}

---- {{{ Set the default text in textbox

  mytextbox.text = "<b><small> awesome " .. AWESOME_VERSION .. " </small></b>"
  mypromptbox = widget({ type = "textbox", name = "mypromptbox", align = "left" })

---- }}}

---- {{{ Create an iconbox widget

  myiconbox = widget({ type = "textbox", name = "myiconbox", align = "left" })
  myiconbox.text = "<bg image=\"/usr/share/awesome/icons/awesome16.png\" resize=\"true\"/>"

---- }}}

---- {{{ Create a systray

  mysystray = widget({ type = "systray", name = "mysystray", align = "right" })

---- }}}

---- {{{ Date Widget

  datewidget = widget({ type = "textbox",
			name = "datewidget",
			align = "right"})

  wicked.register(datewidget,
		  wicked.widgets.date,
		  '%a %d %h %H:%M')

---- }}}

---- {{{ Volume Widget

  volumewidget = widget({ type = "textbox",
			  name = "volumewidget",
			  align = "right"})

  function amixer_volume(format)
    local f = io.popen('amixer get Master')
    local l = f:lines()
    local icon = imageget("/home/chino/conf/awesome/icons/vol-hi.png")
    local v = ''

    for line in l do
      if line:find('Mono:') ~= nil then
	if line:find(' [off]', 0, true) then
	  v = '0'
	else
	  pend = line:find('%]', 0, true)
	  pstart = line:find('[', 0, true)
	  v = line:sub(pstart+1, pend-1)
	end
      end
    end
    f:close()

    if tonumber(v) == 0 then
      icon = imageget("/home/chino/conf/awesome/icons/vol-mute.png")
    elseif tonumber(v) <= 33 then
      icon = imageget("/home/chino/conf/awesome/icons/vol-low.png")
    elseif tonumber(v) <= 66 then
      icon = imageget("/home/chino/conf/awesome/icons/vol-mid.png")
    else
      icon = imageget("/home/chino/conf/awesome/icons/vol-hi.png")
    end
    return {icon..v.."&#37;"}
  end

  wicked.register(volumewidget,
		  amixer_volume,
		  "$1"..separator(),
		  0.5)

---- }}}

---- {{{ Battery Widget
  
  batterywidget = widget({ type = "textbox",
			   name = "batterywidget",
			   align = "right"})
  function run_battery()
    local fd = io.popen('~/.config/awesome/sbin/battery.sh')
    local value = fd:read()
    local bat = ''
    local icon = imageget("/home/chino/conf/awesome/icons/power-bat-low.png")

    fd:close()

    pend = value:find(" ", 0, true);
    bat = value:sub(pend+1, -1);
    value = value:sub(0, pend-1);

    if tonumber(value) <= 20 then
      value = "<span color='red'>"..value.."&#37;</span>";
    elseif tonumber(value) <= 50 then
      icon = imageget("/home/chino/conf/awesome/icons/power-bat-mid.png")
      value = "<span color='orange'>"..value.."&#37;</span>";
    else
      icon = imageget("/home/chino/conf/awesome/icons/power-bat-hi.png")
      value = "<span color='green'>"..value.."&#37;</span>";
    end

    if bat == 'AC' then
      icon = imageget("/home/chino/conf/awesome/icons/power-ac.png")
    end
    return {icon..value}
  end

  wicked.register(batterywidget,
		  run_battery,
		  "$1"..separator(),
		  0.5)

---- }}}

---- {{{ FS Widget

--  fswidget = widget({ type = "textbox",
--		      name = "fswidget",
--		      align = "right"})

--  wicked.register(fswidget,
--		  wicked.widgets.fs,
--		  imageget("/home/chino/conf/awesome/icons/hdd_mount.png")..' <span color="white">FS:</span> ${/ used}/${/ size} (${/ usep} used)'..separator(),
--		  -- "<bg image=\"/home/chino/conf/awesome/icons/hdd_mount.png\" resize=\"true\"/> Home: ${/home usep}&#37; Data: ${/mnt/data usep}&#37;<span color=\"white\"> | </span>",
--		  1)

---- }}}

---- {{{ Network Widget

  netwidget = widget({ type = "textbox",
		       name = "netwidget",
		       align = "right"})

  function run_network()
    local fd = io.popen('~/.config/awesome/sbin/network.sh')
    local value = fd:read()
    local dev = ''
    local icon = imageget("/home/chino/conf/awesome/icons/net-wired.png")

    fd:close()

    pend = value:find(" ", 0, true);
    dev = value:sub(0, pend-1);
    value = value:sub(pend+1, -1);

    if dev == 'wlan0' then
      icon = imageget("/home/chino/conf/awesome/icons/net-wifi.png")
    end
    if value == "" then
      icon = ""
    else
      value = value..separator()
    end
    return {icon..value}
  end

  --' <span color="white">NET</span>: ${eth0 down} / ${eth0 up} [ ${eth0 rx} //  ${eth0 tx} ]'..separator(),
  wicked.register(netwidget,
		  run_network,
		  "$1",
		  1)

---- }}}

---- {{{ Now Playing Widget

  mpdwidget = widget({ type = 'textbox',
		       name = 'mpdwidget',
		       align = "right"})

  wicked.register(mpdwidget, wicked.widgets.mpd, 
	function (widget, args)
		   if args[1]:find("volume:") == nil then
		      return imageget("/home/chino/conf/awesome/icons/mpd.png")..args[1]..separator()
                   end
		end)

---- }}}

----{{{ Create a laucher widget and a main menu
  myawesomemenu = {
   	{"manual", terminal .. " -e man awesome" },
	{"edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
	{"restart", awesome.restart },
	{"quit", awesome.quit }
    }

  mymainmenu = {
	{"awesome", myawesomemenu, "/usr/share/awesome/icons/awesome16.png" },
	{"open terminal", terminal }
    }

  mylauncher = awful.widget.launcher({
	name = "mylauncher",
        image = "/usr/share/awesome/icons/awesome16.png",
	menu = { id="mymainmenu", items=mymainmenu }
    })

---- }}}


---- {{{ Statusbar1 Widget

  -- Create a statusbar for each screen and add it
  mylayoutbox = {}
  mypromptbox = {}
  mystatusbar1 = {}
  for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = widget({ type = "textbox", name = "mypromptbox" .. s, align = "left" })

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = widget({ type = "imagebox", name = "mylayoutbox", align = "right" })
    mylayoutbox[s]:buttons({ button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                             button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 5, function () awful.layout.inc(layouts, -1) end) })

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist.new(function(c)
                                                  return awful.widget.tasklist.label.currenttags(c, s)
                                              end, mytasklist.buttons)
    
    -- Create the wibox
    mystatusbar1[s] = wibox({ position = "top", name = "mystatusbar1" .. s,
                              fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the statusbar - order matters
    mystatusbar1[s].widgets = {
      mytaglist[s],
      mylauncher,
      mytasklist[s],
      mypromptbox[s],
      --mytextbox,
      --fswidget,
    }
    mystatusbar1[s].screen = s
  end

---- }}}

---- {{{ Statusbar2 Widget
  
  -- Create a statusbar for each screen and add it
  mystatusbar2 = {}
  for s = 1, screen.count() do
    mystatusbar2[s] = wibox({ position = "bottom", name = "mystatusbar2" .. s,
                              fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the statusbar - order matters 
    mystatusbar2[s].widgets = {
      mpdwidget,
      netwidget,
      --fswidget,
      batterywidget,
      volumewidget,
      datewidget,
      --mylayoutbox[s],
      s == 1 and mysystray or nil
    }
    mystatusbar2[s].screen = s
  end

---- }}}

-- }}}
