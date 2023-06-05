-- Manager for LSP servers
return {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
        require("mason").setup({})
    end,
}
