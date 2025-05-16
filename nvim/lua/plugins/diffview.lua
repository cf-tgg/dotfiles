M = {}

-- Split window, aligned to the right side of the editor:
SplitDefault = {
	type = "split",
	position = "right",
	width = 40,
	default_args = {
		DiffviewOpen = { "--untracked-files=no", "--imply-local" },
		DiffviewFileHistory = { "--base=LOCAL" },
	}
}
-- Split window, aligned to the bottom of the first window in
-- the current tabpage:
SplitBottom = function()
	return {
		type = "split",
		position = "bottom",
		height = 14,
		relative = "win",
		win = vim.api.nvim_tabpage_list_wins(0)[1],
	}
end

-- Floating window, centered in the editor:
FloatMaster = function()
	local c = { type = "float" }
	local editor_width = vim.o.columns
	local editor_height = vim.o.lines
	c.width = math.min(100, editor_width)
	c.height = math.min(24, editor_height)
	c.col = math.floor(editor_width * 0.5 - c.width * 0.5)
	c.row = math.floor(editor_height * 0.5 - c.height * 0.5)
	return c
end

return M
