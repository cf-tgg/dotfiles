-- ~& [ c.lua ] [ Last Update: 2024-11-14 19:46 ]

vim.opt_local.shiftwidth = 2
vim.opt_local.cindent = true
vim.opt_local.expandtab = true
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.smartindent = true
vim.opt_local.autoindent = true
vim.opt_local.textwidth = 120
vim.opt_local.formatoptions:append("r") -- Continue comments with new line
vim.opt_local.formatoptions:remove("o") -- Do not insert comments on `o` command
vim.opt_local.comments = "s1:/*,mb:*,ex:*/" -- Define C-style multiline comment structure
vim.opt_local.commentstring = "/* %s */"
vim.opt_local.foldmethod = "marker"
vim.opt_local.foldmarker = "{/*[,]*/}"
vim.opt_local.foldlevel = 0
vim.opt_local.foldnestmax = 3
vim.opt_local.foldminlines = 2

vim.opt_local.syntax = "c"
vim.opt_local.smartcase = true
vim.opt_local.ignorecase = true
vim.opt_local.backspace = { "indent", "eol", "start" }
vim.opt_local.breakindent = true
vim.opt_local.cursorline = true

-- These mappings yank the visually selected text and searches for it in C files.
vim.cmd([[vnoremap _c y:exe "grep /" .. escape(@", '\\/') .. "/ *.c *.h"<CR>]])
vim.api.nvim_create_user_command("Cgrep", function()
  vim.keymap.set({"v", "n"}, "<leader>c", function()
    local keywords = {}
    local keyword
    if vim.fn.mode() == "n" then
      keyword = vim.fn.expand("<cword>")
    elseif vim.fn.mode() == "v" then
      vim.cmd("normal! gv\"vy")
      keyword = vim.fn.getreg("v")
    end
    if keyword:match("%s") then
      -- Split multi-word selection into individual words
      for word in keyword:gmatch("%S+") do
        table.insert(keywords, word)
      end
    else
      table.insert(keywords, keyword)
    end
    for _, word in ipairs(keywords) do
      vim.cmd("tabnew")
      local cmd = 'grep /' .. vim.fn.escape(word, '\\/') .. '/ *.c *.h'
      vim.cmd("exe", cmd)
    end
  end, { noremap = true, silent = true })
end, { nargs = 0, range = true })
