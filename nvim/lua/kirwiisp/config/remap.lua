vim.g.mapleader = " "
-- vim.keymap.set("<mode>","<leader><key>", <cmd>)

-- Allow copy to clipboard
vim.keymap.set("v","<leader>v", '"*y')

-- Keep cursor in middle of the screen while moving
vim.keymap.set("n", "<C-d>", "<C-d>zz" )
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in place while appending next line
vim.keymap.set("n", "J", "mzK`z" )

-- Move accross quicklist
vim.keymap.set("n", "<M-J>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-K>", "<cmd>cprev<CR>")
-- Pane navigation
vim.keymap.set("n", "<M-h>", "<C-w>h")
vim.keymap.set("n", "<M-j>", "<C-w>j")
vim.keymap.set("n", "<M-k>", "<C-w>k")
vim.keymap.set("n", "<M-l>", "<C-w>l")

-- Split panes
vim.keymap.set("n", "<M-s>", "<C-w>s")
vim.keymap.set("n", "<M-v>", "<C-w>v")
vim.keymap.set("n", "<M-=>", "<C-w>=")

-- Move visual selection
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- LSP diagnostic float
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float)

-- Undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")

-- Doge doc
vim.keymap.set("n", "<leader>d", "<Plug>(doge-generate)")
