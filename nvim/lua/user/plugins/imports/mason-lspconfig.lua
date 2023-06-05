-- Extension for Mason to easily integrate lspconfig
return {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {"neovim/nvim-lspconfig"},
    config = function()
        local mason_lspconfig = require("mason-lspconfig")

        mason_lspconfig.setup()
        mason_lspconfig.setup_handlers({
            function (server_name)
                require("lspconfig")[server_name].setup {}
            end,
        })
    end,
}
