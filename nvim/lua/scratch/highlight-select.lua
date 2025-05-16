
-- local M = {}

-- -- Function to get all highlight groups of the current buffer
-- local function get_highlight_groups(bufnr)
--   local highlight_groups = {}
--   local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)

--   -- Parse through all the buffer lines to extract the highlight group information
--   for line_num, _ in ipairs(lines) do
--     local highlights = vim.fn.synstack(line_num + 1, 1) -- Get highlights at start of each line
--     if #highlights > 0 then
--       for _, id in ipairs(highlights) do
--         local hl_group = vim.fn.synIDattr(id, 'name')
--         if hl_group and not highlight_groups[hl_group] then
--           highlight_groups[hl_group] = vim.api.nvim_get_hl(0, id)
--         end
--       end
--     end
--   end
--   return highlight_groups
-- end

-- -- Function to add items to the quickfix list
-- local function add_to_quickfix(hl_groups)
--   local qf_list = {}
--   for name, hl_props in pairs(hl_groups) do
--     table.insert(qf_list, {
--       text = string.format("Component: %s, Highlight Group: %s, Colors: %s", name, vim.inspect(hl_props)),
--       lnum = 1,
--       col = 1,
--       buf = 0,
--     })
--   end
--   vim.fn.setqflist(qf_list, 'r')
--   vim.cmd('copen')
-- end

-- -- Main on_attach function
-- function M.on_attach(bufnr)
--   local hl_groups = get_highlight_groups(bufnr)
--   local group_names = vim.tbl_keys(hl_groups)

--   vim.ui.select(group_names, {
--     prompt = 'Select highlight group to modify:',
--     format_item = function(item)
--       local hl_info = hl_groups[item]
--       return string.format("Group: %s, fg: #%06x, bg: #%06x, sp: #%06x", item,
--         hl_info.foreground or 0, hl_info.background or 0, hl_info.special or 0)
--     end,
--   }, function(choice)
--     if choice then
--       local new_fg = vim.fn.input('Enter new fg (in hex, without #): ', '', 'custom')
--       local new_bg = vim.fn.input('Enter new bg (in hex, without #): ', '', 'custom')

--       -- Update highlight group with new colors
--       vim.api.nvim_set_hl(0, choice, { fg = tonumber(new_fg, 16), bg = tonumber(new_bg, 16) })

--       -- Re-add to quickfix list with new values
--       hl_groups[choice].foreground = tonumber(new_fg, 16)
--       hl_groups[choice].background = tonumber(new_bg, 16)
--       add_to_quickfix(hl_groups)
--     end
--   end)
-- end

-- -- Example (echoes the color of the syntax item under the cursor):
-- -- vim.cmd([[:echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")]])
-- -- Can also be used as a |method|:
-- -- vim.cmd([[:echo synID(line("."), col("."), 1)->synIDtrans()->synIDattr("fg")]])

-- return M
