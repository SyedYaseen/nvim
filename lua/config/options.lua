-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- draw borders between splits
-- make nvim draw borders between windows
local o = vim.opt

-- enable soft wrap
o.wrap = true        -- wrap long lines
o.linebreak = true   -- wrap only at word boundaries
o.breakindent = true -- preserve indentation on wrapped lines
o.showbreak = "  "   -- prefix for wrapped lines (adjust as you like)

-- optional: make wrapped lines indent visibly a bit
-- o.shiftwidth = 2
-- o.tabstop = 2

