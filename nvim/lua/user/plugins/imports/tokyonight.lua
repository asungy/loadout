-- Tokyo night color scheme.
return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- Set as default color scheme
        vim.cmd([[colorscheme tokyonight]])
    end,
}
