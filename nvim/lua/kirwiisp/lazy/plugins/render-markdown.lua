return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        config = function()
            local render_markdown = require("render-markdown")
            render_markdown.setup({
                    file_types = { 'markdown'},
                    render_modes = { 'n', 'c', 't'},
                    latex = { enabled = false},
                    html = {enabled = true},
                })
        end,
    },
}
