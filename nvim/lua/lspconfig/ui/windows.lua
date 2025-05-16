-- ~& [ windows.lua ] [ Last Update: 2024-10-21 23:10 ]

local win_float = {}

win_float.default_options = {
  border = "rounded",
  width = 0.7,
  height = 0.4,
  relative = "editor",
  anchor = "SW",
  style = "minimal",
  borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
  winblend = 15,
}

function win_float.default_opts()
  return {}
end

function win_float.percentage_range_window() end

return win_float
