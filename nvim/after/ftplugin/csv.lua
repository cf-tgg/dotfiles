-- on-load formatting of csv documents :
--    comma-space-elements
--    double-commas empty columns
--    trimming trailing whitespaces
vim.cmd(":%s/*//g| :%s/, /, /g | :%s/, ,/,,/g |:%s/ $//")
