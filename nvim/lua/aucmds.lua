-- ~& [ aucmds.lua ] [ Last Update: 2024-10-24 19:50 ]
--              _                           _
--   __ _ _   _| |_ ___   ___ _ __ ___   __| |___
--  / _` | | | | __/ _ \ / __| '_ ` _ \ / _` / __|
-- | (_| | |_| | || (_) | (__| | | | | | (_| \__ \
--  \__,_|\__,_|\__\___/ \___|_| |_| |_|\__,_|___/
--
--                                        ~cf.[0]&~

-- ~& [ Autocmds Collection ] ~&~
local M = {}
-- [4]&~
-- ~& [ API Aliases ]
local api = vim.api
local fn = vim.fn
local augroup = function(name)
	return api.nvim_create_augroup(name, { clear = true })
end
local usercmd = vim.api.nvim_create_user_command
local autocmd = function(event, group, fun)
	return api.nvim_create_autocmd(event, {
		group = augroup(group),
		callback = fun,
	})
end
-- [3]&~
-- ~& [ General Autocmds ]
-- ~& [ DateTime Updates Autocmd ]
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("cf_datetime_update", { clear = true }),
	pattern = { "*.lua" },
	desc = "Update datetime on write",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local file_name = vim.api.nvim_buf_get_name(buf)
		local filename = vim.fn.fnamemodify(file_name, ":t")
		local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)
		local date_str = "-- ~& [ " .. filename .. " ] [ Last Update: " .. os.date("%Y-%m-%d %H:%M") .. " ]" -- [4]&~
		if first_line[1]:match("^--") or "" then
			vim.api.nvim_buf_set_lines(buf, 0, 1, false, { date_str })
		else
			vim.api.nvim_buf_set_lines(buf, 0, 0, false, { date_str })
		end
	end,
})
-- [4]&~
-- ~& [ Always Remove Trailing Whitespaces ]
vim.api.nvim_create_augroup("cf-autocmds", { clear = true })
vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter", "BufLeave" }, {
	group = "cf-autocmds",
	callback = function()
		local cursor_pos = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[silent! keeppatterns %s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, cursor_pos)
	end,
})
-- [4]&~
-- ~& [ Diagnostic Toggle ]
vim.g.diagnostic_toggle = 1
usercmd("DiagnosticToggle", function()
	if vim.g.diagnostic_toggle == 1 then
		vim.diagnostic.hide()
		vim.g.diagnostic_toggle = 0
	else
		vim.diagnostic.show()
		vim.g.diagnostics_toggle = 1
	end
end, { nargs = 0 })
vim.keymap.set("n", "DH", ":DiagnosticToggle<CR>", { noremap = true, silent = true })
-- [4]&~
-- ~& [ Timed Tabline ]
augroup("el_tabline")
autocmd(
	{
		"BufEnter",
		"TabNew",
		"TabEnter",
	},
	"el_tabline",
	function()
		vim.o.showtabline = 2
		vim.cmd.redraw()
		vim.fn.timer_start(20000, function()
			if vim.o.showtabline == 2 then
				vim.o.showtabline = 0
				vim.cmd.redraw()
			end
		end)
	end
)

-- ~& [ Modeline ]
return M
-- vim: ft=lua sw=2 ts=4 et:
-- [3]&~
