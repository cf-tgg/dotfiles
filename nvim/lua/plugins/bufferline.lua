-- ~& [ bufferline.lua ] [ Last Update: 2024-10-24 21:03 ]
--   _            __  __           _ _
--  | |__  _   _ / _|/ _| ___ _ __| (_)_ __   ___
--  | '_ \| | | | |_| |_ / _ \ '__| | | '_ \ / _ \
--  | |_) | |_| |  _|  _|  __/ |  | | | | | |  __/
--  |_.__/ \__,_|_| |_|  \___|_|  |_|_|_| |_|\___|
--
--                                          ~cf.[0]&~

-- ~& [ bufferline module ] ~&~
local M = {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = "VimEnter",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers", -- "tabs" to show tabpages only
				themable = false,
				numbers = "buffer_id", -- "ordinal", "buffer_id", "both", or a function
				close_command = "bdelete! %d", -- can be a string or function
				right_mouse_command = "bdelete! %d",
				left_mouse_command = "buffer %d",
				indicator = {
					icon = "▎",
					style = "icon",
				},
				buffer_close_icon = "[󰅖]",
				modified_icon = "[+]",
				close_icon = "[]",
				left_trunc_marker = " ",
				right_trunc_marker = " ",
				max_name_length = 18,
				max_prefix_length = 15,
				truncate_names = true,
				tab_size = 18,
				diagnostics = "nvim_lsp", -- or false, or "coc"
				diagnostics_update_in_insert = false,
				diagnostics_update_on_event = true,
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					if diagnostics_dict[level] > 2 and context then
						return " [" .. count .. "]"
					end
					return ""
				end,
				custom_filter = function(buf_number, buf_numbers)
					return buf_numbers[1] ~= buf_number
				end,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				show_duplicate_prefix = true,
				duplicates_across_groups = true,
				persist_buffer_sort = true,
				move_wraps_at_ends = false,
				separator_style = "thin",
				enforce_regular_tabs = false,
				always_show_bufferline = false,
				auto_toggle_bufferline = false,
				hover = {
					enabled = true,
					delay = 800,
					reveal = { "close" },
				},
			},
		})
	end,
}

return M

-- vim:ft=lua:tw=78:ts=2:sts=2:sw=2:et:
-- [3]&~
