-- ~& [ lsp.lua ] [ Last Update: 2024-11-21 23:04 ]
--      _
--     | |    ___ _ __
--     | |   / __| '_ \
--     | |___\__ \ |_) |
--     |_____|___/ .__/
--               |_|
--                  ~cf.[0]&~

-- ~& [ Lsp Plugins Configuration ] ~&~
local M = {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"onsails/lspkind.nvim",
		"j-hui/fidget.nvim",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
		{ "folke/neodev.nvim", opts = {} },
		{
			"ray-x/go.nvim",
			dependencies = {
				"ray-x/guihua.lua",
				"neovim/nvim-lspconfig",
				"nvim-treesitter/nvim-treesitter",
			},
			config = function()
				require("go").setup()
			end,
			event = { "CmdlineEnter" },
			ft = { "go", "gomod" },
			build = ':lua require("go.install").update_all_sync()',
		},
	},
	-- [3]&~
	-- ~& [ kickstart.nvim keymaps and autocmds ]
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("KK", vim.lsp.buf.hover, "Hover Documentation")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				map("[d", vim.diagnostic.goto_prev, "Go to previous [D]iagnostic message")
				map("]d", vim.diagnostic.goto_next, "Go to next [D]iagnostic message")
				map("<leader>e", vim.diagnostic.open_float, "Show diagnostic [E]rror messages")
				map("<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = true })
					vim.opt_local.updatetime = 500
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({
								group = "kickstart-lsp-highlight",
								buffer = event2.buf,
							})
						end,
					})
				end
				if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					map("<leader>ih", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end, "Toggle [I]nlay [H]ints")
				end
			end,
		})
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = { disable = { "missing-fields", "virtual_text" } },
					},
				},
			},
			clangd = {
				cmd = {
					"clangd",
					"--offset-encoding=utf-16",
				},
			},
		}
		-- [3]&~
		-- ~& [ Mason Lsp Auto Defaults Configuration ]
		require("mason").setup()
		local ensure_installed = vim.tbl_keys(servers or {})
		local function disable_telemetry(config) -- for all servers that support it and enables it by default
			if config.settings and config.settings.telemetry then
				config.settings.telemetry.enable = false
			end
		end
		vim.list_extend(ensure_installed, {})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name]
						or {
							require("lspconfig").lua_ls.setup({
								settings = {
									Lua = {
										runtime = {
											version = "LuaJIT",
											path = vim.split(package.path, ";"),
										},
										diagnostics = {
											globals = { "vim" },
										},
										workspace = {
											library = {
												[vim.fn.expand("$VIMRUNTIME/lua")] = true, -- Include Neovim's Lua library
												[vim.fn.expand("$VIMRUNTIME/lua/vim")] = true, -- Include Neovim's 'vim' Lua library
											},
											maxPreload = 1000, -- Limit the number of files to preload
											preloadFileSize = 1000, -- Limit the size of files to preload
											ignoreDir = {
												"/usr/share", -- Ignore the /usr/share directory if it's causing issues
											},
										},
										telemetry = {
											enable = false, -- Disable telemetry for privacy
										},
									},
								},
							}),
						}
					-- Disable telemetry if supported by the server
					disable_telemetry(server)
					-- Handles overriding only values explicitly passed by the server configuration above.
					server.capabilities = vim.tbl_deep_extend(
						"force",
						{ telemetry = { enable = false } },
						capabilities,
						server.capabilities or {}
					)
					require("lspconfig")[server_name].setup(server)
					disable_telemetry(server)
				end,
			},
		})
		-- [3]&~
		-- ~& [ lspkind pretty icons ]
		local lspkind = require("lspkind")
		require("cmp").setup({
			---@diagnostic disable-next-line: missing-fields
			formatting = {
				format = lspkind.cmp_format({
					mode = { "symbol", "text" },
					maxwidth = 50,
					ellipsis_char = "[...]",
					menu = {
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						omnifunc = "[Omnifunc]",
						buffer = "[Buffer]",
						path = "[Path]",
						dbui = "[DB]",
					},
					before = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							omnifunc = "[Omnifunc]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
							dbui = "[DB]",
						})[entry.source.name]
						return vim_item
					end,
				}),
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "omnifunc" },
				{ name = "buffer" },
				{ name = "path" },
			},
		})
	end,
}

-- ~& [ Return Module ]
return M
-- vim: ft=lua ts=2 sts=2 sw=2 et:
-- [3]&~
