-- ~& [ toggleterm.lua ] [ Last Update: 2024-10-24 13:26 ]
--  _                    _        _
-- | |_ ___   __ _  __ _| | ___  | |_ ___ _ __ _ __ ___
-- | __/ _ \ / _` |/ _` | |/ _ \ | __/ _ \ '__| '_ ` _ \
-- | || (_) | (_| | (_| | |  __/ | ||  __/ |  | | | | | |
--  \__\___/ \__, |\__, |_|\___|  \__\___|_|  |_| |_| |_|
--           |___/ |___/
--                                             ~cf.[0]&~
-- ~& [ Toggleterm Module ] ~&~
local M = {}

local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
  return
end

-- [2]&~
-- ~& [ Default Config ]
toggleterm.setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 12
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = false,
	shading_factor = nil,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "FloatBorder",
			background = "Normal",
		},
	},
})
-- [2]&~
-- ~& [ Terminal Wrappers ]
local T = {}
local Terminal = require("toggleterm.terminal").Terminal
local is_fullscreen = false
local toggle_fullscreen = function(term)
	term:close()
    vim.cmd(":redraw!")
	if is_fullscreen then
		term = Terminal:new({
			cmd = term.cmd,
			direction = term.direction,
			float_opts = { width = 100, height = 30 },
			on_open = function(term)
				local bufnr = term.bufnr
				vim.api.nvim_buf_set_name(bufnr, "[" .. bufnr .. "] " .. term.name)
			end,
            close_on_exit = true,
		})
	else
		term = Terminal:new({
			cmd = term.cmd,
			direction = term.direction,
			float_opts = { width = vim.o.columns, height = vim.o.lines }, -- Set to fullscreen dimensions
			on_open = function(term)
				local bufnr = term.bufnr
				vim.api.nvim_buf_set_name(bufnr, "[" .. bufnr .. "] " .. term.name)
			end,
            close_on_exit = true,
		})
	end
	is_fullscreen = not is_fullscreen
	term:toggle()
end

local create_term = function(opts)
	local term = Terminal:new({
		cmd = opts.cmd,
		direction = opts.direction,
        start_in_insert = true,
		on_open = function(term)
			local bufnr = term.bufnr
			vim.api.nvim_buf_set_name(bufnr, "[" .. bufnr .. "] " .. opts.name)
			vim.keymap.set("t", "<C-f>", function()
              toggle_fullscreen(term)
			end, { noremap = true, silent = true, desc = "Toggle Fullscreen" })
		end,
	})
	-- Generate key mappings
	if opts.mapping then
		local prefix = "<C-t>"
		vim.keymap.set("n", prefix .. opts.mapping.key, function()
			term:toggle()
		end, { noremap = true, silent = true, desc = opts.mapping.desc })
	end
	-- Return the toggle functions
	return function()
		term:toggle()
	end
end
-- [2]&~
-- ~& [ Terminal Instances Definitions ]
local terms = {
	toggle_float = {
		name = "float",
		cmd = nil,
		direction = "float",
		mapping = { key = "f", desc = "Floating Term" },
	},
	toggle_lfub = {
		name = "lfub",
		cmd = "lfub",
		direction = "float",
		mapping = { key = "l", desc = "lfub float" },
	},
	split_lfub = {
		name = "lfub-split",
		cmd = "lfub",
		direction = "horizontal",
		mapping = { key = "j", desc = "lfub split" },
	},
	vsplit_lfub = {
		name = "lfub-vsplit",
		cmd = "lfub",
		direction = "vertical",
		mapping = { key = "h", desc = "lfub vsplit" },
	},
	toggle_lazygit = {
		name = "lazygit",
		cmd = "lazygit",
		direction = "float",
		mapping = { key = "g", desc = "LazyGit Float" },
	},
	split_lazygit = {
		name = "lazygit-split",
		cmd = "lazygit",
		direction = "horizontal",
		mapping = { key = "G", desc = "LazyGit Split" },
	},
}
-- Terminal instances and mappings generation
for key, value in pairs(terms) do
	T[key] = create_term(value)
end
-- [2]&~
-- ~& [ Additional Keymaps ]
function _G.set_terminal_keymaps()
	local opts = { noremap = true, silent = true }
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end
-- [count] <C-\> toggles term
vim.keymap.set("n","<c-\\>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>')
vim.keymap.set("i", "<c-\\>", '<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>')
vim.api.nvim_create_augroup("cfToggleTerm", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", { group = "cfToggleTerm", pattern = "term://*", callback = set_terminal_keymaps })
-- ~&~
return M
-- vim:ft=lua syn=lua sw=2 sts=2 ts=4 fdm=marker et:
-- ~&~
