-- Vertical lines for indents
return {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    config = function()
        require('indent_blankline').setup{}
        vim.g.indent_blankline_show_trailing_blankline_indent = false
    end,
}
