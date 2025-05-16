-- ~& [ trouble.lua ] [ Last Update: 2024-10-23 16:11 ]

return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
	config = function()
		local signs = {
			Error = "🈲",
			Warning = "⚠️",
			Hint = "🤔",
			Information = "ℹ️",
		}
		require("trouble").setup {
			icons = signs,
			mode = "lsp_document_diagnostics",
			auto_preview = false,
			auto_fold = true,
			use_lsp_diagnostic_signs = true,
		}
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local open_with_trouble = require("trouble.sources.telescope").open
		local add_to_trouble = require("trouble.sources.telescope").add
		vim.keymap.set("n", "<leader>xa", add_to_trouble(0, {trouble = "lsp_references"}), { noremap = true, silent = true })
		telescope.setup({
			defaults = {
				mappings = {
					i = { ["<c-t>"] = open_with_trouble },
					n = { ["<c-t>"] = open_with_trouble },
				},
			},
		})
		local config = require("fzf-lua.config")
		local action = require("trouble.sources.fzf").actions
		config.defaults.actions.files["ctrl-t"] = action.open
	end,
}
