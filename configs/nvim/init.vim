set number
set tabstop=4
set shiftwidth=4
set autoindent
set mouse=a
set number
set relativenumber
set hlsearch
set linebreak
let mapleader = ","
nnoremap <leader>sf <cmd>Telescope find_files<cr>
nnoremap <leader>sg <cmd>Telescope live_grep<cr>
nnoremap <leader>sb <cmd>Telescope buffers<cr>

call plug#begin('~/.config/nvim/pluggins/plugged')
Plug 'folke/tokyonight.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'williamboman/mason.nvim'
Plug 'neovim/nvim-lspconfig'            " LSP configurations
Plug 'williamboman/mason-lspconfig.nvim' " Mason integration with LSPconfig
call plug#end()
colorscheme tokyonight-night

lua << EOF
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {  "pyright"  },  -- Ensure rust-analyzer gopls and pyright are installed
})

local lspconfig = require("lspconfig")

-- Python LSP
lspconfig.pyright.setup({
  on_attach = function(client, bufnr)
    print("Python LSP attached!")
  end,
})


EOF



