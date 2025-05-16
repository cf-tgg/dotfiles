local setlocal = vim.opt_local

---- C-style multiline comments ----
setlocal.commentstring = "/* %s */"
setlocal.formatoptions:append("cro")
setlocal.comments = "s1:/*,mb:*,ex:*/"

---- Format options ----
setlocal.expandtab = true
setlocal.textwidth = 80
setlocal.tabstop = 2
setlocal.shiftwidth = 2

local mdb_base = vim.trim(vim.fn.system("pass cf@mariadb"))

vim.g.dbs = {
	{ name = "ventes",     url = mdb_base .. "ventes" },
	{ name = "Remorquage", url = mdb_base .. "Remorquage" },
	{ name = "redondance", url = mdb_base .. "redondance" },
	{ name = "Plusieurs",  url = mdb_base .. "Plusieurs" },
	{ name = "Labo4",      url = mdb_base .. "Labo4" },
	{ name = "jointures",  url = mdb_base .. "jointures" },
	{ name = "Inventaire", url = mdb_base .. "Inventaire" },
	{ name = "Vente",      url = mdb_base .. "Ventes" },
	{ name = "lavue",      url = mdb_base .. "lavue" },
	{ name = "stats",      url = mdb_base .. "stats" },
	{ name = "banque",     url = mdb_base .. "banque" },
	{ name = "projet",     url = mdb_base .. "projet" },
	{
		name = "mongoLocale",
		url = function()
			local url = vim.trim(vim.fn.system("pass mongoDB_Locale"))
			return url
		end,
	},
	{
		name = "mongo_test",
		url = function()
			local url = vim.trim(vim.fn.system("pass mongotest"))
			return url
		end,
	},
}
