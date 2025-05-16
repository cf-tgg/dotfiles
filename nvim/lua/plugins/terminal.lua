M = {}

-- [[ Terminal buffers settings ]]
-- local set = vim.opt_local

-- vim.api.nvim_create_autocmd("TermOpen", {
--   group = vim.api.nvim_create_augroup("custom-term-open", {}),
--   callback = function()
--     set.number = false
--     set.relativenumber = false
--     set.scrolloff = 0
--   end,
-- })

-- double Esc to unfocus term
-- -- Open split term of 12 rows
-- vim.keymap.set("n", ",st", function()
--   vim.cmd.new()
--   vim.cmd.wincmd("J")
--   vim.api.nvim_win_set_height(0, 12)
--   vim.wo.winfixheight = true
--   vim.cmd.term()
--   vim.cmd.normal("A")
-- end)

return M
