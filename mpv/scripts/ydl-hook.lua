-- ~& [ ydl-hook ] [ Last Update: 2024-12-23 09:52:31 ]

local mp = require("mp")
local utils = require("mp.utils")
local msg = require("mp.msg")

local function ydl()
	local link = mp.get_property("path")
	mp.msg.info("[ydl]: " .. link)
	if link then
		local link = link:match("^https[^%s]+")
		local cmd = { "ydl", link }
		local result = utils.subprocess({ args = cmd })
		if not result or result.status ~= 0 then
			mp.msg.error("Error getting link: " .. result.status)
		end
	else
		mp.msg.error("No valid link found in clipboard")
	end
end

local function ytup()
	local link = mp.get_property("path")
	mp.msg.info("[ytup]: " .. link)
	if link then
		local link = link:match("^https[^%s]+")
		local cmd = { "ytup", link }
		local result = utils.subprocess({ args = cmd })
		if not result or result.status ~= 0 then
			mp.msg.error("Error getting link: " .. result.status)
		end
	else
		mp.msg.error("No valid link found in clipboard")
	end
end

local function ytln()
	local link = mp.get_property("path")
	mp.msg.info("[ytln]: " .. link)
	if link then
		local link = link:match("^https[^%s]+")
		local cmd = { "ytln", link }
		local result = utils.subprocess({ args = cmd })
		if not result or result.status ~= 0 then
			mp.msg.error("Error getting link: " .. result.status)
		end
	else
		mp.msg.error("No valid link found in clipboard")
	end
end

local function ytcomments()
	local link = mp.get_property("path")
	mp.msg.info("[ytcomments]: " .. link)
    if link then
        local quoted_link = string.format([["%s"]], link)
        local cmd = {
            "emacsclient", "-cn", "--socket-name=/run/user/1000/emacs/server", "--alternate-editor=", "-e",
            string.format("(shell-command (format \"ytcomments %s\" %s))", "%s", quoted_link)
        }
       
       local result = utils.subprocess({ args = cmd })
       if not result or result.error or result.status ~= 0 then
          mp.msg.error("Error running Emacsclient command: " .. (result and result.error or "unknown error"))
       end
    else
        mp.msg.error("No valid link found in path")
    end
end

-- Register script messages
mp.register_script_message("ydl-hook", ydl)
mp.register_script_message("ytup-hook", ytup)
mp.register_script_message("ytln-hook", ytln)
mp.register_script_message("ytcomments-hook", ytcomments)
