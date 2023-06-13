-- Manager for LSP servers
return {
    "williamboman/mason.nvim",
    lazy = true,
    config = function()
        require("mason").setup({})
    end,
}
