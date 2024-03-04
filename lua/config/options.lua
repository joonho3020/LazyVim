-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- GUI related things
vim.opt.mouse = "a" -- enable mouse : necessary evil
vim.opt.listchars:append({ -- various markers
  tab = ":>·",
  trail = "~",
})
vim.opt.colorcolumn = "79" -- line length marker

-- Add terminal debugger
vim.cmd("packadd termdebug")
vim.cmd([[
let g:termdebug_wide=1
let g:termdebug_leftsource=1
let g:termdebug_focussource=1
let g:termdebug_disable_toolbar=1
hi debugPC term=reverse ctermbg=8 guibg=darkblue
" let g:termdebgger="<path to riscv64-unknown-linux-gnu-gdb>"
]])

-- Disable LazyVim auto format
vim.g.autoformat = false
