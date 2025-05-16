return {
	"HakonHarnes/img-clip.nvim",
	event = "VeryLazy",
	opts = {
		dir_path = vim.fn.expand("~/Pictures/img-clip"),
		extension = "png",
		file_name = "%Y-%m-%d-%H-%M-%S",
		use_absolute_path = false,
		relative_to_current_file = false,
		prompt_for_file_name = false,
		insert_mode_after_paste = false,
		download_images = true,
		copy_images = true,
		process_cmd = "scope -",
		drag_and_drop = {
			enable = true,
			insert_mode = false,
		},
	},

	filetypes = {
		markdown = {
			url_encode_path = true,
			template = "![$CURSOR]($FILE_PATH)",
			download_images = true,
		},
		vimwiki = {
			url_encode_path = true,
			template = "![$CURSOR]($FILE_PATH)",
			download_images = true,
		},
		html = {
			template = '<img src="$FILE_PATH" alt="$CURSOR">',
		},
	},

	keys = {
		{ "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
	},
}
