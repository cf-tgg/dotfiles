M = {}

-- vim.keymap.set("n", "<F5>", function()
-- 	require("dap").continue()
-- end, { desc = "[F5] Continue" })
-- vim.keymap.set("n", "<F10>", function()
-- 	require("dap").step_over()
-- end, { desc = "[F10] Step Over" })
-- vim.keymap.set("n", "<F11>", function()
-- 	require("dap").step_into()
-- end, { desc = "[F11] Step Into" })
-- vim.keymap.set("n", "<F12>", function()
-- 	require("dap").step_out()
-- end, { desc = "[F12] Step Out" })
-- vim.keymap.set("n", "<Leader>b", function()
-- 	require("dap").toggle_breakpoint()
-- end, { desc = "Toggle [b]reakpoint" })
-- vim.keymap.set("n", "<Leader>B", function()
-- 	require("dap").set_breakpoint()
-- end, { desc = "Set [B]reakpoint" })

-- vim.keymap.set("n", "<Leader>lp", function()
-- 	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
-- end, { desc = "Set log [p]oint" })

-- vim.keymap.set("n", "<Leader>dr", function()
-- 	require("dap").repl.open()
-- end, { desc = "Open [r]epl" })
-- vim.keymap.set("n", "<Leader>dl", function()
-- 	require("dap").run_last()
-- end, { desc = "Run [l]ast" })

-- vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
-- 	require("dap.ui.widgets").hover()
-- end, { desc = "Show [h]over" })

-- vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
-- 	require("dap.ui.widgets").preview()
-- end, { desc = "Show [p]review" })

-- vim.keymap.set("n", "<Leader>df", function()
-- 	local widgets = require("dap.ui.widgets")
-- 	widgets.centered_float(widgets.frames)
-- end, { desc = "Show [f]rames" })

-- vim.keymap.set("n", "<Leader>ds", function()
-- 	local widgets = require("dap.ui.widgets")
-- 	widgets.centered_float(widgets.scopes)
-- end, { desc = "Show [s]copes" })

return M
