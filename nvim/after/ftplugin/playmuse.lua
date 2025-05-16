-- ~& [ playmuse.lua ] [ Last Update: 2024-12-25 12:38 ]

vim.api.nvim_create_user_command("MusePlay", function()
	local keyword = ""
	if vim.fn.mode() == "n" then
		vim.cmd("normal! viWy")
		keyword = vim.fn.getreg('"')
		if keyword:match("%b()") then
			vim.cmd("normal! vi)y")
			keyword = vim.fn.getreg('"')
		end
	elseif vim.fn.mode() == "v" then
		vim.cmd("normal! y")
		keyword = vim.fn.getreg('"')
	end

	local link = nil

	-- Handle keyword to generate a valid input
	if keyword:match("^https?://") or keyword:match("^www") then
		link = keyword:gsub("[%\"%,%']", ""):gsub("%.$", "")
	elseif keyword:match("[A-Za-z0-9-_]..........") then
		link = "https://youtube.com/watch?v=" .. keyword
	else
		link = keyword:gsub("[%\"%,%']", ""):gsub("%.$", "")
	end

	-- Notify user for debugging
	local debug_line = "Sending to museplay: " .. link
	vim.notify(debug_line, vim.log.levels.INFO)

	vim.fn.system('museplay "' .. link .. '"' .. " &")
end, { range = true })

vim.keymap.set({ "n", "v" }, "M", ":MusePlay<CR><CR>")
