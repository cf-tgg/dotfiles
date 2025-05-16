-- ~& [ zenmode.lua ] [ Last Update: 2024-10-23 02:06 ]

local M = {
		{
		"folke/zen-mode.nvim",
			dependencies = {
			"folke/twilight.nvim",
				ft = "markdown", opts = {},
		}, opts = {
			window = {
				backdrop = 0.95,
				width = 100, -- width of the Zen window
				height = 1, -- height of the Zen window
				options = {
					signcolumn = "no", -- disable signcolumn
					number = false, -- disable number column
					relativenumber = false, -- disable relative numbers
					cursorline = false, -- disable cursorline
					cursorcolumn = false, -- disable cursor column
					foldcolumn = "0", -- disable fold column
					list = false, -- disable whitespace characters
					cmdheight = 0, -- height of the command bar
					showmode = false, -- disable the mode text
					statusline = false, -- disable the status line
					showtabline = 0, -- disable the tabline
					showcmd = false, -- disable the command in the last line of the screen
				},
			},
			plugins = {
				options = {
					enabled = true,
					ruler = true, -- disables the ruler text in the cmd line area
					showcmd = false, -- disables the command in the last line of the screen
					laststatus = 0, -- turn off the statusline in zen mode
				},
				twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
				gitsigns = { enabled = false }, -- disables git signs
				tmux = { enabled = true }, -- disables the tmux statusline
			},
		},
		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			ft = { "markdown" }, build = function()
				-- install without yarn or npm
				vim.fn["mkdp#util#install"]()
			end,
		},
		{ -- Highlight todo, notes, etc in comments
			"folke/todo-comments.nvim", event = "VimEnter",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = { signs = true },
		},
		{
			"mistricky/codesnap.nvim",
			build = "make",
			opts = {
				border = "rounded",
				blend = 10,
				has_breadcrumbs = true,
				bg_theme = "grape",
				watermark = "",
			},
		},
	},
}

vim.keymap.set("n", "gZ", "<Cmd>ZenMode<CR>", { noremap = true, silent = true })

return M
