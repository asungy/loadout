-- Snippet engine
return {
    "L3MON4D3/LuaSnip",
    lazy = false,
    dependencies = {
        -- preconfigured snippets for different languages
        "rafamadriz/friendly-snippets",
    },
    config = function()
        -- Use VS-Code style snippets (from "rafamadriz/friendly-snippets")
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
