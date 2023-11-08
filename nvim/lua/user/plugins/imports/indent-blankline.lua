-- Vertical lines for indents
return {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    main = "ibl",
    config = function()
        vim.g.indent_blankline_show_trailing_blankline_indent = false
    end,
}
