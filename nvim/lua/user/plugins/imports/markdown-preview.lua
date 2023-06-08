-- Markdown preview
return {
    "iamcco/markdown-preview.nvim",
    lazy = false,
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    cmd = {
        "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle"
    },
    event = "BufRead",
    build = "cd app && npm install",
}
