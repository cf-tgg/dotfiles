local setlocal = vim.opt_local
local api = vim.api
local moving_lines = false

setlocal.expandtab = true
setlocal.textwidth = 78
setlocal.tabstop = 4
setlocal.shiftwidth = 4
setlocal.readonly = true
setlocal.updatetime = 3000
setlocal.cursorline = true
setlocal.hlsearch = true
setlocal.wrap = false
setlocal.sidescroll = 0

vim.api.nvim_create_augroup("RTFMHelpKeys", { clear = true })

-- vim.api.nvim_create_user_command("RTFMHelp", {
-- 	cmd = "",
-- })

-- vim.api.nvim_create_autocmd({"FileType","BufLeave"}, {
-- 	group = "RTFMHelpKeys",
-- 	pattern = { "help", "*.txt",
-- 		{	filetype="help" },
-- 	},
-- 	command = function()
-- 		vim.api.nvim_buf_del_user_command
-- 	end,
-- })

vim.api.nvim_buf_set_keymap(0, "n", "d", "<C-d>zz", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "u", "<C-u>zz", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "pp", "<C-w>}", { noremap = false })

-- Function to move the cursor and refresh the screen
local function move_cursor()
	if not moving_lines then
		return
	end

	local cursor_line = api.nvim_win_get_cursor(0)[1]
	-- Move to the next line and refresh the screen
	api.nvim_command("normal! " .. (cursor_line + 1) .. "G")
	api.nvim_command("redraw")

	-- Continue the loop with a delay
	vim.defer_fn(function()
		api.nvim_command("normal! zz")
		vim.defer_fn(move_cursor, 1000) -- Continue the loop with 1-second delay
	end, 3000) -- Wait 3 seconds before moving down
end

-- Function to start the background movement
local function start_moving_lines()
	if moving_lines then
		vim.notify("Ça lit...")
		return
	end

	moving_lines = true
	move_cursor()
	vim.notify("On lit..")
end

-- Function to stop the background movement
local function stop_moving_lines()
	if not moving_lines then
		vim.notify("Ça lit pu.")
		return
	end

	moving_lines = false
	vim.notify("On arrête ça.")
end

-- Bind <leader>S to start/stop the movement
vim.keymap.set({ "n", "v" }, "<leader>S", function()
	if moving_lines then
		stop_moving_lines()
	else
		start_moving_lines()
	end
end, { noremap = true, silent = true })
