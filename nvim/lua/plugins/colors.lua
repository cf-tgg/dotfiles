-- ~& [ colors.lua ] [ Last Update: 2024-11-13 14:45 ]
--               _
--      ___ ___ | | ___  _ __ ___
--     / __/ _ \| |/ _ \| '__/ __|
--    | (_| (_) | | (_) | |  \__ \
--     \___\___/|_|\___/|_|  |___/
--                                       ~cf.[0]&~

-- ~& [ Colors & Theming Plugins  ] ~&~

-- ~& [ Noice ]
local M = {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {},
	},
	-- [3]&~
	-- ~& [ Notify ]
	{
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")
			notify.setup({
				background_colour = "NotifyBackground",
				blend = 15,
				fps = 30,
				icons = {
					ERROR = "[!]",
					WARN = "[!]",
					INFO = "[i]",
					DEBUG = "[dbg]",
					TRACE = "[trc]",
				},
				level = 2,
				minimum_width = 12,
				max_width = 80,
				minimum_height = 3,
				max_height = 15,
				render = "compact",
				stages = "fade_in_slide_out",
				time_formats = {
					notification = "%T",
					notification_history = "%FT%T",
				},
				timeout = 700,
				top_down = true,
				focus = true,
			})
		end,
	},
	-- [3]&~
	-- ~& [ Alpha  Splash Screen ]
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local startify = require("alpha.themes.startify")
			startify.file_icons.provider = "devicons"
			require("alpha").setup(startify.config)
		end,
	},
	-- [3]&~
	-- ~& [ Palette Colorscheme ]
	{
		"roobert/palette.nvim",
		dependencies = { "rose-pine/neovim" },
		lazy = false,
		priority = 1000,
		config = function()
			require("palette").setup({
				palettes = {
					rose_pine = { "rose-pine" },
					-- dark_pine = {
					-- 	color0 = "#010000",
					-- 	color1 = "#0c0c0e",
					-- 	color2 = "#1f1f2e",
					-- 	color3 = "#413f4e",
					-- 	color4 = "#2f2f2f",
					-- 	color5 = "#908caa",
					-- 	color6 = "#b293ba",
					-- 	color7 = "#e0def4",
					-- 	color8 = "#e9e9ed",
					-- },
					-- accent = "dark",
					-- state = "dark",
				},
				italics = true,
				transparent_background = true,
			})
			-- [3]&~
			-- ~& [ Highlight Groups Overrides ]
			vim.cmd.colorscheme("rose-pine")
			-- vim.cmd("colorscheme palette")

			local hi = function(hl_group, opts)
				vim.api.nvim_set_hl(0, hl_group, opts)
			end

			local overrides = {
				{ Normal = { bg = "None", fg = "NvimLightGrey3" } },
				{ NormalNC = { bg = "None", fg = "NvimLightGrey4" } },
				{ NormalFloat = { bg = "#000000", blend = 25 } },
				{ Float = { bg = "#000000", fg = "NvimDarkGrey4", blend = 25 } },
				{ FloatBorder = { bg = "None", fg = "Black", blend = 20, cterm = { bold = true, undercurl = true } } },
				{ FloatTitle = { bg = "None", fg = "NvimLightGrey4", bold = true } },
				{ WinSeparator = { bg = "None", fg = "#2f2f2f", bold = false } },
				{ TabLine = { bg = "None" } },
				{ TabLineFill = { bg = "#0f0f0f", blend = 30 } },
				{ TabLineSel = { bg = "None", fg = "NvimLightGrey4", bold = false } },
				{ TelescopeBorder = { bg = "#010000", fg = "Black", bold = true, blend = 15 } },
				{ TelescopeSelection = { bg = "#1f1f2e", fg = "NvimLightGrey4", bold = false, undercurl = false } },
				{ TelescopePreviewHyphen = { bg = "#1f1f2e", fg = "#b293ba", bold = false } },
				{ TelescopeSelectionCaret = { fg = "#b293ba", bg = "#1f1f2e", bold = false } },
				{ TelescopeNormal = { fg = "NvimDarkGrey4", bg = "#010000", blend = 20, bold = false } },
				{ TelescopePromptNormal = { fg = "NvimLightGrey4", bg = "#010000", bold = false } },
				{ Telescope = { fg = "NvimDarkGrey4", bg = "#010000", bold = false } },
				{ StatusLine = { bg = "None", bold = true, blend = 30 } },
				{ StatusLineNC = { bg = "None", blend = 35 } },
				{ StatusLineTerm = { bg = "None" } },
				{ StatusLineTermNC = { bg = "None" } },
				{ NotifyBackground = { bg = "#000000", blend = 25 } },
				{ WarningMsg = { bg = "None", fg = "NvimLightGrey3" } },
				{ Folded = { bg = "None", fg = "NvimDarkGrey4", blend = 15 } },
				{ Delimiter = { bg = "None", fg = "NvimDarkGrey3", bold = false } },
				{ Operator = { bg = "None", fg = "NvimDarkGrey4", bold = true } },
				{ WinBarNC = { fg = "#1f1f1e", bg = "#0f0f0f", blend = 60 } },
				{ QuickFixLine = { ctermfg = 14, fg = "LightSalmon" } },
				{ Pmenu = { fg = "#908caa", bg = "#000000", blend = 15 } },
				{ PmenuSel = { fg = "#e0def4", bg = "#1f1f2e" } },
				{ PmenuKind = { fg = "#2f2b2e", bg = "#010000", blend = 15 } },
				{ PmenuKindSel = { fg = "#908caa", bg = "#1f1f2e" } },
				{ PmenuExtra = { fg = "#c0b0c2", bg = "#000000", blend = 20 } },
				{ PmenuExtraSel = { fg = "#908caa", bg = "#1f1f2e" } },
				{ PmenuSbar = { bg = "#1f1b1e" } },
				{ PmenuThumb = { bg = "#000000", blend = 20 } },
				{ WinBar = { fg = "#100020", bg = "#010000" } },
				{ LineNr = { fg = "#f0def4", bg = "#1f1f2e" } },
				{ LineNrAbove = { fg = "#1f1f2e" } },
				{ LineNrBelow = { fg = "#1f1f2e" } },
				{ CursorLine = { bg = "#1f1f2e", blend = 10, underline = false, cterm = { bold = true } } },
				{ CurSearch = { fg = "#b293ba", bg = "#0c0c0e", bold = true } },
				{ CursorLineNr = { fg = "#f0def2", bg = "#1f1f2e", cterm = { bold = true } } },
				{ CursorLineSign = { fg = "#e0def4", bg = "#1f1f2e", cterm = { bold = true } } },
				{ CursorLineFold = { fg = "#e0def4", cterm = { bold = true } } },
				{ CursorColumn = { bg = "#1f1f2e" } },
				{ LspReferenceRead = { bg = "#2f1f2e" } },
				{ Visual = { bg = "#1f1f2e" } },
				{ PreCondit = { fg = "#ef8f8f", blend = 15 } },
				{ Title = { fg = "#9cb9d8", bold = true, cterm = { bold = true } } },
				{ Statement = { fg = "NvimDarkBlue", bold = true, cterm = { bold = true } } },
				{ Directory = { fg = "#b86f9e", cterm = { bold = true } } },
				{ ErrorMsg = { fg = "#e96f9f", cterm = { bold = true } } },
				{ Search = { fg = "#e2eef4", bg = "#413f4e", blend = 30 } },
				{ Question = { fg = "#e3c19c" } },
				{ Function = { fg = "#c47f9e", bold = true } },
				{ MoreMsg = { fg = "#d7a9fe" } },
				{ ModeMsg = { fg = "#908caa" } },
				{ NotifyWARNTitle = { fg = "#e1c8c7" } },
				-- { NotifyWARNIcon = { links to NotifyWARNTitle }},
				{ NotifyWARNBorder = { fg = "#e1c8c7", bg = "None" } },
				{ NotifyTRACETitle = { fg = "#c47f97" } },
				-- { NotifyTRACEIcon = { links to NotifyTRACETitle }},
				{ NotifyTRACEBorder = { fg = "#c47f97", bg = "None" } },
				{ NotifyINFOTitle = { fg = "#9c8cac", blend = 10 } },
				-- { NotifyINFOIcon = { links to NotifyINFOTitle }},
				{ NotifyINFOBorder = { fg = "#9c8cac", blend = 10, bg = "None" } },
				{ NotifyERRORTitle = { fg = "#e96f9f", blend = 10 } },
				-- { NotifyERRORIcon = { links to NotifyERRORTitle }},
				{ NotifyERRORBorder = { fg = "#e96f9f", blend = 10, bg = "None" } },
				{ NotifyDEBUGTitle = { fg = "#f6c1cb" } },
				-- { NotifyDEBUGIcon = { links to NotifyDEBUGTitle }},
				{ NotifyDEBUGBorder = { fg = "#6e6a86", bg = "None" } },
			}
			-- ~& [ Highlight Groups Overrides ]
			for _, override in ipairs(overrides) do
				local group, opts = next(override)
				hi(group, opts)
			end
		end,
	},
}

return M

-- ~& [ Default color Names ]
-- Suggested color names (these are available on most systems):
--     Red		LightRed	DarkRed
--     Green	LightGreen	DarkGreen	SeaGreen
--     Blue	LightBlue	DarkBlue	SlateBlue
--     Cyan	LightCyan	DarkCyan
--     Magenta	LightMagenta	DarkMagenta
--     Yellow	LightYellow	Brown		DarkYellow
--     Gray	LightGray	DarkGray
--     Black	White
--     Orange	Purple		Violet

-- Colors which define Nvim's default color scheme:
--     NvimDarkBlue    NvimLightBlue
--     NvimDarkCyan    NvimLightCyan
--     NvimDarkGray1   NvimLightGray1
--     NvimDarkGray2   NvimLightGray2
--     NvimDarkGray3   NvimLightGray3
--     NvimDarkGray4   NvimLightGray4
--     NvimDarkGreen   NvimLightGreen
--     NvimDarkMagenta NvimLightMagenta
--     NvimDarkRed     NvimLightRed
--     NvimDarkYellow  NvimLightYellow

-- vim: ft=lua:tw=78:sw=2:sts=12:ts=2:noet:norl:
-- [2]&~
