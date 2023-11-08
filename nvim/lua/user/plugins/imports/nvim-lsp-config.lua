-- Quickstart configs for NeoVim LSP
return {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
        local lspconfig = require("lspconfig")
        lspconfig.rust_analyzer.setup {}
        lspconfig.clangd.setup {}
        lspconfig.tsserver.setup {}
        lspconfig.zls.setup{}
        -- typst LSP doesn't seem to really work.
        lspconfig.typst_lsp.setup {}
    end,
}
