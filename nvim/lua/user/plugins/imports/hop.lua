-- Motion jumping plugin
return {
    "phaazon/hop.nvim",
    lazy = false,
    config = function()
        require('hop').setup{}
    end,
}
