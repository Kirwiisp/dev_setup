-- General Neovim settings
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.softtabstop = -1
opt.backspace = { 'indent', 'eol', 'start' }
opt.autoindent = true
opt.mouse = 'a'
opt.linebreak = true
opt.scrolloff = 8
opt.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/undotree"
opt.swapfile = false
opt.colorcolumn = "80"

vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

