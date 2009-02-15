---- {{{ {{{ Hooks

---- {{{ Hook function to execute when focusing a client.

  awful.hooks.focus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
  end)

---- }}}

---- {{{ Hook function to execute when unfocusing a client.

  awful.hooks.unfocus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
  end)

---- }}}

---- {{{ Hook function to execute when marking a client

  awful.hooks.marked.register(function (c)
    c.border_color = beautiful.border_marked
  end)

---- }}}

---- {{{ Hook function to execute when unmarking a client

  awful.hooks.unmarked.register(function (c)
    c.border_color = beautiful.border_focus
  end)

---- }}}

---- {{{ Hook function to execute when the mouse is over a client.

  awful.hooks.mouse_enter.register(function (c)
    -- Sloppy focus, but disabled for magnifier layout
    if awful.layout.get(c.screen) ~= "magnifier"
        and awful.client.focus.filter(c) then
        client.focus = c
    end
  end)

---- }}}

---- {{{ Hook function to execute when a new client appears.

  awful.hooks.manage.register(function (c)
    if use_titlebar then
        -- Add a titlebar
        awful.titlebar.add(c, { modkey = modkey })
    end
    -- Add mouse bindings
    c:buttons({
        button({ }, 1, function (c) client.focus = c; c:raise() end),
        button({ modkey }, 1, function (c) c:mouse_move() end),
        button({ modkey }, 3, function (c) c:mouse_resize() end)
    })
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal
    client.focus = c

    -- Check if the application should be floating.
    local cls = c.class
    local inst = c.instance
    if floatapps[cls] then
        c.floating = floatapps[cls]
    elseif floatapps[inst] then
        c.floating = floatapps[inst]
    end

    -- Check application->screen/tag mappings.
    local target
    if apptags[cls] then
        target = apptags[cls]
    elseif apptags[inst] then
        target = apptags[inst]
    end
    if target then
        c.screen = target.screen
        awful.client.movetotag(tags[target.screen][target.tag], c)
    end

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- awful.client.setslave(c)

    -- Honor size hints: if you want to drop the gaps between windows, set this to false.
    -- c.honorsizehints = false
  end)

---- }}}

---- {{{ Hook function to execute when arranging the screen

  -- (tag switch, new client, etc)
  awful.hooks.arrange.register(function (screen)
    local layout = awful.layout.get(screen)
    if layout then
      mylayoutbox[screen].image = image("/usr/share/awesome/icons/layouts/" .. layout .. "w.png")
    else
      mylayoutbox[screen].image = nil
    end

    -- Give focus to the latest client in history if no window has focus
    -- or if the current window is a desktop or a dock one.
    if not client.focus then
      local c = awful.client.focus.history.get(screen, 0)
      if c then client.focus = c end
    end

    -- Uncomment if you want mouse warping
    --[[
    if client.focus then
        local c_c = client.focus:coords()
        local m_c = mouse.coords()

        if m_c.x < c_c.x or m_c.x >= c_c.x + c_c.width or
            m_c.y < c_c.y or m_c.y >= c_c.y + c_c.height then
            if table.maxn(m_c.buttons) == 0 then
                mouse.coords({ x = c_c.x + 5, y = c_c.y + 5})
            end
        end
    end
    ]]
  end)

---- {{{ Hook called every second

  awful.hooks.timer.register(1, function ()
    -- For unix time_t lovers
    mytextbox.text = " " .. os.time() .. " time_t "
    -- Otherwise use:
    -- mytextbox.text = " " .. os.date() .. " "
  end)

---- }}}

-- }}}
