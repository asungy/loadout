-- Scroll bar
return {
    "petertriho/nvim-scrollbar",
    config = function()
        require("scrollbar").setup()
        require("scrollbar.handlers.search").setup()
    end,
    dependencies = {"kevinhwang91/nvim-hlslens"},
}
