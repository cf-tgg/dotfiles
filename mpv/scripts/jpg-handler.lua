-- ~& [ jpg-handler.lua ] [ Last Update: 2024-12-20 11:02 ]

local mp = require("mp")
local utils = require("mp.utils")
local playlist = mp.get_property_native("playlist")

local function no_pause()
	if mp.get_property("pause") == "yes" then
		mp.set_property("pause", "no")
	end
	if playlist and #playlist > 0 then
		mp.commandv("playlist-next")
		mp.set_property("pause", "no")
	end
	if mp.get_property("core-idle") == "yes" then
		mp.set_property("core-idle", "no")
	end
end

-- Helper: Escape shell arguments
local function shellescape(arg)
	if not arg then
		return nil
	end
	return "'" .. arg:gsub("'", "'\\''") .. "'"
end

local function extract_uri(path)
	if not path then
		mp.msg.error("No path provided.")
		return
	end
	local cmd = { "exifjpg", path, "-u" }
	local result = utils.subprocess({ args = cmd })
	if not result or result.status ~= 0 then
		mp.msg.error("Failed to extract URI. Command returned status: " .. result.status)
	end
	mp.msg.info("Extracted URI: " .. result.stdout)
	local uri = result.stdout:gsub("%s+$", "")
	return uri
end

local function get_exifdt(path, opts)
	local valid_uri = extract_uri(path)
	if valid_uri then
		opts = opts or {}
		local exifjpg_cmd = { "exifjpg", path, unpack(opts) }
		local results = utils.subprocess({ args = exifjpg_cmd })
		if not results or results.status ~= 0 then
			mp.msg.error("Failed to extract EXIF data. Command returned status: " .. results.status)
			return nil
		end
		local exifdt = results.stdout:gsub("%s+$", "")
		mp.msg.info("EXIF: " .. exifdt)
		return exifdt
	else
		mp.msg.warn("No valid URI found for: " .. path)
		mp.osd_message("Not a supported JPG format.")
		return nil
	end
end

local function handle_jpg()
	local path = mp.get_property("path")
	local format = mp.get_property("file-format")
	if path and format == "jpeg_pipe" then
		local uri = extract_uri(path)
		if uri then
			mp.osd_message("Got URI: " .. uri)
			if playlist and #playlist > 0 then
				mp.commandv("loadfile", uri, "append")
			else
				mp.commandv("loadfile", uri)
			end
			local properties = get_exifdt(path, { "-Utd" })
			if properties then
				mp.osd_message(properties)
				mp.msg.info(properties)
			end
			no_pause()
			return uri
		else
			mp.msg.warn("No valid URI found for: " .. path)
			mp.osd_message("Not a supported JPG format.")
		end
	end
end

local function get_comments()
	local path = mp.get_property("path")
	local format = mp.get_property("file-format")
	if path and format == "jpeg_pipe" then
		local cmd = { "exifjpg", path, "-c" }
		local result = utils.subprocess({ args = cmd })
		if result.status == 0 and result then
			for line in result.stdout:gmatch("[^\r\n]+") do
				mp.osd_message(line)
				mp.msg.info(line)
			end
		else
			mp.msg.error("No comments extracted: " .. result.status)
		end
	end
end

mp.register_event("file-loaded", handle_jpg)
mp.register_event("start-file", handle_jpg, no_pause)
mp.register_event("drop-file", handle_jpg)
mp.register_event("end-file", handle_jpg)

mp.add_key_binding("alt+e", "extract-comments", get_comments)
