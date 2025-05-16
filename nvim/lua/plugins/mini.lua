-- ~& [ mini.lua ] [ Last Update: 2024-10-21 08:40 ]
--             _       _
--   _ __ ___ (_)_ __ (_)
--  | '_ ` _ \| | '_ \| |
--  | | | | | | | | | | |
--  |_| |_| |_|_|_| |_|_|
--
--                 ~cf.[0]&~

-- ~& [ mini surround motions ] ~&~
local M = {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.surround").setup()
		require("mini.ai").setup({ n_lines = 500 })
	end,
}

return M

-- vim: ft=lua ts=4 sw=2 sts=2 et:
-- [3]&~
