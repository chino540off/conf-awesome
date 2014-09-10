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
beautiful.init(awful.util.getdir("config") .. "/themes/blue/theme.lua")
beautiful.awesome_icon		= awful.util.getdir("config") .. "/icons/awesome.png"
beautiful.calendar_icon		= awful.util.getdir("config") .. "/icons/appbar.calendar.png"
beautiful.battery_3		= awful.util.getdir("config") .. "/icons/appbar.battery.3.png"
beautiful.battery_2		= awful.util.getdir("config") .. "/icons/appbar.battery.2.png"
beautiful.battery_1		= awful.util.getdir("config") .. "/icons/appbar.battery.1.png"
beautiful.battery_0		= awful.util.getdir("config") .. "/icons/appbar.battery.0.png"
beautiful.battery_charging	= awful.util.getdir("config") .. "/icons/appbar.battery.charging.png"
beautiful.sound_3		= awful.util.getdir("config") .. "/icons/appbar.sound.3.png"

require("config.tags")
require("config.menu")
require("config.widgets")
require("config.binding.global")
require("config.binding.client")
require("config.binding.mouse")
require("config.signal")

shifty.init()
