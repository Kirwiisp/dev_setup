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
set linebreak
set scrolloff=8
set undofile
set undodir=$HOME/.config/nvim/undotree
set noswapfile

" Keymap config
let mapleader = " "
vnoremap <leader>v "*y
nnoremap <leader>sf <cmd>Telescope find_files<cr>
nnoremap <leader>sh <cmd>Telescope find_files  hidden=true  <cr>
nnoremap <leader>sg <cmd>Telescope live_grep hidden=true <cr>
nnoremap <leader>sb <cmd>Telescope buffers<cr>
nnoremap <leader>u <cmd>UndotreeToggle<cr>
nnoremap <leader>k <cmd>lua vim.diagnostic.open_float()<CR>

" Plug Configuration
call plug#begin('~/.config/nvim/pluggins/plugged')
Plug 'folke/tokyonight.nvim' " theme
Plug 'rebelot/kanagawa.nvim' " theme
Plug 'MeanderingProgrammer/render-markdown.nvim' 
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' } " Fuzzy finder
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'williamboman/mason.nvim'          " LSP manager
Plug 'neovim/nvim-lspconfig'            " LSP configurations
Plug 'williamboman/mason-lspconfig.nvim' " Mason integration with LSPconfig
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2', 'as': 'harpoon' } " Quick file toggle
Plug 'mbbill/undotree'                  " Undotree explorer
call plug#end()

colorscheme tokyonight-night
"colorscheme kanagawa-wave


" Lua modules configurations
lua << EOF
require('render-markdown').setup({
    file_types = { 'markdown'},
    render_modes = { 'n', 'c', 't'},
})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {  "python", "go", "ruby","lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  ignore_install = { "yaml" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}

require("mason").setup()
require("mason-lspconfig").setup()


local function attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  -- etc.
end


require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            on_attach = attach
        }
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
