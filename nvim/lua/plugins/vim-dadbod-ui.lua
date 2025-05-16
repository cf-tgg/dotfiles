-- ~& [ vim-dadbod-ui.lua ] [ Last Update: 2024-10-21 06:59 ]

local M = {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{
			"kristijanhusak/vim-dadbod-completion",
			ft = { "sql", "mysql", "plsql", "sqlls" },
			lazy = true,
		},
		{ "hrsh7th/nvim-cmp" },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		-- local cmp = require("cmp")
		-- cmp.setup.buffer { sources = { { name = "vim_dadbod_completion" } } }
		-- cmp.sources:prepend { name = "vim_dadbod_completion" }
		-- vim.g.cmp.sources.vim_dadbod_completion = true
		-- vim.g.cmp.source.vim.dadbod_completion = true
		-- vim.cmd([[ let g:compe.source.vim_dadbod_completion = v:true ]])
		vim.cmd([[
			autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
		]])
		vim.g.db_ui_winwidth = 25
		vim.g.db_ui_show_help = 1
		vim.g.db_ui_auto_execute_table_helpers = 1
		vim.g.db_ui_use_nerd_fonts = 1
	end,
}

return M
