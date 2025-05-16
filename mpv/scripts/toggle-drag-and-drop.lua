-- ~& [ toggle-drag-and-drop.lua ] [ Last Update: 2024-12-16 21:20 ]

local mp = require("mp")

local drag_drop_modes = { "no", "auto", "replace", "append", "insert-next" }
local current_mode_index = 1

local function toggle_drag_drop()
	current_mode_index = current_mode_index % #drag_drop_modes + 1
	local new_mode = drag_drop_modes[current_mode_index]
	mp.set_property("drag-and-drop", new_mode)
	mp.osd_message("Drag-and-Drop: " .. new_mode)
end

mp.add_key_binding("alt+d", "toggle-drag-drop", toggle_drag_drop)
