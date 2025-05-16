-- ~& [ opts.lua ] [ Last Update: 2024-11-12 16:53 ]
--              _   _
--   ___  _ __ | |_(_) ___  _ __  ___
--  / _ \| '_ \| __| |/ _ \| '_ \/ __|
-- | (_) | |_) | |_| | (_) | | | \__ \
--  \___/| .__/ \__|_|\___/|_| |_|___/
--       |_|
--                            cf.[0]&~

-- ~& [ Main Options ] ~&~ ~& [ Host Programs Paths ]

local host_path = function(program)
	local prog = vim.fn.exepath(program)
	return prog ~= prog or nil
end

local hosts = {
	node_host_prog = "node",
	perl_host_prog = "perl",
	python3_host_prog = "python3",
	ruby_host_prog = "ruby",
	composer_host_prog = nil,
	julia_host_prog = nil,
}

for k, v in pairs(hosts) do
	local host = host_path(v)
	if host then
		vim.g[k] = host
	end
end

-- [3]&~
-- ~& [ Copilot copilot_workspace_folders ]
local nvimpath = vim.fn.stdpath("config") .. "/nvim"
local lazypath = vim.fn.stdpath("data") .. "/nvim/lazy"
local scriptpath = vim.fn.expand("~/.local/bin")
local buildpath = vim.fn.expand("~/.local/src")

-- [3]&~
-- ~& [ Global Variables ]
local globs = {
	mapleader = " ",
	maplocalleader = " ",
	termguicolors = true,
	have_nerd_font = true,
	copilot_workspace_folders = { nvimpath, lazypath, scriptpath, buildpath },
}
-- [3]&~
-- ~& [ Opt Table ]
local opts = {
	mousemodel = "extend",
	-- appearance
	foldmethod = "marker",
	foldmarker = "~&,]&~",
	foldlevel = 1,
	cursorline = true,
	smartindent = true,
	relativenumber = true,
	number = true,
	expandtab = true,
	autoindent = true,
	signcolumn = "auto",
	colorcolumn = nil,
	shiftwidth = 2,
	softtabstop = 2,
	tabstop = 2,
	wrap = false,
	showmode = false,
	cmdheight = 1,
	laststatus = 3,
	scrolloff = 12,
	showcmdloc = "tabline",
	-- tabline = "",
	backspace = "indent,eol,start",
	completeopt = "menuone,noselect,noinsert",
	-- search
	inccommand = "split",
	incsearch = true,
	hlsearch = true,
	ignorecase = true,
	smartcase = true,
	-- Behavior
	hidden = true,
	backup = false,
	undofile = true,
	swapfile = false,
	errorbells = false,
	undodir = vim.fn.stdpath("data") .. "/nvim/saves/undodir",
	autochdir = true,
	splitbelow = true,
	splitright = true,
	modifiable = true,
	updatetime = 420,
	timeoutlen = 300,
	spelllang = "en",
	shortmess = "AaCclFImosTtW",
	showfulltag = true,
	virtualedit = "block",
	list = true,
	listchars = { trail = "ܚ", nbsp = "ܚ", tab = "» " },
}

for k, v in pairs(globs) do
	vim.g[k] = v
end

for k, v in pairs(opts) do
	vim.opt[k] = v
end

vim.opt.mouse:append("a")
vim.opt.clipboard:append("unnamedplus")
vim.opt.iskeyword:append("-")
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
-- vim:ft=lua:tw=78:ts=2:sw=2:sts=2:
-- [2]&~
