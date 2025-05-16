-- ~& [ expressline.lua ] [ Last Update: 2024-10-24 09:05 ]
--                                      _ _
--   _____  ___ __  _ __ ___  ___ ___  | (_)_ __   ___
--  / _ \ \/ / '_ \| '__/ _ \/ __/ __| | | | '_ \ / _ \
-- |  __/>  <| |_) | | |  __/\__ \__ \ | | | | | |  __/
--  \___/_/\_\ .__/|_|  \___||___/___/ |_|_|_| |_|\___|
--           |_|
--                                            ~cf.[0]&~

-- ~& [ Express Line Module ] ~&~
local M = { "tjdevries/express_line.nvim", dependencies = { "nvim-tree/nvim-web-devicons" },
-- ~& [ el Config ]
	config = function()
		local ok, el = pcall(require, "el")
		if not ok then
			return
		end

		local builtin = require("el.builtin")
		local extensions = require("el.extensions")
		local subscribe = require("el.subscribe")
		local sections = require("el.sections")

		--[[ custom functions because I'm too noob to understand how to use the built-in ones ]]
		-- Apply highlight groups
		local hi = function(segment, hl_group)
			return function()
				local value = type(segment) == "function" and segment() or segment
				if value and value ~= "" then
					return string.format("%%#%s#%s%%*", hl_group, value)
				end
				return ""
			end
		end

		vim.api.nvim_set_hl(0, "ArtixDevIcon", { fg = "#41b4d7", ctermfg = 38 }) -- ""

		-- reg_recording as -> [@q]
		local el_rec = function()
			local recording = vim.fn.reg_recording()
			if recording ~= "" then
				local segment = hi("[@", "Delimiter")() .. hi(recording, "Function")() .. hi("]", "Delimiter")()
				return segment
			else
				return "    "
			end
		end

		local el_vblock = function()
			local start = vim.fn.getpos("v")
			local now = vim.fn.getpos(".")
			local lines = math.abs(now[2] - start[2]) + 1
			local columns = math.abs(now[3] - start[3]) + 1
			if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "\22" then
				local result = string.format("[%dx%d]", lines, columns)
				return hi(result, "Function")()
			else
				return "   "
			end
		end

		local el_search_count = function()
			vim.cmd([[ function! LastSearchCount() abort
			let result = searchcount(#{recompute: 1})
				if empty(@/) || empty(result) || result.total == 0
						return "  "
				endif
				if result.incomplete ==# 1
						return printf(' /%s [?/??]', @/)
				elseif result.incomplete ==# 2
						if result.total > result.maxcount && result.current > result.maxcount
					return printf(' /%s [>%d/>%d]', @/, result.current, result.total)
						elseif result.total > result.maxcount
					return printf(' /%s [%d/>%d]', @/, result.current, result.total)
						endif
				endif
				return printf(' /%s [%d/%d]', @/, result.current, result.total)
			endfunction ]])

			if vim.v.hlsearch == 1 and vim.fn.getreg("/") ~= "" then
				local search_count = vim.fn.LastSearchCount()
				if search_count ~= "" then
					return hi(search_count, "Function")()
				end
			end
			return ""
		end
--  [3]&~
-- ~& [ el Setup ]
		el.setup({
          generator = function()
			local segments = {}
			local segment = function(cmd)
				return table.insert(segments, cmd)
			end
			segment(extensions.mode)
			segment(hi("[", "Delimiter"))
			segment(hi("", "ArtixDevIcon"))
			segment(hi("]", "Delimiter"))
			segment(hi("[", "Delimiter"))
			segment(hi(builtin.bufnr, "MoreMsg"))
			segment(hi("]", "Delimiter"))
			segment(subscribe.buf_autocmd("el-git-changes", "BufWritePost", function(win, buf)
				local changes = extensions.git_changes(win, buf)
				return changes and hi(changes, "DiffChange")() or ""
			end))
			segment(sections.split)
			segment(builtin.shortened_file)
			segment(" ")
			segment(extensions.file_icon)
			segment(sections.split)
			segment(el_rec)
			segment(el_vblock)
			segment(el_search_count)
			segment(hi(builtin.modified, "NvimAssignment"))
			segment(hi(builtin.readonly, "ErrorMsg"))
			segment(hi(builtin.filetype, "Directory"))
			segment(hi("[", "Delimiter"))
			segment(hi(builtin.line_with_width(3), "NvimOperator"))
			segment(hi(":", "Delimiter"))
			segment(hi(builtin.column_with_width(2), "NvimOperator"))
			segment(hi("]", "Delimiter"))
			return segments
			end,
		})
	end,
}
-- [4]&~
return M
-- vim:ft=lua:sw=2:sts=4:ts=2:et:
-- [3]&~
