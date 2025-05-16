-- ~& [ playground.lua ] [ Last Update: 2024-10-22 10:32 ]
--   _____ ____  ____  _                                             _
--  |_   _/ ___||  _ \| | __ _ _   _  __ _ _ __ ___  _   _ _ __   __| |
--    | | \___ \| |_) | |/ _` | | | |/ _` | '__/ _ \| | | | '_ \ / _` |
--    | |  ___) |  __/| | (_| | |_| | (_| | | | (_) | |_| | | | | (_| |
--    |_| |____/|_|   |_|\__,_|\__, |\__, |_|  \___/ \__,_|_| |_|\__,_|
--                             |___/ |___/
--                                                            ~cf.[0]&~

-- ~& [ Treesitter Playground ]

local M = {}

require("nvim-treesitter.configs").setup({
	playground = {
		enable = true,
		disable = {},
		updatetime = 250,
		persist_queries = false,
		query_linter = {
			enable = true,
			use_virtual_text = true,
			lint_events = { "BufWrite", "CursorHold" },
			context_commentstring = true,
			context_cursor = true,
			context_identifiers = true,
			context_textobjects = true,
			context_tree = true,
			context_visual = true,
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "fl",
				unfocus_language = "ul",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
			winopts = {
				float = {
					layout = "flex",
					winheight = 10,
					winwidth = 49,
					highlight = "Normal:NormalFloat",
					border = "curved",
					blend = 20,
				},
			},
		},
	},
})

vim.keymap.set("n", "TS", ":TSPlaygroundToggle<CR>", { desc = "[T]ree [S]itter" })
vim.keymap.set("n", "ST", ":TSPlaygroundToggle<CR>", { desc = "[S]itter [T]ree" })
vim.keymap.set("n", "<C-x><C-h>", ":TSHighlightCapturesUnderCursor<CR>", { desc = "Highlight Captures Under Cursor" })

return M

--  vim: ts=2 sw=2 sts=2 et:
