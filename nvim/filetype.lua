-- ~& [ filetype.lua ] [ Last Update: 2024-12-25 12:19 ]

M = {}

vim.filetype.add({
	filename = {
		["config.h"] = "c",
		["history.playmuse"] = "playmuse",
	},
})

-- Automatically handle multiline C comments with ` *` prefix alignment
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "h", "cpp", "js", "ts", "cs", "css" },
	callback = function()
		vim.opt_local.formatoptions:append("r") -- Continue comments with new line
		vim.opt_local.formatoptions:remove("o") -- no comment on `o` newlines
		vim.opt_local.comments = "s1:/*,mb:*,ex:*/" -- C-style multiline comment structure
	end,
})

return M
