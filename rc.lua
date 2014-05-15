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

-- Custom libraries
require("revelation")
require("shifty")
-- }}}

-- Variables
terminal	= "urxvtc"
browser		= "chromium-browser"
editor		= os.getenv("EDITOR") or "editor"
editor_cmd	= terminal .. " -e " .. editor

-- Default modkey.
modkey		= "Mod4"
modkey2		= "Mod1"

-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/themes/theme.lua")


require("config.tags")
require("config.menu")
require("config.widgets")
require("config.binding.global")
require("config.binding.client")
require("config.binding.mouse")
require("config.signal")

shifty.init()
