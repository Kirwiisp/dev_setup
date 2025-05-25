return {
    {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
        "saghen/blink.cmp"
    },
    config = function()
        local lspconfig = require("mason-lspconfig")
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        require("lspconfig").lua_ls.setup {capabilites = capabilities }
        lspconfig.setup()

        local opts = { buffer = bufnr, silent = true }

        local builtin = require("telescope.builtin") -- Now safe to call
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
        vim.keymap.set("n", "gr", builtin.lsp_references, opts)
        vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    end
},
}
