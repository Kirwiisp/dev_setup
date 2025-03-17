" Default nvim config
set number
set tabstop=4
set shiftwidth=4 
set expandtab
set softtabstop=-1
set backspace=indent,eol,start
set autoindent
set mouse=a
set relativenumber
set hlsearch
set linebreak

" Keymap config
let mapleader = ","
vnoremap <leader>v "*y
nnoremap <leader>sf <cmd>Telescope find_files<cr>
nnoremap <leader>sh <cmd>Telescope find_files  hidden=true  <cr>
nnoremap <leader>sg <cmd>Telescope live_grep hidden=true <cr>
nnoremap <leader>sb <cmd>Telescope buffers<cr>

" Plug Configuration
call plug#begin('~/.config/nvim/pluggins/plugged')
Plug 'folke/tokyonight.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'williamboman/mason.nvim'
Plug 'neovim/nvim-lspconfig'            " LSP configurations
Plug 'williamboman/mason-lspconfig.nvim' " Mason integration with LSPconfig
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2', 'as': 'harpoon' }
call plug#end()

colorscheme tokyonight-night
hi Normal guibg=NONE ctermbg=NONE

" Lua modules configurations
lua << EOF

require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
        end,
}

local lspconfig = require("lspconfig")

-- Harpoon configuration

local harpoon = require ("harpoon")

require("harpoon").setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<D-y>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<D-u>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<D-i>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<D-o>", function() harpoon:list():select(4) end)

EOF
