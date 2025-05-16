-- ~& [ gotopreview.lua ] [ Last Update: 2024-10-23 16:05 ]


local M = {
		"rmagatti/goto-preview",
			config = function()
			require("goto-preview").setup({
			width = 100,
			height = 20,
			border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" },
			default_mappings = true,
			debug = false,
			opacity = 85,
			resizing_mappings = true,
			post_open_hook = nil,
			references = {
				telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
			},
			focus_on_open = true,
			dismiss_on_move = false,
			force_close = true,
			bufhidden = "wipe",
			stack_floating_preview_windows = true,
			preview_window_title = {
				enable = true,
				position = "top",
			},
		})
	end,
}

return M
