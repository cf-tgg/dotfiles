-- ~& [ lazy.lua ] [ Last Update: 2025-01-08 01:59 ]
--  _                         _             _
-- | | __ _ _____   _   _ __ | |_   _  __ _(_)_ __  ___
-- | |/ _` |_  / | | | | '_ \| | | | |/ _` | | '_ \/ __|
-- | | (_| |/ /| |_| | | |_) | | |_| | (_| | | | | \__ \
-- |_|\__,_/___|\__, | | .__/|_|\__,_|\__, |_|_| |_|___/
--              |___/  |_|            |___/
--                                            cf.[0]&~

-- ~& [ General Lazy Plugins ] ~&~
local M = {
	---@diagnostic-disable-next-line: undefined-field
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},

	-- Tim Pope.
	"tpope/vim-pathogen", -- plugin manager
	"tpope/vim-sensible", -- sensible defaults
	"tpope/vim-obsession", -- better sessions
	"tpope/vim-surround", -- surrounding motions
	"tpope/vim-sleuth", -- autodetect tabstops
	"tpope/vim-repeat", -- dot repeat fix
	"tpope/vim-fugitive", -- git plugin
	"tpope/vim-rhubarb", -- fugitive helper
	"tpope/vim-dotenv", -- setup dotenvs
	"tpope/vim-projectionist", -- per project configs
	"tpope/vim-dispatch", -- async jobs
	"tpope/vim-commentary", -- comment motions
	"tpope/vim-scriptease", -- script helpers
	"tpope/vim-unimpaired", -- pairs of mappings

	"lewis6991/impatient.nvim", -- cache config for faster startup
	"vimwiki/vimwiki", -- markdown wiki notes
	"mbbill/undotree", -- branched undo history
	"ap/vim-css-color", -- css color preview
	"echasnovski/mini.ai", -- improved around insert
	"preservim/vim-pencil", -- markdown editing

	"nvim-telescope/telescope-symbols.nvim",
	"norcalli/nvim-colorizer.lua",
	"David-Kunz/gen.nvim",
	"aaron-p1/match-visual.nvim",
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			require("orgmode").setup({
				org_agenda_files = "~/Documents/Agenda/**/*",
				org_default_notes_file = "~/Documents/Notes/**/*",
			})
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				ignore_install = { "org" },
			})
		end,
	},
	{
		"akinsho/org-bullets.nvim",
		concealcursor = false,
		symbols = {
			headlines = { "◉", "○", "✸", "✿" },
			list = "•",
		},
		opts = {},
	},
	{ -- toggle terminals
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
	{ -- fast pairmatching
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{ -- indenting ux
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "¦",
				tab_char = "¦",
				priority = 50,
			},
		},
	},
	-- {
	-- 	"github/copilot.vim",
	-- 	enable = false,
	-- 	config = function()
	-- 		vim.cmd([[ silent! Copilot enable | silent! Copilot setup ]])
	-- 	end,
	-- },
	-- { "glacambre/firenvim", build = ":call firenvim#install(0)" },
	-- [3]&~
	-- ~& [ fallback icons ]
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
}

return M

-- vim: ft=lua: tw=120 ts=2 sw=2 et:
-- [4]&~
