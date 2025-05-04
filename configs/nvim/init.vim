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
set colorcolumn=80

" Keymap config
" Leader to Spacebar
let mapleader = " "

" Allow copy to clipboard with Leader+v
vnoremap <leader>v "*y

" Keep cursor in middle of screen while moving
nnoremap <C-d> <C-d>zz 
nnoremap <C-u> <C-u>zz 

" Keep cursod in place while appending next line
nnoremap J mzJ`z

" Move between panes
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" Split panes
nnoremap <M-s> <C-w>s
nnoremap <M-v> <C-w>v

" Equalize all panes
nnoremap <M-=> <C-w>=

" Move selection
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" Telescope shortcuts 
nnoremap <leader>sf <cmd>Telescope find_files<cr>
nnoremap <leader>sh <cmd>Telescope find_files  hidden=true  <cr>
nnoremap <leader>sg <cmd>Telescope live_grep hidden=true <cr>
nnoremap <leader>sb <cmd>Telescope buffers<cr>

" Open undoTree
nnoremap <leader>u <cmd>UndotreeToggle<cr>

" Open float for warning or error
nnoremap <leader>k <cmd>lua vim.diagnostic.open_float()<CR>

" Plug Configuration
call plug#begin('~/.config/nvim/pluggins/plugged')
Plug 'folke/tokyonight.nvim' " theme
Plug 'Mofiqul/vscode.nvim' " theme
Plug 'rebelot/kanagawa.nvim' " theme
Plug 'MeanderingProgrammer/render-markdown.nvim' 
Plug 'nvim-telescope/telescope.nvim',  " Fuzzy finder
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-lua/plenary.nvim'
Plug 'williamboman/mason.nvim'          " LSP manager
Plug 'neovim/nvim-lspconfig'            " LSP configurations
Plug 'williamboman/mason-lspconfig.nvim' " Mason integration with LSPconfig
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2', 'as': 'harpoon' } " Quick file toggle
Plug 'mbbill/undotree'                  " Undotree explorer
call plug#end()

colorscheme tokyonight-night
"colorscheme kanagawa-wave
" colorscheme vscode
hi Normal guibg=NONE ctermbg=NONE

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

-- Treesitter Context
require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  multiwindow = false, -- Enable multiwindow support.
  max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 2, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

-- LSP SECTION
require("mason").setup()
require("mason-lspconfig").setup()

-- Lsp shorcut (def / ref / rename)
local function attach(client, bufnr)
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", require('telescope.builtin').lsp_definitions, opts)
  vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references, opts)
  vim.keymap.set("n", "gi", require('telescope.builtin').lsp_implementations, opts)
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
        require'lspconfig'.protols.setup{}
        end
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
