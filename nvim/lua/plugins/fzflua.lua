-- ~& [ fzflua.lua ] [ Last Update: 2024-10-24 09:56 ]
--     __          __        _
--    / _|  ____  / _|      | |_   _  __ _
--   | |_  |_  / | |_   ___ | | | | |/ _` |
--   |  _|  / /  |  _| |__| | | |_| | (_| |
--   |_|   /___| |_|        |_|\__,_|\__,_|
--
--                                   ~cf.[0]&~

-- ~& [ fzf-lua Module ] ~&~
local M = { "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" },
-- [2]&~
-- ~& [ config ]
	config = function()
		local ok, fzf = pcall(require, "fzf-lua")
		if not ok then
			return
		end
    --[2]&~
-- ~& [ telescope integration ]
		fzf.setup({ "telescope" })
	end,
}
-- ~&~
return M
-- vim:ft=lua:sw=2:ts=2:sts=2:et:
-- ~&~
