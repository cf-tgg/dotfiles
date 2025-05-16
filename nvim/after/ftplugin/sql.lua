M = {}

vim.opt_local.commentstring = "-- %s"

-- Check for db service in runsvdir (runit)
local function service_present(service_name)
	local service_path = "/run/runit/service/" .. service_name
	return vim.fn.isdirectory(service_path) == 1
end

-- Initialize vim.g.dbs based on available services
vim.g.dbs = {}

-- Get the base URL for MariaDB (obfuscated with pass)
local mdb_base = vim.trim(vim.fn.system("pass cf@mariadb"))

if service_present("mariadb") then
	-- Populate with MariaDB entries
	vim.g.dbs = {
		{ name = "ventes", url = mdb_base .. "ventes" },
		{ name = "Remorquage", url = mdb_base .. "Remorquage" },
		{ name = "redondance", url = mdb_base .. "redondance" },
		{ name = "Plusieurs", url = mdb_base .. "Plusieurs" },
		{ name = "Labo4", url = mdb_base .. "Labo4" },
		{ name = "jointures", url = mdb_base .. "jointures" },
		{ name = "Inventaire", url = mdb_base .. "Inventaire" },
		{ name = "Vente", url = mdb_base .. "Ventes" },
		{ name = "lavue", url = mdb_base .. "lavue" },
		{ name = "stats", url = mdb_base .. "stats" },
		{ name = "banque", url = mdb_base .. "banque" },
		{ name = "projet", url = mdb_base .. "projet" },
	}
end

-- Same thing for MongoDB entries
if service_present("mongod") then
	vim.g.dbs = vim.list_extend(vim.g.dbs, {
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
	})
end

-- Notify if no database services are active
if #vim.g.dbs == 0 then
	vim.notify("No database services are active. Skipping g.dbs setup.", 2)
end
-- Autocommands for <Plug>(DBUI_ExecuteQuery)
local JSONEXPORTDIR = "/home/cf/Templates/sql/jsonExports"

-- Create autocommand group
vim.api.nvim_create_augroup("DBUI_Commands", { clear = true })

-- Function to find the most recently modified JSON file
local function GetLastJsonExport(dir)
	local json_files = vim.fn.glob(dir .. "/*.json", true, true)
	if #json_files == 0 then
		return ""
	end
	local latest_file = ""
	local latest_mtime = 0
	for _, file in ipairs(json_files) do
		local mtime = vim.fn.getftime(file)
		if mtime > latest_mtime then
			latest_file = file
			latest_mtime = mtime
		end
	end
	return latest_file
end

-- User command for moving JSON files
vim.api.nvim_create_user_command("JSONExport", function()
	vim.notify("JSON export process started.", vim.log.levels.INFO)

	local temp_json_files = vim.fn.glob("/tmp/*.json", true, true)
	if #temp_json_files == 0 then
		vim.notify("No JSON files found in /tmp/", vim.log.levels.WARN)
		return
	end

	-- Move JSON files and change ownership
	local move_command = "sleep 2; sudo mv /tmp/*.json " .. JSONEXPORTDIR .. "; sudo chown -R cf:cf " .. JSONEXPORTDIR
	vim.fn.jobstart({ "sh", "-c", move_command }, {
		on_stdout = function(_, data)
			if data then
				vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
			end
		end,
		on_stderr = function(_, data)
			if data then
				vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
			end
		end,
		on_exit = function()
			-- Find and open the most recently modified JSON file in a new split
			local json_file = GetLastJsonExport(JSONEXPORTDIR)
			if json_file ~= "" then
				vim.cmd("split " .. json_file) -- Open the file in a split
				vim.cmd("wincmd j") -- Jump to the new split
			else
				vim.notify("No JSON file found in " .. JSONEXPORTDIR, vim.log.levels.WARN)
			end
		end,
	})
end, {})

-- Autocommand for executing after DBUI query
vim.api.nvim_create_autocmd("User", {
	group = "DBUI_Commands",
	pattern = "DBUI_ExecuteQuery",
	callback = function()
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		local query_str = table.concat(lines, " ")
		-- Check if the query contains the '/tmp/*.json' pattern
		if query_str:match("/tmp/[%w]*%.json") and query_str:match("INTO OUTFILE") then
			-- Trigger JSON export command
			vim.cmd("JSONExport")
		end
	end,
})

vim.cmd([[function! s:populate_query() abort
  let rows = db_ui#query(printf(
    \ "select column_name, data_type from information_schema.columns where table_name='%s' and table_schema='%s'",
    \ b:dbui_table_name,
    \ b:dbui_schema_name
    \ ))
  let lines = ['INSERT INTO '.b:dbui_table_name.' (']
  for [column, datatype] in rows
    call add(lines, column)
  endfor
  call add(lines, ') VALUES (')
  for [column, datatype] in rows
    call add(lines, printf('%s <%s>', column, datatype))
  endfor
  call add(lines, ')')
  call setline(1, lines)
endfunction]])

vim.cmd([[autocmd FileType sql nnoremap <buffer><leader>i :call <sid>populate_query()<CR>]])

-- 	local mdb_base = vim.trim(vim.fn.system("pass cf@mariadb"))
-- vim.g.dbs = {
-- 	{ name = "ventes", url = mdb_base .. "ventes" },
-- 	{ name = "Remorquage", url = mdb_base .. "Remorquage" },
-- 	{ name = "redondance", url = mdb_base .. "redondance" },
-- 	{ name = "Plusieurs", url = mdb_base .. "Plusieurs" },
-- 	{ name = "Labo4", url = mdb_base .. "Labo4" },
-- 	{ name = "jointures", url = mdb_base .. "jointures" },
-- 	{ name = "Inventaire", url = mdb_base .. "Inventaire" },
-- 	{ name = "Vente", url = mdb_base .. "Ventes" },
-- 	{ name = "lavue", url = mdb_base .. "lavue" },
-- 	{ name = "stats", url = mdb_base .. "stats" },
-- 	{ name = "banque", url = mdb_base .. "banque" },
-- 	{ name = "projet", url = mdb_base .. "projet" },
-- 	{
-- 		name = "mongoLocale",
-- 		url = function()
-- 			local url = vim.trim(vim.fn.system("pass mongoDB_Locale"))
-- 			return url
-- 		end,
-- 	},
-- 	{
-- 		name = "mongo_test",
-- 		url = function()
-- 			local url = vim.trim(vim.fn.system("pass mongotest"))
-- 			return url
-- 		end,
-- 	},
-- }

return M
