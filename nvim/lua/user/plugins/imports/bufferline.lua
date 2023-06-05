-- Fancy bufferlines
return {
    "akinsho/bufferline.nvim",
    version = "v2.*",
    lazy = false,
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    config = function()
        require("bufferline").setup{
            options = {
                mode = "buffers",
                -- Shift over tabs when opening NvimTree
                offsets = {
                    {
                        filetype = "NvimTree",
                        text_align = "left",
                        separator = true,
                    },
                },
                numbers = "buffer_id",
                modified_icon = '',
                sort_by = 'tabs',
            },
        }
    end,
}
