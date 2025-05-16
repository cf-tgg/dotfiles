return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- Debugger UI
		"rcarriga/nvim-dap-ui",

		-- Dependency manager
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Optional dependency for dap-ui
		"nvim-neotest/nvim-nio",

		"mxsdev/nvim-dap-vscode-js",
		{
			"microsoft/vscode-js-debug",
			version = "1.x",
			build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("dap-vscode-js").setup({
			debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		})

		dap.configurations.typescript = {
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach to Node",
				port = 9222,
				sourceMaps = true,
				protocol = "inspector",
				cwd = vim.fn.getcwd(),
				skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
				resolveSourceMapLocations = {
					"${workspaceFolder}/**",
					"!**/node_modules/**",
				},
			},
		}

		dap.configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file in new node process",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
		}

		dap.configurations.svelte = {
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach to Svelte",
				port = 9222,
				sourceMaps = true,
				protocol = "inspector",
				cwd = vim.fn.getcwd(),
				skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
				resolveSourceMapLocations = {
					"${workspaceFolder}/**",
					"!**/node_modules/**",
				},
			},
		}

		dap.configurations["pwa-chrome"] = {
			{
				type = "pwa-chrome",
				request = "launch",
				name = "Launch Chrome",
				url = "http://localhost:5173",
				webRoot = "${workspaceFolder}/src",
				sourceMaps = true,
				port = 9222,
				skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
			},
		}

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			automatic_setup = true,
			ensure_installed = {
				"javascript",
				"java",
				"bash",
				"python",
			},
			handlers = {
				python = function(config)
					config.adapters = {
						type = "executable",
						command = "/usr/bin/python3",
						args = { "-m", "debugpy.adapter" },
					}
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})

		-- Keymaps
		vim.keymap.set("n", "<F5>", dap.continue, { silent = true, desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { silent = true, desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { silent = true, desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { silent = true, desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { silent = true, desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { silent = true, desc = "Debug: Set Breakpoint" })

		-- Dap UI setup
		dapui.setup({
			icons = {
				expanded = "▾",
				collapsed = "▸",
				current_frame = "*",
			},
			controls = {
				enabled = true,
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end

		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		vim.keymap.set("n", "<F7>", dapui.toggle, { silent = true, desc = "Debug: See last session result" })
	end,
}
