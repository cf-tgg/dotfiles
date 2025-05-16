-- ~& [ init.lua ] [ Last Update: 2024-11-12 16:56 ]
--   _
--  | | __ _ _____   _
--  | |/ _` |_  / | | |
--  | | (_| |/ /| |_| |
--  |_|\__,_/___|\__, |
--               |___/
--                    ~cf.[0]&~


-- ~& [ lazy.nvim Setup ] ~&~

local M = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", lazyrepo, "--branch=stable", lazypath })
end

vim.opt.runtimepath:prepend(lazypath)

-- [2] &~
-- ~& [ sourcing principals ]
require("opts")
require("keymaps")
require("lazy").setup({ import = "plugins" })
require("aucmds")
require("lspconfig.configs")
-- [2] &~
return M
-- vim: ts=2 sts=2 sw=2 et:
-- [3] &~
