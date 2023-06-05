 -- Easily wrap text in character pairs (e.g. {}, (), [])
return {
    "kylechui/nvim-surround",
    lazy = false,
    config = function()
        require("nvim-surround").setup{}
    end,
}
