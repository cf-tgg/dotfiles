-- ~& [ telescope.lua ] [ Last Update: 2024-10-25 02:08 ]
--   _____    _
--  |_   _|__| | ___  ___  ___ ___  _ __   ___
--    | |/ _ \ |/ _ \/ __|/ __/ _ \| '_ \ / _ \
--    | |  __/ |  __/\__ \ (_| (_) | |_) |  __/
--    |_|\___|_|\___||___/\___\___/| .__/ \___|
--                                 |_|
--                                        ~cf.[0]&~

-- ~& [ Telescope Module ] ~&~
local M = {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	-- [3]&~
	-- ~& [ Main Configuration ]
	config = function()
		require("telescope").setup({
			defaults = { --TODO: write window selection handler
				get_selection_window = function()
					return 0
				end,
				color_devicons = {
					cond = function()
						return vim.g.termguicolors == true
					end,
				},
				layout_strategy = "flex",
				layout_config_defaults = {
					horizontal = {
						width = 0.9,
						height = 0.8,
						prompt_position = "bottom",
						preview_cutoff = 120,
					},
					vertical = {
						width = 0.9,
						height = 0.8,
						prompt_position = "bottom",
						preview_cutoff = 90,
					},
					center = {
						width = 0.5,
						height = 0.4,
						preview_cutoff = 90,
						prompt_position = "top",
					},
					cursor = {
						width = 0.9,
						height = 0.9,
						preview_cutoff = 90,
					},
					bottom_pane = {
						height = 25,
						prompt_position = "top",
						preview_cutoff = 120,
					},
					preview = {
						treesitter = true,
						msg_bg_fillchar = "~",
					},
					winopts = {
						layout_strategy = "flex",
						winblend = 15,
						border = "rounded",
						borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					},
				},
				actions = {
					mappings = {
						i = {
							["<c-c>"] = "close",
							["<Esc>"] = "close",
							["<c-enter>"] = "to_fuzzy_refine",
							["c-s>"] = "insert_symbol_i",
							["<c-h>"] = "toggle_preview",
							["<c-p>"] = "move_selection_previous",
							["<c-n>"] = "move_selection_next",
							["<c-s>"] = "select_horizontal",
							["<c-d>"] = "delete_buffer",
							["<c-e>"] = "select_vertical",
							["<c-b>"] = "preview_scrolling_up",
							["<c-f>"] = "preview_scrolling_down",
							["EE"] = "file_edit",
							["<c-t>"] = "file_tab",
							["gv"] = "file_vsplit",
							["<c-x>"] = "file_split",
							["<c-i>"] = "file_split",
							["<c-q>"] = "send_to_qflist",
							["<c-l>"] = "send_to_loclist",
							["<c-y>"] = "yank",
						},
						n = {
							["p"] = "toggle_preview",
							["al"] = "add_selected_to_loclist",
							["aq"] = "add_selected_to_qflist",
							["<Tab>"] = "add_selection",
							["cc"] = "center",
							["<Esc>"] = "close",
							["qq"] = "close",
							["DD"] = "delete_buffer",
							["e"] = "file_edit",
							["<c-x>"] = "file_split",
							["<c-i>"] = "file_split",
							["<c-t>"] = "file_tab",
							["gv"] = "file_vsplit",
							["S"] = "insert_symbol",
							["I"] = "insert_value",
							["<c-b>"] = "preview_scrolling_down",
							["<leader>q"] = "open_qflist",
							["ol"] = "open_loclist",
							["PP"] = "paste_register",
							["Gs"] = "git_apply_stash",
							["Ggc"] = "git_checkout",
							["GCb"] = "git_checkout_current_buffer",
							["Gcb"] = "git_create_branch",
							["Gdb"] = "git_delete_branch",
							["Gm"] = "git_merge_branch",
							["RB"] = "git_rebase_branch",
							["gs"] = "git_staging_toggle",
							["gb"] = "git_switch_branch",
							["Gtb"] = "git_track_branch",
						},
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- "smart_case"||"ignore_case"||"respect_case"
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						layout_strategy = "flex",
						border = "rounded",
						previewer = true,
						winblend = 25,
						pumblend = 25,
						blend = 30,
					}),
				},
			},
		})
		-- [3]&~
		-- ~& [ Extensions ]
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "actions")
		pcall(require("telescope").load_extension, "previewers.utils")
		-- [3]&~
		-- ~& [ Keymaps ]
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect" })
		vim.keymap.set("n", "<leader>sp", builtin.spell_suggest, { desc = "[S]earch S[p]elling" })
		vim.keymap.set("n", "<leader>sH", builtin.highlights, { desc = "[S]earch [H]ighlights" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sM", builtin.man_pages, { desc = "[S]earch [M]an Pages" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sR", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>sr", builtin.registers, { desc = "[S]earch [r]egisters" })
		vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch [.] Recent" })
		vim.keymap.set("n", "<leader>st", builtin.tagstack, { desc = "[S]earch [t]agstack" })
		vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "[S]earch [m]arks" })
		vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "[S]earch [J]umplist" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sa", builtin.autocommands, { desc = "[S]earch [A]utocommands" })
		vim.keymap.set("n", "<leader>sy", builtin.lsp_document_symbols, { desc = "[S]earch [S]ymbols" })
		vim.keymap.set("n", "<leader>sl", builtin.lsp_references, { desc = "[S]earch [L]sp References" })
		vim.keymap.set("n", "<leader>sG", builtin.git_files, { desc = "[S]earch [G]it Files" })
		vim.keymap.set("n", "<leader>si", builtin.lsp_implementations, { desc = "[S]earch [l]sp [i]mplementation" })

		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				layout_strategy = "flex",
				previewer = true,
				winblend = 20,
				pumblend = 20,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })


		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				layout_strategy = "flex",
				grep_open_files = true,
				border = "rounded",
				prompt_title = "~ Live Grep ~",
				previewer = true,
				blend = 25,
			})
		end, { desc = "[S]earch [/] in Open Files" })

		vim.keymap.set("n", "<leader>q", function()
			builtin.quickfixhistory({ previewer = true })
		end, { desc = "[Q]uick [F]ix" })

		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config"), previewer = true, prompt_title = "~ Neovim Files ~", })
		end, { desc = "[S]earch [N]eovim" })

		vim.keymap.set("n", "<leader>ss", function()
			builtin.find_files({ cwd = vim.fn.expand("~/.local/bin"), prompt_title = "~/Scripts", })
		end, { desc = "[S]earch [S]cripts" })

  	vim.keymap.set("n", "<leader>st", function()
			builtin.find_files({ cwd = vim.fn.expand("~/Templates"), prompt_title = "~/Templates", })
		end, { desc = "[S]earch [T]emplates" })

  	vim.keymap.set("n", "<leader>sd", function()
			builtin.find_files({ cwd = vim.fn.expand("~/Documents"), prompt_title = "~/Documents", })
		end, { desc = "[S]earch [D]ocuments" })

		vim.keymap.set("n", "<leader>sj", function()
			builtin.jumplist(require("telescope.themes").get_dropdown({
				border = "rounded",
				previewer = true,
				layout_strategy = "flex",
				layout_config = { height = 0.8, width = 0.95 },
				prompt_title = "~ Jump List ~",
				blend = 20,
				show_line = true,
			}))
		end, { desc = "[S]earch [J]umplist" })
	end,
}

-- ~&~
return M
-- vim: ft=lua:ts=2:sts=12:sw=2:tw=78:et:
-- ~&~
