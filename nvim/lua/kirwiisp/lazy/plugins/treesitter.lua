return{
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup({
                  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                  ensure_installed = {  "python", "go", "ruby",  "markdown", "markdown_inline" },

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

                            })
        end
    }
}
