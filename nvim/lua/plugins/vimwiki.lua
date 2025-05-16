local M = {
	"vimwiki/vimwiki",
	config = function()
		local wiki_1 = {}
		wiki_1.path = "/home/cf/.local/share/vimwiki/"
		wiki_1.nested_syntaxes = { markdown = "markdown", ext = ".md", shell = "sh" }
		wiki_1.index = "main"
		vim.g.vimwiki_list = { wiki_1 }
		vim.g.vimwiki_ext2syntax = {
			[".Rmd"] = "markdown",
			[".rmd"] = "markdown",
			[".md"] = "markdown",
			[".markdown"] = "markdown",
			[".mdown"] = "markdown",
		}
		vim.api.nvim_set_keymap("n", "<leader>vw", ":VimwikiIndex<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>tw", ":VimwikiTabIndex<CR>", { noremap = true, silent = true })
	end,
}

return M
