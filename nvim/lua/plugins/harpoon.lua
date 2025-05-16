-- ~& [ harpoon.lua ] [ Last Update: 2024-10-24 13:30 ]
--    _
--   | |__   __ _ _ __ _ __   ___   ___  _ __
--   | '_ \ / _` | '__| '_ \ / _ \ / _ \| '_ \
--   | | | | (_| | |  | |_) | (_) | (_) | | | |
--   |_| |_|\__,_|_|  | .__/ \___/ \___/|_| |_|
--                    |_|
--                                      ~cf.[0]&~

-- ~& [ Harpoon Module ] ~&~
local M = {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
  -- [3]&~
  -- ~& [ Configuration ]
	config = function()
		local ok, harpoon = pcall(require, "harpoon")
          if not ok then
            return
          end
		harpoon:setup({})
		vim.keymap.set("n", "hf", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<leader>H", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
		-- [3]&~
		-- ~& [ Telescope Menu ]
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)

            local scbin = vim.fn.expand('~/.local/bin')
            local home = os.getenv("HOME")
            local relative = vim.fn.expand('%:p')

			local file_paths = { home, scbin, relative }

			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				}):find()
		end
		vim.keymap.set("n", "<leader>ht", function()
			toggle_telescope(harpoon:list())
		end, { desc = "[H]arpoon [T]oggle" })
	end,
}
-- ~&~
return M
-- vim: ft=lua:syn=lua:tw=78:ts=4:sts=2:sw=2:et:
-- ~&~
