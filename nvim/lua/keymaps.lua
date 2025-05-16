-- ~& [ keymaps.lua ] [ Last Update: 2024-12-20 04:43 ]
--        __   _
--   ___ / _| | | _____ _   _ _ __ ___   __ _ _ __  ___
--  / __| |_  | |/ / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
-- | (__|  _| |   <  __/ |_| | | | | | | (_| | |_) \__ \
--  \___|_|   |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
--                      |___/                |_|
--
--                                              ~cf.[0]&~

-- ~& [ Main Remaps ]
-- ~& [ Shorthand Helpers ]
local map = function(mode, keys, func, opts, desc)
	local keyopts = vim.tbl_extend("force", {}, { noremap = false, silent = true })
	if type(opts) == "string" then
		keyopts.desc = opts
	elseif type(opts) == "table" then
		keyopts = vim.tbl_extend("force", keyopts, opts)
	end
	if desc then
		keyopts.desc = desc
	end
	vim.keymap.set(mode, keys, func, keyopts)
end
local noremap = function(mode, keys, func, opts)
	local defaults = { noremap = true, silent = true }
	if type(opts) == "table" then
		defaults = vim.tbl_extend("force", defaults, opts)
	end
	return map(mode, keys, func, defaults)
end
-- [4]&~
-- ~& [ Basic Misc. ]
-- ~& [i]nsert mode failsafes
noremap("i", "jk", "<Esc>")
noremap("i", "kj", "<Esc>")
map("i", "jj", "<Esc>")
map("i", "kk", "<Esc>")
-- [5]&~
-- ~& [v]isual Mode dragging
map("x", "<c-j>", ":move '>+1<cr>gv")
map("x", "<c-k>", ":move '<-2<cr>gv")
map("x", "<c-h>", "xhP`[<C-v>`]")
map("x", "<c-l>", "xlP`[<C-v>`]")
-- [5]&~
-- ~& [v]isual mode bracing
noremap("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { nowait = true })
noremap("n", "\\q", function()
	vim.cmd.normal('viWS"')
end, { nowait = true })

-- [5]&~
-- ~& [n]ormal mode quickfix
-- ~& misc.
map({ "n", "v" }, "<leader>", "<Nop>")
map("n", "<Esc>", ":noh<CR>")
map("t", "<Esc><Esc>", "<C-\\><C-n>", "[Esc] unfocus terminal")
-- map("v", "DD", ":sort u<CR>", "[D]elete [D]uplicates")
-- [5]&~
-- ~& Keep cursor line centered while quick scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
-- [5]&~
-- ~& Delete line keeping current clipboard register content
noremap("n", "DD", '""dd')
noremap("n", "PP", "pyy")
-- [5]&~
-- ~& Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
-- [5]&~
-- ~& Incrementing
map({ "n", "x" }, "+", "<C-a>", "[+] Increment")
map({ "n", "x" }, "-", "<C-x>", "[-] Decrement")
map("x", "g+", "g<C-a>gv<C-x>gv<C-a>", "g[+] Increment")
map("x", "g-", "g<C-x>gv<C-a>gv<C-x>", "g[-] Decrement")
-- [5]&~
-- ~& Quick Quits
noremap("n", "qqq", ":q<CR>", "[q]uit [q]uit [q]uit")
noremap("n", "QQ", ":q!<CR>", "[Q]uick [Q]uit")
noremap("n", "WW", ":w!<CR>", "[W]orth [W]rite")
map("n", "WQ", ":wq<CR>", "[W]rite [Q]uit")
map("n", "WE", ":w|source % | e<CR>", "[W]rite Source [E]xecute")
map("n", "WX", ":w|:!chmod 0700 %<CR>", "[W]rite e[X]ecutable")
-- [5]&~ [4]&~ [3]&~
-- ~& [ Navigation ]
-- ~& [B]uffers
-- ~& [b]uffer actions
noremap("n", "BB", ":new<CR>", "[B]lank [B]uffer")
map("n", "bf", ":bfirst<CR>", "[b]uffer [f]irst")
map("n", "bl", ":blast<CR>", "[b]uffer [l]ast")
map("n", "bn", ":bnext<CR>", "[b]uffer [n]ext")
map("n", "bp", ":bprev<CR>", "[b]uffer [p]revious")
map("n", "bd", ":bdelete<CR>", "[b]uffer [d]elete")
map("n", "BD", ":bdelete<CR>", "[D]o [D]elete")
-- [4]&~
-- ~& [t]o motions [b]uffer nav
map("n", "th", ":bprev<CR>", "[t]o [h]")
map("n", "tj", ":bfirst<CR>", "[t]o [j]")
map("n", "tk", ":blast<CR>", "[t]o [k]")
map("n", "tl", ":bnext<CR>", "[t]o [l]")
map("n", "td", ":bdelete<CR>", "[t]o [d]elete")
-- [4]&~ [5]&~
-- ~& [W]indows
-- ~& [w]in [s]plits new
map("n", "ws", ":new<CR>", "[w]indow [s]plit")
map("n", "wv", ":vnew<CR>", "[w]indow [v]ertical")
map("n", "bv", ":vnew<CR>", "[b]uffer [v]ertical")
-- [5]&~
-- ~& [s]plit nav
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
-- [5]&~
-- ~& wincmds
map("n", "wh", ":wincmd H<CR>", "[w]incmd [h]orizontal")
map("n", "wj", ":wincmd J<CR>", "[w]incmd [j]ump")
map("n", "wk", ":wincmd K<CR>", "[w]incmd [k]")
map("n", "wx", ":wincmd x<CR>", "[w]indow e[x]change")
map("n", "bj", ":wincmd x<CR>", "[b]uff [j]ump")
noremap("n", "HH", ":ToggleSplits<CR>")
noremap("n", "LL", ":wincmd x<CR>", "[L]ook [L]eft")
-- [5]&~
-- ~& split sizing
map("n", "wm", "<C-w>10-")
map("n", "wp", "<C-w>10+")
map("n", "<M-,>", "<C-w>5<")
map("n", "<M-.>", "<C-w>5>")
map("n", "<M-t>", "<C-w>5+")
map("n", "<M-f>", "<C-w>5-")
map({ "n", "c", "t" }, "Up", "vertical resize +5")
map({ "n", "c", "t" }, "Down", "vertical resize -5")
map({ "n", "c", "t" }, "Left", "horizontal resize +5")
map({ "n", "c", "t" }, "Right", "horizontal resize -5")
-- [5]&~
-- [4]&~
-- ~& [T]ab-page nav
map("n", "<C-w><Tab>", "<cmd>tabnew|Alpha<CR>", "[Tab] Alpha")
noremap("n", "TT", ":tabnew<CR>", "[T]o [T]ab")
map("n", "tn", ":tabnext<CR>", "[t]ab [n]ext")
map("n", "tp", ":tabprev<CR>", "[t]ab [p]revious")
map("n", "<C-w>t", ":tabnew<CR>", "[t]abnew")
map("n", "<S-Tab>", ":tabprev<CR>")
-- [4]&~ [5]&~
-- ~& [ Plugin Toggles ]
-- ~& [ CopilotTesting Remaps ]
noremap("i", "<c-e>", 'copilot#Accept("\\<CR>")', { expr = true })
noremap("i", "<C-m>", "<Plug>(copilot-accept-word)")
noremap("i", "<C-f>", "<Plug>(copilot-next)")
noremap("i", "<C-a>", "<Plug>(copilot-previous)")
noremap("i", "<C-s>", "<Plug>(copilot-suggest)")
noremap("i", "<C-c>", "<Plug>(copilot-dismiss)")
noremap("n", "<leader>co", ":Copilot panel<CR><CR>")
-- [5]&~
-- ~& [ Menus ]
noremap("n", "<leader>mp", function()
	local playlist = vim.fn.expand("%:p")
	local cmd = { "linkhandler", playlist }
	if not vim.system(cmd) then
		vim.notify("Error: Could not open playlist", 4)
		return
	else
		vim.notify("linkhandler: " .. playlist, 2)
	end
end, { desc = "[M]pv [P]laylist" })
-- map("n", "<leader>mp", ":MpExec<CR>", "[M]pv [P]laylist")
map("n", "<leader>F", ":FzfLua<CR>", "[F]z[F]Lua")
map("n", "<leader>P", ":TSPlaygroundToggle<CR>", "TS [P]layground")
-- [5]&~ [4]&~ [4]&~
-- ~& [ Pfunc Remaps ]
-- ~& [ Some Lazy API Aliases ]
local augroup = function(name)
	vim.api.nvim_create_augroup(name, { clear = true })
end
local namespace = vim.api.nvim_create_namespace
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command
local hi = vim.api.nvim_set_hl
local clearbufns = vim.api.nvim_buf_clear_namespace
-- [5]&~
-- ~& [ Yank Highlights ]
autocmd("TextYankPost", {
	group = augroup("HighYank"),
	desc = "Highlight on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 360, higroup = "LspReferenceRead" })
	end,
})
noremap("n", "gi", ":Inspect<CR>", "[I]nspect")
-- [5]&~
--- ~& [ SetFileType QB ]
vim.api.nvim_create_user_command("SFT", function()
	local ft = vim.fn.input("Set filetype: ")
	if ft and ft ~= "" then
		vim.cmd("set filetype=" .. ft)
		print("Filetype set to " .. ft)
	else
		print("No filetype set.")
	end
end, { desc = "Set file type alias" })
map("n", "SFT", ":SFT<CR>", "[S]et [F]ile [T]ype")
-- [5]&~
-- ~& [ LSP ShowMeThePath ]
usercmd("ShowMeThePath", function()
	local current_path = vim.fn.expand("%:p")
	vim.notify("Current Path: " .. current_path, 2)
end, { nargs = "?" })
map({ "c", "n", "i" }, "PWD", ":ShowMeThePath<CR>", "[P]rint [W]orking [D]irectory")
-- [5]&~
-- ~& [ Sudo Write Bypass ]
usercmd("SudoWrite", ":w !sudo tee %<CR>", { nargs = 0 })
map("n", "w!!", ":w !sudo tee %<CR>", "[W]riteSudo[!][!]")
map("n", "W!", ":SudoWrite<CR>", "[W]riteSudo[!][!]")
-- [5]&~
-- ~& [ Epoch to Datetime ]
usercmd("EpochToDatetime", function(epoch)
	return os.date("%Y-%m-%d %H:%M:%S", epoch)
end, { range = true })
map("n", "<leader>EDT", ":EpochToDatetime<CR>", "[E]poch [D]ate [T]ime")
usercmd("EpochToDT", function(opts)
	local content
	local replacements = {}
	if opts.range == 0 then -- Normal mode: process the whole line
		content = vim.api.nvim_get_current_line()
	else -- Visual mode: get text in the selected range
		local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
		content = table.concat(lines, "\n") -- Join selected lines
	end
	-- Find all contiguous numbers (epochs) and replace them
	content = content:gsub("(%d+)", function(epoch_str)
		local epoch = tonumber(epoch_str)
		if epoch then
			local formatted_time = os.date("%Y-%m-%d %H:%M:%S", epoch)
			table.insert(replacements, { original = epoch_str, replacement = formatted_time })
			return formatted_time
		else
			return epoch_str -- Return the original if not a valid number
		end
	end)
	-- Apply changes to the buffer (replaces the selected range or whole line)
	if opts.range == 0 then
		vim.api.nvim_set_current_line(content) -- Normal mode, replace the whole line
	else
		local start_line = opts.line1 - 1
		local lines = vim.split(content, "\n", { plain = true })
		vim.api.nvim_buf_set_lines(0, start_line, start_line + #lines, false, lines)
	end
	-- Print replacements for confirmation
	for _, rep in ipairs(replacements) do
		print(("Replaced '%s' with '%s'"):format(rep.original, rep.replacement))
	end
end, { range = true })
map({ "n", "x", "v" }, "<leader>etd", ":EpochToDateTime<CR>", "[E]poch [T]o [D]ate")
-- [5]&~
-- ~& [ SubEnclose ]
-- Function to enclose words within a specified range
local function SubEnclose(enclose_range, sub_enclosure)
	-- Get the current cursor position
	local cursor_pos = vim.api.nvim_win_get_cursor(0)

	-- Select the content inside the specified enclosure
	vim.cmd("normal! vi" .. enclose_range)

	-- Get the selected text
	local selected_text = vim.fn.getreg('"')

	-- Check if we have selected text
	if selected_text == "" then
		print("No text selected.")
		return
	end

	-- Split the selected text into words
	local words = vim.fn.split(selected_text, "\\s\\+")

	-- Count the number of words
	local word_count = #words

	-- Move to the first word after the opening enclosure
	vim.cmd("normal! viWl")

	-- Enclose each word in the sub_enclosure character
	for _ = 1, word_count do
		-- Enclose the current word
		vim.cmd("normal! ciw" .. sub_enclosure .. vim.fn.getline(".") .. sub_enclosure)

		-- Move to the next word
		vim.cmd("normal! ww")
	end

	-- Restore the cursor position
	vim.api.nvim_win_set_cursor(0, cursor_pos)
end

-- Create a command to call the SubEnclose function
vim.api.nvim_create_user_command("SubEnclose", function(opts)
	-- Extract arguments
	local args = opts.args
	local enclose_range, sub_enclosure = args:match("(%S+)%s+(%S+)")

	-- Call the function with the specified parameters
	if enclose_range and sub_enclosure then
		SubEnclose(enclose_range, sub_enclosure)
	else
		print("Usage: :SubEnclose <enclose_range> <sub_enclosure>")
	end
end, { nargs = "*" })

-- Key mapping to use the command with Vim motions
map("n", "SE", function(input)
	input = input or vim.fn.input("Enter enclose range and sub enclosure: ")
	if input then
		vim.cmd("SubEnclose " .. input)
	end
end)
-- [4]&~
-- ~& [ LinkHandler Pipes ]
-- ~& wip
--[[    TODO: Improvement Ideas
    Refactor escaping method:
       + probably use tpopes url-encode/decode unimpaired functions)
       + or use vim.fn.shellescape() or vim.fn.fnameescape()
       + ... and maybe look into have an autocommand run a background job
       for checking if the link should expand to either:
          [-] a full url
          [-] a search query on :
            [-] a github repo
            [-] a duckduckgo band query
            [-] a referenced domain query
            [x] a mpv playlist pipe
]]
-- [5]&~
-- [4]&~
-- ~& [ HandleLink ]
-- usercmd("HandleLink", function()
-- 	vim.cmd("normal! viWy")
-- 	local keyword = vim.fn.getreg('"')
-- 	if keyword:match("%b()") then
-- 		vim.cmd("normal! vi)y")
-- 		keyword = vim.fn.getreg('"')
-- 	end
-- 	local link = nil
-- 	if keyword:match("^https?://") or keyword:match("^www") then
-- 		link = keyword:gsub("[%\"%,%']", ""):gsub("%.$", ""):gsub("#", "\\#"):gsub("?", "\\?"):gsub("=", "\\=")
-- 	elseif keyword:match("^[^/]+/[^/]+$") then
-- 		local repo = keyword:gsub("[%\"%,%']", "")
-- 		link = "https://github.com/" .. repo
-- 	elseif keyword:match("[A-Za-z0-9-_]..........") then
-- 		link = "https://youtube.com/watch?v=" .. keyword
-- 	elseif keyword:match("^https://www.youtube.com") then
-- 		link = link
-- 	else
-- 		link = keyword:gsub("[%\"%,%']", ""):gsub("%.$", ""):gsub("#", "\\#"):gsub("?", "\\?"):gsub("=", "\\=")
-- 	end
-- 	local debug_line = "Got link: " .. link
-- 	vim.notify(debug_line, 2)
-- 	vim.fn.system('linkhandler "' .. link .. '"')
-- end, { range = true })
usercmd("HandleLink", function()
	vim.cmd("normal! viWy")
	local keyword = vim.fn.getreg('"')
	if keyword:match("%b()") then
		vim.cmd("normal! vi)y")
		keyword = vim.fn.getreg('"')
	end
	local link = nil

	if keyword:match("^https?://") or keyword:match("^www") then
		if keyword:match("^https://www%.youtube%.com") then
			link = keyword:gsub("%.$", "")
		else
			link = keyword:gsub("[%\"%,%']", ""):gsub("%.$", ""):gsub("#", "\\#"):gsub("?", "\\?"):gsub("=", "\\=")
		end
	elseif keyword:match("^[^/]+/[^/]+$") then
		local repo = keyword:gsub("[%\"%,%']", "")
		link = "https://github.com/" .. repo
	elseif keyword:match("[A-Za-z0-9-_]..........") then
		link = "https://youtube.com/watch?v=" .. keyword
	else
		link = keyword:gsub("[%\"%,%']", ""):gsub("%.$", ""):gsub("#", "\\#"):gsub("?", "\\?"):gsub("=", "\\=")
	end
	local debug_line = "Got link: " .. link
	vim.notify(debug_line, 2)
	vim.fn.system('linkhandler "' .. link .. '"')
end, { range = true })
noremap({ "n", "v" }, "E", ":HandleLink<CR><CR>")
-- [5]&~
-- ~& `go` keyword pipe to linkhandler
map({ "n", "v" }, "go", function()
	local default_keywordprg = vim.o.keywordprg
	vim.o.keywordprg = ":!linkhandler"
	vim.cmd("normal! K<CR>")
	vim.o.keywordprg = default_keywordprg
end)
-- [5]&~
-- ~& [ UrlView ]
usercmd("BrowserView", function(args)
	local query = args.args
	if not query or query == "" then
		if vim.fn.mode() == "x" then
			vim.cmd("normal! gvy") -- Yank visually selected text in visual mode
		elseif vim.fn.mode() == "n" then
			vim.cmd("normal! viWy") -- Yank the current word in normal mode
		end
		query = vim.fn.getreg('"') -- Get the yank register content
	end

	local linkhandler = os.getenv("BROWSER")
	if not linkhandler then
		linkhandler = "linkhandler" -- Default handler if not set
	end

	-- Escape query string to prevent shell injection issues
	query = vim.fn.shellescape(query)

	-- Run the external link handler command
	vim.fn.system(linkhandler .. " " .. query)
end, { range = true, nargs = "*" })
map({ "n", "x" }, "BV", ":BrowserView<CR>", "[B]rowser [V]iew")
-- [4]&~
-- ~& [ w3m-ddg Selection Search ]
-- usercmd("Dw3m", function()
--   local word = vim.fn.expand("<cword>")
--   local query =  "https://duckduckgo.com/?q=" .. word
-- | local buf = vim.api.nvim_create_buf(0)
--   local term = vim.api.nvim_open_term(buf,{})
--   vim.api.nvim_open_win(buf,term)
--   vim.fn.termopen("dw3m " .. query)
-- end, { range = true })
-- [4]&~
-- ~&  FIXME: Execute visual selection
-- noremap("x", "gX", function()
-- 	vim.cmd("redir @x")
-- 	vim.cmd("silent! normal! gv")
-- 	vim.cmd("redir END")
-- 	local lines = vim.fn.getreg("x")
-- 	local exe
-- 	if lines:match("^:") then
-- 		lines = lines:gsub("^:", "")
-- 		exe = lines
-- 	else
-- 		exe = lines
-- 	end
-- 	local success, err = pcall(function()
-- 		vim.cmd(exe)
-- 	end)
-- 	if not success then
-- 		vim.notify("Error: " .. err)
-- 	end
-- end)
-- [5]&~
-- ~& [ file:/// handler ]
vim.api.nvim_create_user_command("DecodeFileStr", function()
	vim.cmd('normal! vi"')
	local file_str = vim.fn.getreg('"')
	-- Define the pattern to match "file://<path>" with the path captured in \3
	local pattern = [[file:\/\/\{2\}\(\c.*\)]]
	local match = vim.fn.matchstr(file_str, pattern, 0, "\\3")
	local absolute_path = vim.fn.fnamemodify(match, ":p")
	local function url_decode(str)
		return str:gsub("%%(%x%x)", function(hex)
			return string.char(tonumber(hex, 16))
		end)
	end
	local decoded_path = url_decode(absolute_path)
	vim.fn.setreg("u", decoded_path)
	vim.cmd.normal('"up')
end, { range = true })
map({ "n", "v", "x" }, ",df", ":DecodeFileStr<CR>", "[D]ecode [F]ile [S]tring")
-- [5]&~
-- ~& [ Help in Tabs ]
usercmd("Help", function(opts)
	vim.cmd("tab help " .. table.concat(opts.fargs, " "))
end, { range = true, nargs = "+", complete = "help", desc = "Tab [H]elp" })

local function get_help_args()
	if vim.fn.mode() == "n" then
		-- Get the current word in normal mode
		return { vim.fn.expand("<cword>") }
	elseif vim.fn.mode() == "v" then
		-- Get the selected text in visual mode
		local start_pos = vim.fn.getpos("'<")
		local end_pos = vim.fn.getpos("'>")
		local lines = vim.fn.getline(start_pos[2], end_pos[2])

		-- Sanitize lines to ensure no `nil` values
		lines = vim.tbl_filter(function(line)
			return line ~= nil
		end, lines)

		-- Process the selected range
		if #lines > 0 then
			lines[1] = string.sub(lines[1], start_pos[3])
			lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
		end

		-- Concatenate and split into words
		local combined = table.concat(lines, " ")
		local raw_words = vim.split(combined, "%s+")
		-- Ensure words are valid strings
		local words = vim.tbl_filter(function(word)
			return word ~= nil and word ~= ""
		end, raw_words)
		return words
	end
	return {}
end

-- Ensure <cword> or visual selection gets processed correctly
vim.keymap.set({ "n", "x" }, "<C-w><C-k>", function()
	local args = get_help_args()
	if #args > 0 then
		vim.cmd("Help " .. table.concat(args, " "))
	else
		vim.notify("No valid help topics selected", vim.log.levels.WARN)
	end
end, { desc = "Tab [H]elp: Expand <cword> or visual selection" })
-- [5]&~
-- ~& [ TTS Handler ]
-- ... also pipes input selections to [tts] markdown ft tab-page buffer for vimwiki journaling
vim.g.tts_bufnr = -1
usercmd("VimTTS", function()
	local lang = vim.bo.spelllang
	if lang == "" then
		lang = "en"
	end
	if lang == "fr" or lang == "fr_FR" then
		vim.g.piper_voice = "fr_FR-gilles-low"
	else
		vim.g.piper_voice = "en_US-amy-medium"
	end
	vim.cmd("normal! y<CR>")
	local file_type = vim.bo.filetype
	local text = "```" .. file_type .. "\n" .. vim.fn.getreg('"') .. "```"
	local tts_bufnr = vim.g.tts_bufnr
	if not tts_bufnr or tts_bufnr == -1 or not vim.api.nvim_buf_is_valid(tts_bufnr) then
		vim.cmd("tabnew [tts] | setlocal buftype=nofile bufhidden=hide noswapfile filetype=markdown")
		tts_bufnr = vim.api.nvim_get_current_buf()
		vim.g.tts_bufnr = tts_bufnr
	else
		local buftabinfo = vim.fn.getbufinfo(tts_bufnr)
		if buftabinfo[1] and buftabinfo[1].windows then
			local winid = buftabinfo[1].windows[1]
			vim.fn.win_gotoid(winid)
		else
			vim.cmd("tabedit " .. vim.fn.bufname(tts_bufnr))
		end
	end
	local current_line_count = vim.api.nvim_buf_line_count(tts_bufnr)
	vim.api.nvim_buf_set_lines(tts_bufnr, current_line_count, current_line_count, false, vim.split(text, "\n"))
	local stdin = vim.loop.new_pipe(false)
	local stdout = vim.loop.new_pipe(false)
	local stderr = vim.loop.new_pipe(false)
	local handle = vim.loop.spawn("tts", {
		args = { "-m", vim.g.piper_voice },
		stdio = { stdin, stdout, stderr },
	}, function(code, signal)
		vim.schedule(function()
			if code == 0 then
				vim.notify("c'est fini.", 2)
			else
				vim.notify("pas bon avec code: " .. code, 4)
			end
			stdin:close()
			stdout:close()
			stderr:close()
		end)
	end)
	vim.loop.write(stdin, text .. "\n", function(err)
		if err then
			vim.notify("pas d'pipe..." .. err, 4)
		end
		stdin:shutdown()
	end)
	if not handle then
		vim.notify("pas d'pipe...", 4)
	end
end, { range = true })
-- [t]ap [t]o speech
map("v", "tt", ":yank|VimTTS<CR><CR>", "[t]ap [t]o speech")
-- [t]o [f]rançais svp.
map("v", "tf", function()
	vim.bo.spelllang = "fr"
	vim.cmd(":yank")
	vim.cmd("VimTTS")
end)
-- [5]&~
-- ~& [ Hide Bar ]
local hide_hud = 0
local hud_opts = { number = false, relativenumber = false, ruler = false, showcmd = false, showmode = false }
noremap("n", "HB", function()
	if hide_hud == 1 then
		for k, v in pairs(hud_opts) do
			vim.o[k] = v
		end
		vim.opt.laststatus = 0
		vim.opt.showtabline = 0
		hide_hud = 0
	else
		for k, _ in pairs(hud_opts) do
			vim.o[k] = true
		end
		vim.opt.laststatus = 3
		vim.opt.showtabline = 1
		hide_hud = 1
	end
end, "[H]ide [B]ar")
-- [4]&~
-- ~& [ Split Orientation Toggle ]
usercmd("ToggleSplits", function()
	local layout = vim.fn.winlayout()
	local current_win_id = vim.api.nvim_get_current_win()
	local function find_window_orientation(node)
		if node[1] == "leaf" and node[2] == current_win_id then
			return nil -- Single Window Nop
		elseif node[1] == "col" or node[1] == "row" then
			for _, child in ipairs(node[2]) do
				if child[1] == "leaf" and child[2] == current_win_id then
					return node[1] -- Return 'col' for vertical or 'row' for horizontal
				elseif child[1] == "col" or child[1] == "row" then
					local orientation = find_window_orientation(child)
					if orientation then
						return orientation
					end
				end
			end
		end
		return nil
	end
	local orientation = find_window_orientation(layout)
	if orientation == "col" then
		vim.cmd("wincmd H") -- Move the current window to the bottom (horizontal)
	elseif orientation == "row" then
		vim.cmd("wincmd K") -- Move the current window to the right (vertical)
	end
end, { nargs = 0 })
-- [5]&~
-- ~& [ Splits Options ]
local split_id = 0
noremap("n", "<leader>R", function()
	if split_id == 0 then
		split_id = namespace("MultiSplitVisual")
		hi(split_id, "CursorLine", { bg = "#1f2f1e", blend = 10, bold = true })
		hi(split_id, "CursorLineNC", { bg = "#1f2f1e", blend = 10, bold = true })
		vim.o.cursorline = true
	else
		clearbufns(0, split_id, 0, -1)
		vim.o.cursorline = false
		split_id = 0
	end
	vim.opt_local.sidescroll = 1
	vim.opt_local.sidescrolloff = 20
	vim.opt_local.wrap = false
	vim.opt_local.number = false
	vim.opt_local.relativenumber = false
	vim.opt_local.listchars = "extends:>,precedes:<"
	vim.opt_local.list = false
	vim.cmd("redraw!")
end)
-- [5]&~
-- ~& [ Scroll Binding ]
-- ~& [ Tab Clone ]
usercmd("TabClone", function()
	-- Get the current buffer and cursor position
	local initial_buf = vim.api.nvim_get_current_buf()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local ft = vim.api.nvim_buf_get_option(initial_buf, "filetype")
	vim.o.cursorline = true

	-- Open new tab and set new buffer
	vim.cmd.tabnew("[SbVsplit]")
	local new_buf = vim.api.nvim_get_current_buf()

	-- Copy lines from the initial buffer to the new buffer
	vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, vim.api.nvim_buf_get_lines(initial_buf, 0, -1, false))

	-- Set the filetype for the new buffer
	vim.bo[new_buf].filetype = ft

	-- Create a vertical split
	local left_split = vim.api.nvim_get_current_win()
	vim.cmd.vsplit()
	local right_split = vim.api.nvim_get_current_win()

	-- Switch to the left split, set textwidth, and format content
	vim.cmd.wincmd("h")
	local lsplit_width = vim.api.nvim_win_get_width(left_split)
	local lsplit_height = vim.api.nvim_win_get_height(left_split)
	vim.bo.textwidth = lsplit_width
	vim.cmd.normal("gggqG") -- Format the entire buffer

	-- Return the cursor to its original position in the left split
	vim.api.nvim_win_set_cursor(left_split, cursor_pos)

	-- Move to the right split and adjust the cursor relative to the left split
	vim.cmd.wincmd("l")

	-- Define the offset between left and right split cursors
	local offset = lsplit_height / 2 -- Define the number of lines offset between splits
	local target_line = cursor_pos[1] + offset
	local total_lines = vim.api.nvim_buf_line_count(new_buf)

	-- Ensure the cursor in the right split stays within the buffer bounds
	if target_line > total_lines then
		target_line = total_lines
	end

	-- Set the cursor in the right split
	vim.api.nvim_win_set_cursor(right_split, { target_line, cursor_pos[2] })

	-- Enable scrollbind and set scrolloff in both splits
	vim.wo.scrollbind = true
	vim.opt_local.scrolloff = 999
	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.cmd.wincmd("h")
	vim.wo.scrollbind = true
	vim.opt_local.scrolloff = 999

	-- Set readonly for both splits
	vim.opt_local.readonly = true

	-- Check if the filetype is help or man, and make the buffer non-modifiable
	if vim.bo.filetype == "help" or vim.bo.filetype == "man" then
		vim.opt_local.modifiable = false
	end
end, { desc = "Clone buffer in new tab with vertical split and scroll binding" })
noremap("n", "TC", ":TabClone<CR>", "[T]ab [C]lone")
-- [5]&~
-- ~& [ Scroll Splits ]
usercmd("SetScrollParams", function()
	-- Get the current buffer and cursor position
	local buf = vim.api.nvim_get_current_buf()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	vim.o.cursorline = true

	-- Create a vertical split
	local left_split = vim.api.nvim_get_current_win()
	vim.cmd.vsplit()
	local right_split = vim.api.nvim_get_current_win()

	-- Switch to the left split, set textwidth, and format content
	vim.cmd.wincmd("h")
	local lsplit_width = vim.api.nvim_win_get_width(left_split)
	local lsplit_height = vim.api.nvim_win_get_height(left_split)
	-- vim.bo.textwidth = lsplit_width
	-- vim.cmd.normal("gggqG")  -- Format the entire buffer

	-- Return the cursor to its original position in the left split
	vim.api.nvim_win_set_cursor(left_split, cursor_pos)

	-- Move to the right split and adjust the cursor relative to the left split
	vim.cmd.wincmd("l")

	-- Define the offset between left and right split cursors
	local offset = lsplit_height / 2 -- Define the number of lines offset between splits
	local target_line = cursor_pos[1] + offset
	local total_lines = vim.api.nvim_buf_line_count(buf)

	-- Ensure the cursor in the right split stays within the buffer bounds
	if target_line > total_lines then
		target_line = total_lines
	end

	-- Set the cursor in the right split
	vim.api.nvim_win_set_cursor(right_split, { target_line, cursor_pos[2] })

	-- Enable scrollbind and set scrolloff in both splits
	vim.wo.scrollbind = true
	vim.opt_local.scrolloff = 999
	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.cmd.wincmd("h")
	vim.wo.scrollbind = true
	vim.opt_local.scrolloff = 999

	-- Set readonly for both splits
	vim.opt_local.readonly = true

	-- Check if the filetype is help or man, and make the buffer non-modifiable
	if vim.bo.filetype == "help" or vim.bo.filetype == "man" then
		vim.opt_local.modifiable = false
	end
end, { desc = "Set scroll parameters and binding without cloning" })
map("n", "SB", ":SetScrollParams<CR>", "[S]croll [B]ind")
-- [5]&~ [4]&~
-- ~& [ Misc. Garbage ]
-- ~& [ How I used to open links in qutebrowser ]
-- noremap("n", ",w", 'viWy:!qutebrowser --untrusted-args "$(echo "$(xclip -selection clipboard -o)")" &<CR><CR>')
-- noremap("v", ",x", ':yank|:!qutebrowser --untrusted-args "$(echo "$(xclip -selection clipboard -o)")" &<CR><CR>')
-- noremap("v", ",w", ':yank|:!qutebrowser "$(echo "$(xclip -selection clipboard -o)")" &<CR><CR>')
-- [5]&~
-- ~& [ list char toggle -- before I found yol ]
-- map("n", "<leader>lc", function()
-- 	local opt_list = vim.opt.list
-- 	if opt_list == "true" then
-- 		vim.opt.list = false
-- 	else
-- 		vim.opt.list = true
-- 	end
-- end, "Toggle [l]ist [c]hars") [5]&~
-- ~& [ Disabled ]
-- map("n", "<leader>hi", ":so $VIMRUNTIME/syntax/hitest.vim<CR>", "[H]ighlight [G]roups")
-- map("n", "E", "$")
-- map("n", "<leader>hi", ":so $VIMRUNTIME/syntax/hitest.vim<CR>", "[H]ighlight [G]roups")
-- map("n", "dsp", ":%s/((.*))/\1/g<CR><CR>", { desc = "[d]elete [s]urrround [p]arenthesis" })
-- map("n", "<leader>cs", ":%s/ $//<CR><CR>", )
-- map("n", "<leader>NF", ":LspToggleFmt<CR>", { desc = "[N]o[F]mt" })
-- map("v", "DD", ':g/^\\(.*\\)$\n\\1/d<CR>', "[D]elete [D]uplicates") --> turns out `:sort u` does it.
-- mouse jumps
-- map("n", "<X1Mouse>", "<C-o>")
-- map("n", "<X2Mouse>", "<C-i>")
-- noremap("x", "<c-k>", "xkP`[<C-v>`]")
-- noremap("x", "<c-j>", "xjP`[<C-v>`]")
-- noremap("n", "<leader>ic", ":lua require(\"image\").clear()")
-- [5]&~
-- ~& [ ModeLine EOF ]
--  vim: syn=lua:set foldmarker=~&,]&~:ft=lua:sw=2:sts=2:ts=4:tw=78:et:
