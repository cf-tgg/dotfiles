-- ~& [ load_clipboard.lua ] [ Last Update: 2024-12-17 20:31 ]

local mp = require("mp")
local utils = require("mp.utils")

local function load_from_clipboard()
	local command = { "xclip", "-selection", "clipboard", "-o" }
	local result = utils.subprocess({ args = command })
	if result.status == 0 and result.stdout ~= nil then
		local clipboard_content = result.stdout:gsub("\n", "")
		if clipboard_content:match("^%s*$") then
			mp.msg.warn("Clipboard is empty or whitespace only.")
			return
		end
		mp.commandv("loadfile", clipboard_content, "append-play")
		mp.osd_message("Loaded from clipboard:\n" .. clipboard_content)
	else
		mp.msg.error("Failed to read clipboard.")
		mp.osd_message("Error: Could not read clipboard.")
	end
end

mp.add_key_binding("MBTN_MID", "load_clipboard", load_from_clipboard)
