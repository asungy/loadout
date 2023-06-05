local signs = {
    { name = "DiagnosticSignError", text = "", },
    { name = "DiagnosticSignWarn",  text = "", },
    { name = "DiagnosticSignHint",  text = "", },
    { name = "DiagnosticSignInfo",  text = "", },
}

-- Icons appear on number line
for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
    virtual_lines = false,
    virtual_text = false,
    signs = {
        active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
    },
}

vim.diagnostic.config(config)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})
