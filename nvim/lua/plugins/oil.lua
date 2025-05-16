-- ~& [ oil.lua ] [ Last Update: 2024-11-02 01:41 ]
--         _ _
--    ___ (_) |
--   / _ \| | |
--  | (_) | | |
--   \___/|_|_|     ~cf.[0]&~
--

-- ~& [ Oil Default Options ] ~&~
local M = {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			columns = {
				-- "icon",
				-- "permissions",
				-- "size",
				-- "mtime",
				-- "preview",
			},
			buf_options = {
				buflisted = true,
				bufhidden = "hide",
			},
			skip_confirm_for_simple_edits = true,
			default_file_explorer = true,
			constrain_cursor = "name", -- `editable` Set to `false` to disable, or "name" to keep it on the file names
			delete_to_trash = false,
			border = "rounded",
			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				foldcolumn = "0",
			},
			view_options = {
				show_hidden = false,
				is_hidden_file = function(name)
					return name:match("^%.") or name:match("vimwiki")
				end,
			},
			-- [2]&~
			-- ~& [ Actions Keymaps ]
			keymaps = {
        ["<C-h>"] = false,
				["<C-x>"] = "actions.select_split",
				["g?"] = "actions.show_help",
				["aq"] = { "actions.send_to_qflist", opts = { action = "a", target = "qflist" } },
				["lo"] = { "actions.send_to_loclist", opts = { action = "a", target = "loclist" } },
				["<c-b>"] = {
					"actions.select",
					opts = { vertical = true },
					desc = "Open the entry in a vertical split",
				},
				["<c-x>"] = {
					"actions.select",
					opts = { horizontal = true },
					desc = "Open the entry in a horizontal split",
				},
				["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
				["gp"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<Esc>"] = "actions.close",
				["r"] = "actions.refresh",
				["yy"] = "actions.yank_entry",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
				["gs"] = "actions.change_sort",
				["gt"] = { "actions.open_terminal", opts = { scope = "tab" } },
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
			-- [2]&~
			-- ~& [ Window Options ]
			float = {
				padding = 2,
				max_width = 54,
				max_height = 15,
				border = "rounded",
				win_options = {
					winblend = 15,
				},
				-- preview_split: Split direction: "auto", "left", "right", "above", "below".
				preview_split = "auto",
				override = function(conf)
					return conf
				end,
			},
			preview = {
				-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- min_width and max_width can be a single value or a list of mixed integer/float types.
				-- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
				max_width = { 100, 0.9 },
				-- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
				min_width = { 80, 0.8 },
				-- optionally define an integer/float for the exact width of the preview window
				width = nil,
				-- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- min_height and max_height can be a single value or a list of mixed integer/float types.
				-- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
				max_height = { 90, 0.9 },
				-- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
				min_height = { 20, 0.20 },
				-- optionally define an integer/float for the exact height of the preview window
				height = nil,
				border = "rounded",
				win_options = {
					winblend = 15,
				},
				update_on_cursor_moved = true,
			},
			progress = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = { 10, 0.9 },
				min_height = { 5, 0.1 },
				height = nil,
				border = "rounded",
				win_options = {
					winblend = 15,
				},
			},
			-- Configuration for the floating SSH window
			ssh = {
				border = "rounded",
			},
			-- Configuration for the floating keymaps help window
			keymaps_help = {
				border = "rounded",
			},
			-- EXPERIMENTAL support for performing file operations with git
			-- git = {
			-- 	-- Return true to automatically git add/mv/rm files
			-- 	add = function(path)
			-- 		return false
			-- 	end,
			-- 	mv = function(src_path, dest_path)
			-- 		return false
			-- 	end,
			-- 	rm = function(path)
			-- 		return false
			-- 	end,
			-- },
		})
		vim.keymap.set("n", "<space>-", require("oil").toggle_float)
		vim.keymap.set("n", "<space>N", require("oil").open)
	end,
}
--  vim: ft=lua ts=2 sw=2 sts=2 tw=78 et:
return M
-- [2]&~
