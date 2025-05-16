local log_bufnr = nil

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("makeinstall", { clear = true }),
	pattern = "config.h",
	callback = function()
		-- Check if a log buffer already exists, otherwise create one
		if log_bufnr == nil or not vim.api.nvim_buf_is_valid(log_bufnr) then
			log_bufnr = vim.api.nvim_create_buf(false, true) -- Create a new buffer if none exists
			vim.cmd("split | b" .. log_bufnr) -- Open it in a split
		end

		-- Clear and update buffer with initial messages
		vim.api.nvim_buf_set_lines(log_bufnr, 0, -1, false, { "cfg updated", "recompiling..." })

		-- Get the directory of the current file (config.h)
		local file_dir = vim.fn.fnamemodify(vim.fn.expand("<afile>"), ":h")

		-- Start the compilation process in the correct directory
		vim.fn.jobstart({ "sudo", "make", "clean", "install" }, {
			cwd = file_dir, -- Change directory to where config.h is located
			on_stdout = function(_, data)
				if data then
					-- Append stdout output to the buffer
					vim.api.nvim_buf_set_lines(log_bufnr, -1, -1, false, data)
				end
			end,
			on_stderr = function(_, data)
				if data then
					-- Append stderr output to the buffer
					vim.api.nvim_buf_set_lines(log_bufnr, -1, -1, false, data)
				end
			end,
		})
	end,
})
-- vim: ft=lua ts=2 sw=2 et:
