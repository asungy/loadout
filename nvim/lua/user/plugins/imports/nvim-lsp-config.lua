-- Quickstart configs for NeoVim LSP
return {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
        local lspconfig = require("lspconfig")
        lspconfig.rust_analyzer.setup {}
        lspconfig.clangd.setup {}
    end,
}
