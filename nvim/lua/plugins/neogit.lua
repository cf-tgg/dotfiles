-- ~& [ neogit.lua ] [ Last Update: 2024-10-24 13:25 ]
--                           _ _
--    _ __   ___  ___   __ _(_) |_
--   | '_ \ / _ \/ _ \ / _` | | __|
--   | | | |  __/ (_) | (_| | | |_
--   |_| |_|\___|\___/ \__, |_|\__|
--                     |___/
--
--                          ~cf.[0]&~

-- ~& [ Neogit Module ] ~&~
local M = {
	"NeogitOrg/neogit",
	lazy = true,
	ft = "git",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- diff integration
		"nvim-telescope/telescope.nvim",
	},
-- [2]&~
--	-- ~& [ Default Config ]
	config = function()
		local ok,  neogit = pcall(require,"neogit")
      if not ok then
        return
      end
		neogit.setup({})
-- [2]&~
-- ~& [ Keymaps ]
      vim.keymap.set("n", "<leader>gs", neogit.open, { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>", { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>gB", ":G blame<CR>", { silent = true, noremap = true })
	end,
}
-- ~&~
return M
-- vim:ft=lua:sw=2:ts=2:sts=2:et:
-- ~&~
