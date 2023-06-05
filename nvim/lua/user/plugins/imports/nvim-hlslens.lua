-- Better highlight search
return {
    "kevinhwang91/nvim-hlslens",
    lazy = false,
    config = function()
        require("hlslens").setup({
            calm_down = {
                description = [[If calm_down is true, clear all lens and highlighting When the cursor is
                    out of the position range of the matched instance or any texts are changed]],
                default = true,
            }
        })
    end,
}
