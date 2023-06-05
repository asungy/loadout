-- Floating terminal window
return {
    "akinsho/toggleterm.nvim",
    lazy = false,
    config = function()
        require("toggleterm").setup {
            size = 20,
            open_mapping = [[<A-\>]],
            direction = "float",
            shade_terminals = true,
            shading_factor = 1,
            close_on_exit = true,
            float_opts = {
                border = "curved",
                winblend = 3,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        }
    end,
}
