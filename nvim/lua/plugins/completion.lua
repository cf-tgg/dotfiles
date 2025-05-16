-- ~& [ completion.lua ] [ Last Update: 2024-10-25 02:16 ]
local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"windwp/nvim-autopairs",
		"hrsh7th/vim-vsnip-integ",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local compare = require("cmp.config.compare")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local handlers = require("nvim-autopairs.completion.handlers")
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")
		-- put this to setup function and press <a-e> to use fast_wrap
		npairs.setup({
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%>%]%)%}%,]]=],
				end_key = "$",
				before_key = "h",
				after_key = "l",
				cursor_pos_before = true,
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				manual_position = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
			check_ts = true,
			ts_config = {
				lua = { "string" }, -- it will not add a pair on that treesitter node
				javascript = { "template_string" },
			},
		})
		local ts_conds = require("nvim-autopairs.ts-conds")
		npairs.add_rules({ -- press % => %% only while inside a comment or string
			Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
			Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
		})
		require("nvim-autopairs").setup({
			ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
		})
		-- Setup for command line completion
		local function setup_cmdline_cmp()
			-- ":" command-line mode setup
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ -- Complete paths if the command is related to file handling
						name = "path",
						completeopt = "longest,preview",
						option = {
							keyword_pattern = [[\k/\k\+]],
							comparators = {
								compare.scopes,
								compare.locality,
								compare.recently_used,
							},
						},
					},
					{ -- Fallback to command history completion
						name = "cmdline",
						option = {
							history = true,
							completeopt = "menu,menuone,popup,preview,longest",
						},
					},
				}),
			})
			-- "/" search mode setup
			cmp.setup.cmdline("/", {
				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-k>"] = function()
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump(1)
						else
							cmp.mapping.complete()
						end
					end,
					["<C-j>"] = function()
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							cmp.mapping.select_prev_item()
						end
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "history" },
					{ name = "buffer" },
					{ name = "path" },
					comparators = {
						compare.score,
						compare.locality,
						compare.scopes,
						compare.recently_used,
					},
				},
			})
		end
		vim.api.nvim_create_autocmd("CmdlineEnter", {
			pattern = { ":", "/", "?" },
			callback = function()
				setup_cmdline_cmp()
			end,
		})
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,preview,popup,longest,line" },
			mapping = {
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-k>"] = function()
					if luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump(1)
					else
						cmp.mapping.complete()
					end
				end,
				["<C-j>"] = function()
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						cmp.mapping.select_prev_item()
					end
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip", option = { show_autosnippets = true } },
				{ name = "omnifunc" },
				{ name = "path" },
			}, {
				{ -- Buffer completion priority
					name = "buffer",
					option = {
						keyword_pattern = [[\k\+]],
						get_bufnrs = function()
							local bufs = {}
							for _, win in ipairs(vim.api.nvim_list_wins()) do
								bufs[vim.api.nvim_win_get_buf(win)] = true
							end
							return vim.tbl_keys(bufs)
						end,
					},
				},
				{
					name = "path",
					option = {
						keyword_pattern = [[\k/\k\+]],
						comparators = {
							compare.scopes,
							compare.locality,
							compare.recently_used,
						},
					},
				},
			}),
			-- Prioritize LSP over buffer items
			sorting = {
				priority_weight = 2,
				comparators = {
					compare.offset,
					compare.exact,
					compare.score,
					compare.recently_used,
					compare.kind,
					compare.sort_text,
					compare.length,
					compare.order,
				},
			},
		})

  cmp.setup {
    mapping = {
      ['<C-g>'] = cmp.mapping(function(fallback)
        vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
      end)
    },
    experimental = {
      ghost_text = false -- this feature conflict with copilot.vim's preview.
    }
  }

		-- filetype specific completion
		cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
			sources = {
				{ name = "vim-dadbod-ui" },
				{ name = "omnifunc" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "nvim_lsp" },
				{ name = "snippets" },
				{ name = "path" },
				},
		})
	end,
}

return M
