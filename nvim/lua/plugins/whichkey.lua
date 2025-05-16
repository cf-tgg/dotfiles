-- ~& [ whichkey.lua ] [ Last Update: 2024-10-24 08:37 ]

local M = {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		local ok, wk = pcall(require, "which-key")
		if not ok then
			return
		end
		wk.setup({
			wk.add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>c_", hidden = true },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>d_", hidden = true },
				{ "<leader>h", group = "Git [H]unk" },
				{ "<leader>h_", hidden = true },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>r_", hidden = true },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>s_", hidden = true },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>t_", hidden = true },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>w_", hidden = true },
				{ "<leader>h", desc = "Git [H]unk", mode = "v" },
			}),
		})
	end,
}
return M
