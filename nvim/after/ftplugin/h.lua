vim.filetype = "c"
vim.opt.shiftwidth = 4
vim.b.disable_autoformat = true

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "~/.local/src/dwmblocks/config.h",
	command = "cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks; setsid dwmblocks & }",
})

-- For dwm
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "~/.local/src/dwm/config.h",
	command = "cd ~/.local/src/dwm/ && sudo make clean install && { wmreup }",
})
