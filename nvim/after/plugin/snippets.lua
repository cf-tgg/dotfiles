-- ~& [ snippets.lua ] [ Last Update: 2024-10-24 08:45 ]
--              _                  _
--    ___ _ __ (_)_ __  _ __   ___| |_ ___
--   / __| '_ \| | '_ \| '_ \ / _ \ __/ __|
--   \__ \ | | | | |_) | |_) |  __/ |_\__ \
--   |___/_| |_|_| .__/| .__/ \___|\__|___/
--               |_|   |_|
--                               ~cf.[0]&~

-- ~& [ LuaSnip Custom Snippets ] ~&~
local M = {}
local ok, ls = pcall(require, "luasnip")

if not ok then
	return
end
-- [3]&~
-- ~& [ Configuration ]
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local r = ls.restore_node
local sn = ls.snippet_node
local isn = ls.indent_snippet_node

-- Function to return dynamic content based on input
local function dynamic_example(args)
	return sn(nil, {
		t("Dynamic content based on: "),
		i(1, args[1]),
	})
end

-- Function to return text using function_node
local function function_example(args)
	return args[1][1]:upper()
end

ls.add_snippets("lua", {
	-- Base snippet with text, insert, and dynamic node
	s("base", {
		t("Base snippet with dynamic: "),
		i(1, "input"), -- User input
		t(", "),
		d(2, dynamic_example, { 1 }), -- Dynamic node, content changes based on input
		t("."),
		i(0), -- Final position
	}),

	-- Nested choice and snippet_node
	s("nested", {
		t("Choose option: "),
		c(1, { -- Choice node: select between options
			t("Option 1"),
			t("Option 2"),
			sn(nil, { -- Snippet node nested within choice node
				t("Nested snippet with dynamic: "),
				i(1, "input"),
				t(", "),
				d(2, dynamic_example, { 1 }), -- Dynamic node inside snippet_node
			}),
		}),
		t("."),
		i(0), -- Final position
	}),

	-- Function node example
	s("func", {
		t("Uppercased input: "),
		i(1, "input"),
		t(" => "),
		f(function_example, { 1 }), -- Function node converts input to uppercase
		t("."),
		i(0),
	}),

	-- Restore node (preserves input)
	s("restore", {
		t("Enter text: "),
		r(1, "saved_text", i(nil, "default")), -- Restore node that preserves user input
		t("."),
		i(0),
	}),

	-- Repeating insert node
	s("repeat", {
		t("Input: "),
		i(1, "input"),
		t(", Repeat: "),
		rep(1), -- Repeats input from node 1
		t("."),
		i(0),
	}),

	-- Example using fmt with placeholders
	s(
		"fmt",
		fmt("Formatted text: {}, more text: {}.", {
			i(1, "first"),
			i(2, "second"),
		})
	),

	-- Nested nodes with dynamic and function nodes inside snippet_node
	s("complex", {
		t("Complex snippet: "),
		sn(1, { -- Snippet node with dynamic content
			t("Inside snippet, dynamic: "),
			d(1, dynamic_example, { 2 }), -- Dynamic based on second input
		}),
		t(", Function result: "),
		f(function_example, { 2 }), -- Function based on second input
		i(2, "input"), -- Second input
		t("."),
		i(0),
	}),
	s("luavb", {
		t("lua << EOF"),
		t({ "", "\t" }),
		i(1, "code"),
		t({ "", "EOF" }),
	}),
	s("sh", { t("sh << EOF"), t({ "", "\t" }), i(1, "heredoc text"), t({ "", "EOF" }), i(0) }),
})

-- [3]&~
-- ~& [ The Snippets ]
-- ~& [ All ]
ls.add_snippets("all", {
	-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
	s("ternary", { i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else") }),

	s("trigger", {
		t({ "After expanding, the cursor is here -> " }),
		i(1),
		t({ "", "After jumping forward once, cursor is here -> " }),
		i(2),
		t({ "", "After jumping once more, the snippet is exited there -> " }),
		i(0),
	}),

	s("trigge", {
		i(1, "First jump"),
		t(" :: "),
		sn(2, {
			i(1, "Second jump"),
			t(" : "),
			i(2, "Third jump"),
		}),
	}),
	s("paren_change", {
		c(1, {
			sn(nil, { t("("), r(1, "user_text"), t(")") }),
			sn(nil, { t("["), r(1, "user_text"), t("]") }),
			sn(nil, { t("{"), r(1, "user_text"), t("}") }),
		}),
	}, {
		stored = {
			-- key passed to restoreNodes.
			["user_text"] = i(1, "default_text"),
		},
	}),
	s("help", {
		t({ "IFS= while read -r line ; do", "" }),
		t({ "  printf '%s\\r' \"$ {line}\" ;", "" }),
		t({ "done << EOF", "", "\t" }),
		i(1, "Short Description Of Program"),
		t({ "", "Usage: ${0} [" }),
		i(2, "Options"),
		t("] ["),
		i(3, "Arguments"),
		t({ "]", "", "Options:", "" }),
		rep(4, {
			t({ "  -" }),
			i(4, "shortop"),
			t({ " | --" }),
			i(5, "longop"),
			t({ "    " }),
			i(6, "Option description"),
			t({ "" }),
		}),
		t({ "Arguments:", "" }),
		rep(7, {
			t({ "\t", "  -" }),
			i(7, "shortarg"),
			t({ " | --" }),
			i(8, "longarg"),
			t({ "    " }),
			i(9, "Argument description"),
			t({ "" }),
		}),
		t({ "EOF", "" }),
		i(0),
	}),
	s("cblock", {
		t("```"),
		f(function()
			local content = vim.fn.getreg('"')
			local ft = vim.bo.filetype or ""
			return ft .. "\n" .. content
		end),
		t({ "", "```", "" }),
		i(0),
	}),
})
-- [4]&~
-- ~& [ Shell ]
ls.add_snippets({ "sh", "bash", "zsh" }, {
	s("forF", {
		t("for f in *."),
		i(1, "ext"),
		t({ " ; do", "    " }),
		i(2, "this"),
		t({ "", "done" }),
	}),
	s("usage", {
		t("_usage() {"),
		t("cat << EOF"),
		t("Usage: ${0} "),
		i(1, "Syntax"),
		t("\n"),
		i(2, "Description"),
		t("\n"),
		t("Options:"),
		t("\n"),
		isn(3, {
			t("-"),
			i(1, "shortOpt"),
			t("|--"),
			i(2, "longOpt"),
			t("    "),
			i(3, "Description"),
			t("\n"),
		}, rep(3)),
		t("EOF\n"),
		t("exit 1\n"),
		t("}\n"),
		i(0),
	}),
})
-- [4]&~
-- ~& [ LuaSnip Snippets Snippets ]
ls.add_snippets("lua", {
	s("s(", {
		t('s("'),
		i(1, "trigger"),
		t('", {'),
		t({ "", "\t" }),
		i(2, "content"),
		rep({
			t({ "", "\t" }),
			i(2),
		}),
		t({ "", "})" }),
		i(0),
	}),
	s("ls.", {
		t("ls."),
		i(1, "add_snippets"),
		t("("),
		c(2, {
			t('"all"'),
			t('{"sh", "bash", "zsh"}'),
			t('"lua"'),
			t('"html"'),
		}),
		t(", {"),
		t({ "", "\t" }),
		i(3, "snippet"),
		rep(4, {
			t({ "", "\t" }),
			i(3),
		}),
		t({ "", "})" }),
		i(0),
	}),
	s("c(", {
		t("c("),
		i(1, "1"),
		t(", {"),
		t({ "", "\t" }),
		i(2, "2"),
		rep({ t({ "", "\t" }), i(3) }),
		t({ "", "})" }),
		i(0),
	}),
	-- Snippet for creating a simple choice node-based snippet
	s("choice_node", {
		t('s("'),
		i(1, "trigger"), -- Insert node for trigger
		t('", {'),
		t({ "", "\t" }),
		c(2, { -- Choice node
			t("Option1"),
			t("Option2"),
		}),
		t({ "", "})" }),
		i(0), -- Final position
	}),
	-- Example of a LuaSnip c-node snippet (choice node)
	s("cnode_skel", {
		t("c("),
		i(1, "choice_index"), -- Insert node for the choice index
		t(", {"),
		t({ "", "\t" }),
		i(2, "choice_content"), -- Insert node for the choice content
		rep(2), -- Repeat the choice content
		t({ "", "})" }),
		i(0), -- Final position
	}),
})

-- [4]&~
-- ~& [ Neovim API ]

local api = vim.api
local augroup = function(name)
	return api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufWritePost", "BufFilePost" }, {
	group = augroup("CfSnippetReSource"),
	pattern = vim.fn.stdpath("config") .. "/nvim/after/plugin/snippets.lua",
	callback = function()
		if ls then
			ls.cleanup()
			vim.cmd("source " .. vim.fn.stdpath("config") .. "/nvim/after/plugin/snippets.lua")
			ls.snippets = require("snippets")
		end
	end,
})
local auapi = {
	"local api = vim.api",
	"local augroup = function(name)",
	"\treturn api.nvim_create_augroup(name, {clear = true})",
	"end",
	"local usercmd = vim.api.nvim_create_user_command",
	"local autocmd = function(event, pattern, group, fun, opts)",
	"\treturn api.nvim_create_autocmd(event, {",
	"\tgroup = augroup(group),",
	'\tpattern = pattern or "*",',
	"\tcallback = function()",
	"\tfun",
	"\tend})",
}

local function get_autocmd_events()
	local events = {
		"BufAdd",
		"BufDelete",
		"BufEnter",
		"BufFilePost",
		"BufFilePre",
		"BufHidden",
		"BufLeave",
		"BufModifiedSet",
		"BufNew",
		"BufNewFile",
		"BufRead or BufRe",
		"BufReadCmd",
		"BufReadPre",
		"BufUnload",
		"BufWinEnter",
		"BufWinLeave",
		"BufWipeout",
		"BufWrite or BufW",
		"BufWriteCmd",
		"BufWritePost",
		"ChanInfo",
		"ChanOpen",
		"CmdUndefined",
		"CmdlineChanged",
		"CmdlineEnter",
		"CmdlineLeave",
		"CmdwinEnter",
		"CmdwinLeave",
		"ColorScheme",
		"ColorSchemePre",
		"CompleteChanged",
		"CompleteDonePre",
		"CompleteDone",
		"CursorHold",
		"CursorHoldI",
		"CursorMoved",
		"CursorMovedI",
		"DiffUpdated",
		"DirChanged",
		"DirChangedPre",
		"ExitPre",
		"FileAppendCmd",
		"FileAppendPost",
		"FileAppendPre",
		"FileChangedRO",
		"FileChangedShell",
		"FileChangedShell",
		"FileReadCmd",
		"FileReadPost",
		"FileReadPre",
		"FileType",
		"FileWriteCmd",
		"FileWritePost",
		"FileWritePre",
		"FilterReadPost",
		"FilterReadPre",
		"FilterWritePost",
		"FilterWritePre",
		"FocusGained",
		"FocusLost",
		"FuncUndefined",
		"UIEnter",
		"UILeave",
		"InsertChange",
		"InsertCharPre",
		"InsertEnter",
		"InsertLeavePre",
		"InsertLeave",
		"MenuPopup",
		"ModeChanged",
		"OptionSet",
		"QuickFixCmdPre",
		"QuickFixCmdPost",
		"QuitPre",
		"RemoteReply",
		"SearchWrapped",
		"RecordingEnter",
		"RecordingLeave",
		"SafeState",
		"SessionLoadPost",
		"SessionWritePost",
		"ShellCmdPost",
		"Signal",
		"ShellFilterPost",
		"SourcePre",
		"SourcePost",
		"SourceCmd",
		"SpellFileMissing",
		"StdinReadPost",
		"StdinReadPre",
		"SwapExists",
		"Syntax",
		"TabEnter",
		"TabLeave",
		"TabNew",
		"TabNewEntered",
		"TabClosed",
		"TermOpen",
		"TermEnter",
		"TermLeave",
		"TermClose",
		"TermRequest",
		"TermResponse",
		"TextChanged",
		"TextChangedI",
		"TextChangedP",
		"TextChangedT",
		"TextYankPost",
		"User",
		"UserGettingBored",
		"VimEnter",
		"VimLeave",
		"VimLeavePre",
		"VimResized",
		"VimResume",
		"VimSuspend",
		"WinClosed",
		"WinEnter",
		"WinLeave",
		"WinNew",
		"WinScrolled",
		"WinResized",
	}
	return events
end

local modes = { "n", "i", "v", "x", "c", "t", "s", "o", "l", "" }
local function get_vim_mappings(mode)
	local mappings = vim.api.nvim_get_keymap(mode)
	local map_list = {}
	for _, map in ipairs(mappings) do
		table.insert(map_list, map.lhs)
	end
	return map_list
end

local function get_modes()
	local mode_list = { "n", "i", "v", "x", "c", "t", "s", "o", "l", "" }
	return mode_list
end

local function get_vim_commands()
	local commands = vim.api.nvim_get_commands({})
	local cmd_list = {}
	for cmd, _ in pairs(commands) do
		table.insert(cmd_list, cmd)
	end
	return cmd_list
end

local function get_vim_options()
	local options = vim.api.nvim_get_all_options_info()
	local opts_list = {}
	for opt, _ in pairs(options) do
		table.insert(opts_list, opt)
	end
	return opts_list
end

local function get_mappings(mode)
	local m = mode or "n"
	local mappings = vim.api.nvim_get_keymap(m)
	local map_list = {}
	for _, map in ipairs(mappings) do
		table.insert(map_list, map.lhs)
	end
	return map_list
end

local function get_commands()
	local commands = vim.api.nvim_get_commands({})
	local cmd_list = {}
	for cmd, _ in pairs(commands) do
		table.insert(cmd_list, cmd)
	end
	return cmd_list
end

local function get_buffers()
	local buffers = vim.api.nvim_list_bufs()
	local buf_list = {}
	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf) then
			table.insert(buf_list, vim.api.nvim_buf_get_name(buf))
		end
	end
	return buf_list
end

local function get_filetypes()
	local filetypes = vim.api.nvim_get_filetypes()
	return filetypes
end

local function get_colorschemes()
	local colorschemes = vim.api.nvim_get_colorschemes()
	return colorschemes
end

local function get_highlights()
	local highlights = vim.api.nvim_get_highlights()
	return highlights
end

local function get_options()
	local options = vim.api.nvim_get_options({})
	local opts_list = {}
	for opt, _ in pairs(options) do
		table.insert(opts_list, opt)
	end
	return opts_list
end

local function get_scopes()
	local scopes = vim.api.nvim_get_scopes()
	return scopes
end

local augroup = function(name)
	return api.nvim_create_augroup(name, { clear = true })
end

local autocmd = function(event, group, fun, opts)
	return api.nvim_create_autocmd(event, {
		group = augroup(group),
		pattern = opts.pattern or "*",
		callback = fun,
	})
end

local usercmd = vim.api.nvim_create_user_command
local helperfuncs = {
	get_vim_mappings,
	get_vim_commands,
	get_vim_options,
	get_mappings,
	get_commands,
	get_buffers,
	get_filetypes,
	get_colorschemes,
	get_highlights,
	get_options,
	get_scopes,
}

usercmd("RegRedirect", function(funcs, use_buffer)
	local functions = helperfuncs or vim.tbl_extend("force", helperfuncs, funcs)
	-- Ensure we don't exceed 26 registers (a to z)
	if #functions > 26 then
		error("Too many functions to assign to registers")
	end

	local buffer_output = {}

	for i, func in ipairs(functions) do
		-- Capture the function output
		local output = func()
		-- Redirect to a named register, starting from 'a'
		local register = string.char(96 + i) -- ASCII value of 'a' is 97
		if type(output) == "table" then
			-- Join the table content as a string to store in the register
			local joined_output = vim.inspect(output)
			vim.fn.setreg(register, joined_output)
			-- Optionally add the table's string output to buffer output
			if use_buffer then
				table.insert(buffer_output, "Register '" .. register .. "':\n" .. joined_output)
			end
		else
			vim.fn.setreg(register, tostring(output))
			-- Optionally add the non-table output to buffer output
			if use_buffer then
				table.insert(buffer_output, "Register '" .. register .. "': " .. tostring(output))
			end
		end
	end
	-- If requested, print all outputs to a new buffer
	if use_buffer then
		vim.api.nvim_create_buf(false, true)
		vim.bo[0].filetype = "lua"
		vim.api.nvim_buf_set_lines(0, 0, -1, false, buffer_output)
	end
end, { bang = true, nargs = "*" })

ls.add_snippets("lua", {
	s("auapi", { t(auapi), i(0) }),
	s("augroup", { t("augroup "), i(1, "groupName"), i(0) }),
	s(
		"usercmd",
		{ t("usercmd("), i(1, '"CmdName"'), t({ '", function()', "" }), i(2, "code"), t({ "", "end)" }), i(0) }
	),

	s("function", {
		t("local "),
		i(1, "FunctionName"),
		t(" = function("),
		i(2, "args"),
		t(")"),
		t({ "", "end" }),
	}),

	-- Snippet for autocmd
	s("autocmd", {
		t("autocmd("),
		f(function(_, snip)
			local events = get_autocmd_events()
			return events
		end, {}),
		t(', { group = "'),
		i(1, "group"), -- Placeholder for group name
		t('", pattern = "'),
		i(2, "*"), -- Placeholder for pattern
		t('", callback = function()'),
		t({ "", "\t" }),
		i(3, "-- Function body"), -- Placeholder for function body
		t({ "", "end })" }),
		i(0), -- Final jump position
	}),

	-- Example for vim.fn.expand
	s("expand", {
		t("expand("),
		c(1, {
			t("'<cword>'"),
			t("'<cfile>'"),
			t("'<afile>'"),
			i(1), -- for manual input if necessary
		}),
		t(")"),
		i(0),
	}),

	-- Example for vim.api.nvim_buf_set_lines
	s("setlines", {
		t("setlines("),
		i(1, "bufnr"), -- Buffer number
		t(", "),
		i(2, "start"), -- Start line
		t(", "),
		i(3, "end"), -- End line
		t(", "),
		i(4, "{"), -- Content (list of lines)
		t("})"),
		i(0),
	}),
	-- Example for vim.api.nvim_get_current_buf
	s("getbuf", {
		t("getbuf("),
		t(")"),
		i(0),
	}),
	-- Example for vim.cmd()
	s("cmd", {
		t('cmd("'),
		i(1, "command"), -- Insert command
		t('")'),
		i(0),
	}),

	-- Example for vim.api.nvim_buf_get_name
	s("bufname", {
		t("bufname("),
		i(1, "bufnr"), -- Buffer number
		t(")"),
		i(0),
	}),

	-- Example for vim.api.nvim_set_keymap (map remap)
	s("keymap", {
		t("map("),
		i(1, "mode"), -- Mode (e.g., 'n', 'i')
		t(", "),
		i(2, "lhs"), -- Left-hand side (keybind)
		t(", "),
		i(3, "rhs"), -- Right-hand side (command)
		t(", "),
		i(4, "opts"), -- Options (optional)
		t(")"),
		i(0),
	}),

	-- Example for vim.api.nvim_set_keymap (noremap remap)
	s("noremap", {
		t("noremap("),
		i(1, "mode"), -- Mode (e.g., 'n', 'i')
		t(", "),
		i(2, "lhs"), -- Left-hand side (keybind)
		t(", "),
		i(3, "rhs"), -- Right-hand side (command)
		t(", "),
		i(4, "opts"), -- Options (optional)
		t(")"),
		i(0),
	}),

	-- Example for vim.api.nvim_get_option
	s("getopt", {
		t("getopt("),
		i(1, "option"), -- Option name
		t(")"),
		i(0),
	}),

	-- Example for vim.api.nvim_set_option
	s("setopt", {
		t("setopt("),
		i(1, "option"), -- Option name
		t(", "),
		i(2, "value"), -- Value to set
		t(")"),
		i(0),
	}),
	s("getbuf", {
		t("getbuf("),
		i(1, "bufnr"),
		t(")"),
		i(0),
	}),
	s("nvim_create_augroup", {
		t('vim.api.nvim_create_augroup("'),
		i(1, "name"),
		t('", { '),
		t("clear = true"),
		t({ " })", "" }),
		i(0),
	}),
})
-- [3]&~
-- ~& [ HTML ]
ls.add_snippets("html", {
	s("btfn", {
		t('<button onclick="'),
		i(1, "function()"), -- Insert function content here
		t('" '),
		c(2, { -- First choice node for additional attributes
			t('class="myClass" '),
			t('id="myId" '),
			t('style="color:whitesmoke;" '),
			t(""),
		}),
		t(" "),
		c(3, { -- Second choice node for additional attributes
			t('class="myClass" '),
			t('id="myId" '),
			t('style="color:rgba(0,0,0,0.9);" '),
			t(""),
		}),
		t(">"),
		i(4, "ClicClic"), -- Button text
		t("</button>"),
	}),
})
-- [4]&~
-- ~& [ EOF/Modeline ]
return M
-- vim:ft=lua syn=lua sw=2 sts=2 ts=4 fdm=marker et:
-- [3]&~
