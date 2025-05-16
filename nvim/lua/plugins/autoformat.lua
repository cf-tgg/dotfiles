-- ~& [ autoformat.lua ] [ Last Update: 2024-10-20 17:05 ]
--              _         __                            _
--   __ _ _   _| |_ ___  / _| ___  _ __ _ __ ___   __ _| |_
--  / _` | | | | __/ _ \| |_ / _ \| '__| '_ ` _ \ / _` | __|
-- | (_| | |_| | || (_) |  _| (_) | |  | | | | | | (_| | |_
--  \__,_|\__,_|\__\___/|_|  \___/|_|  |_| |_| |_|\__,_|\__|
--
--                                                ~cf.[0]&~

-- ~& [ Lsp Autoformatting ] ~&~
M = {
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Switch for controlling whether you want autoformatting.
			--  Use :KickstartFormatToggle to toggle autoformatting on or off
			local format_is_enabled = true
			vim.api.nvim_create_user_command("FmtToggle", function()
				format_is_enabled = not format_is_enabled
				print("Setting autoformatting to: " .. tostring(format_is_enabled))
			end, {})
			-- Create an augroup that is used for managing our formatting autocmds.
			--      We need one augroup per client to make sure that multiple clients
			--      can attach to the same buffer without interfering with each other.
			local _augroups = {}
			local get_augroup = function(client)
				if not _augroups[client.id] then
					local group_name = "cf-auto-format" .. client.name
					local id = vim.api.nvim_create_augroup(group_name, { clear = true })
					_augroups[client.id] = id
				end

				return _augroups[client.id]
			end
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("cf-lsp-attach-format", { clear = true }),
				-- This is where we attach the autoformatting for reasonable clients
				callback = function(args)
					local client_id = args.data.client_id
					local client = vim.lsp.get_client_by_id(client_id)
					local bufnr = args.buf
					-- Only attach to clients that support document formatting
					if not client.server_capabilities.documentFormattingProvider then
						return
					end
					-- Create an autocmd that will run *before* we save the buffer.
					--  Run the formatting command for the LSP that has just attached.
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = get_augroup(client),
						buffer = bufnr,
						callback = function()
							if not format_is_enabled then
								return
							end
							vim.lsp.buf.format({
								async = false,
								filter = function(c)
									return c.id == client.id
								end,
							})
						end,
					})
				end,
			})
		end,
	},
	-- ~& [ Autoformatting ]
	{ -- Autoformat
		"stevearc/conform.nvim",
		lazy = true,
		keys = {
			{
				"<leader><leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "n",
				desc = "[F]ormat buffer",
			},
			{
				"<leader>taf",
				function()
					require("conform").format({ async = false, lsp_fallback = false })
					vim.g.disable_autoformat = not vim.g.disable_autoformat
					print("Global autoformatting: " .. (vim.g.disable_autoformat and "Disabled" or "Enabled"))
				end,
				desc = "[T]oggle global [a]uto[f]ormatting",
			},
			{
				"<leader>tbf",
				function()
					require("conform").format({ async = false, lsp_fallback = false })
					vim.b.disable_autoformat = not vim.b.disable_autoformat
					print("Buffer autoformatting: " .. (vim.b.disable_autoformat and "Disabled" or "Enabled"))
				end,
				desc = "[T]oggle [b]uffer auto[f]ormatting",
			},
		},
		opts = {
			notify_on_error = true,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				-- You can use a sub-list to tell conform to run *until* a formatter is found.
				-- javascript = { { "prettierd", "prettier" } },
			},
		},
	},
}
-- [3]&~
-- ~& [ Modeline ]
return M
-- vim: ft=lua sw=2 sts=2 ts=4 et:
-- [2]&~
