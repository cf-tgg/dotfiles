vim.opt_local.keywordprg = ":!linkhandler \"https://developer.mozilla.org/search?topic=api\\&topic=html\\&q=\\"
vim.opt_local.keymap.append = {
	n = {
		[","] = {
			["q"] = ":!qutebrowser --target window % & <CR><CR>",
			["b"] = ":!brave % & <CR><CR>",
			["f"] = ":!firefox % & <CR><CR>",
			["c"] = ":!chromium % & <CR><CR>",
		},
	},
}
