-- Keymaps hints
return {
    "linty-org/key-menu.nvim",
    lazy = false,
    config = function()
        -- Make key-menu pop up after these characters
        require("key-menu").set('n', '<leader>l', {desc='LSP Commands'})
    end,
}
