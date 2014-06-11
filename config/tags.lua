local shifty = require("shifty")
local awful  = require("awful")

-- {{{ Layouts definition
-- Table of layouts to cover with awful.layout.inc, order matters.
layouts = {
	awful.layout.suit.tile,		-- 1
	--awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,	-- 2
	--awful.layout.suit.tile.top,
	awful.layout.suit.fair,		-- 3 
	--awful.layout.suit.fair.horizontal,
	--awful.layout.suit.spiral,
	--awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,		-- 4
	--awful.layout.suit.max.fullscreen,
	--awful.layout.suit.magnifier,
	--awful.layout.suit.floating
}
-- }}}

-- {{{ Tags
-- {{{1 Tags definition
shifty.config.tags = {
	["[ 1. code]"] = {
		layout = layouts[4],
		screen = math.max(screen.count(), 2),
		position = 1,
		nopopup = true,
		exclusive = false,
		spawn = "gvim --servername 1"
	},
	["[ 2. sh]"] = {
		layout = layouts[1],
		screen = 1,
		position = 2,
		init = true,
		--spawn = terminal
	},
	["[ 3. misc]"] = {
		layout = layouts[1],
		screen = 1,
		position = 3,
		nopopup = true,
		exclusive = true
	},
	["[ 4. doc]"] = {
		layout = layouts[4],
		screen = 1,
		position = 4
	},
	["[ 5. im]"] = {
		layout = layouts[1],
		screen = 1,
		position = 5,
		nopopup = true,
		exclusive = true
	},
	["[ 6. www]"] = {
		layout = layouts[4],
		screen = 1,
		position = 6,
		nopopup = true,
		exclusive = false,
		spawn = browser
	},
	["[ 7. zik]"] = {
		layout = layouts[4],
		position = 7,
		nopopup = true,
		exclusive = true
	},
	["[ 8. media]"] = {
		layout = layouts[1],
		screen = 1,
		position = 8,
		nopopup = false,
		exclusive = false
	},
	["[ 9. ide]"] = {
		layout = layouts[4],
		screen = math.max(screen.count(), 2),
		position = 9,
		nopopup = true,
		exclusive = false
	},
	["[10. draw]"] = {
		layout = layouts[4],
		screen = math.max(screen.count(), 2),
		position = 10,
		nopopup = true,
		exclusive = false
	},
	["[11. VMs]"] = {
		layout = layouts[4],
		screen = math.max(screen.count(), 2),
		position = 11,
		nopopup = true,
		exclusive = false
	},
	--["[default]"] = {
	--	layout = layouts[1],
	--	screen = 1,
	--	position = 9,
	--	init = true,
	--	spawn = terminal
	--}
}
-- }}}

-- {{{2 Applications
shifty.config.apps = {
	{
		match = { "Gvim", "gvim" },
		tag = "[ 1. code]",
		opacity = 0.50
	},
	{
		match = { "rxvt" },
		tag = "[ 2. sh]",
		opacity = 0.85
	},
        {
		match = { "Wireshark" },
		tag = "[ 3. misc]",
		opacity = 1.0
	},
        {
		match = { "gitk" },
		tag = "[ 3. misc]",
		opacity = 1.0
	},
	{
		match = { "Evince", "LibreOffice" },
		tag = "[ 4. doc]",
		opacity = 1.0
	},
        {
		match = { "Pidgin" },
		tag = "[ 5. im]",
		float = true
	},
        {
		match = { "Chromium", browser } ,
		tag = "[ 6. www]",
		opacity = 0.95
	} ,
	{
		match = { "spotify" },
		tag = "[ 7. zik]",
		opacity = 1.0
	},
	{
		match = { "vlc" },
		tag = "[ 8. media]",
		opacity = 1.0
	},
	{
		match = { "Eclipse" },
		tag = "[ 9. ide]",
		opacity = 0.90
	},
	{
		match = { "VirtualBox" },
		tag = "[11. VMs]",
		opacity = 0.90
	},
	-- {
	-- 	match = { "dia" },
	-- 	tag = "[10. draw]",
	-- 	opacity = 0.90
	-- },
        {
		match = { "" },
		buttons = awful.util.table.join(awful.button({        }, 1, function (c) client.focus = c; c:raise() end),
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
	floatBars = false,
}
-- }}}
