local naughty		= require("naughty")

--naughty.config.timeout          = 5
--naughty.config.screen           = 1
--naughty.config.position         = "top_right"
--naughty.config.margin           = 4
--naughty.config.height           = 16
--naughty.config.width            = 300
--naughty.config.gap              = 1
--naughty.config.ontop            = true
--naughty.config.font             = beautiful.font or "Verdana 8"
--naughty.config.icon             = nil
--naughty.config.icon_size        = 16
--naughty.config.fg               = beautiful.fg_focus or '#ffffff'
--naughty.config.bg               = beautiful.bg_focus or '#535d6c'
--naughty.config.border_color     = beautiful.border_focus or '#535d6c'
--naughty.config.border_width     = 1
--naughty.config.hover_timeout    = nil


Notifier		= {}
Notifier.__index	= Notifier

function Notifier.create(name, icon)
	local self = setmetatable({}, Notifier)
	self.name = name
	self.icon = icon
	self.old_id = nil
	return self
end

function Notifier:icon_set(icon)
	self.icon = icon
end

function Notifier:notify(message)
	self.old_id = naughty.notify({ title = self.name,
				       text = message,
				       icon = self.icon,
				       icon_size = 32,
				       timeout = 10,
				       width = 200,
				       position = "bottom_right",
				       border_width = 3,
				       replaces_id = self.old_id }).id
end

function Notifier:warning(message)
	self.old_id = naughty.notify({ title = self.name,
				       text = message,
				       icon = self.icon,
				       icon_size = 32,
				       timeout = 10,
				       width = 200,
				       bg = '#E8A317',
				       border_color = 'yellow',
				       fg = 'yellow',
				       position = "bottom_right",
				       border_width = 3,
				       replaces_id = self.old_id }).id
end

function Notifier:alert(message)
	self.old_id = naughty.notify({ title = self.name,
				       text = message,
				       icon = self.icon,
				       icon_size = 32,
				       timeout = 10,
				       width = 200,
				       bg = '#800517',
				       border_color = 'red',
				       fg = 'red',
				       position = "bottom_right",
				       border_width = 3,
				       replaces_id = self.old_id }).id
end
