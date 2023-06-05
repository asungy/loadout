-- Fancy statuslines
return {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    config = function()
        require("lualine").setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        icons_enabled = true,
                        icon = '',
                        padding = 2,
                    }
                },
                lualine_b = {
                    {
                        'branch',
                        icons_enabled = true,
                        icon = '',
                        padding = 2,
                    },
                    'diff',
                    'diagnostics',
                },
                lualine_c = {
                    {
                        'filename',
                        file_status = true,
                        path = 3, -- 3: absolute path
                        symbols = {
                            modified = '',
                            readonly = '',
                            unnamed  = '',
                            newfile  = '',
                        },
                        padding = 2,
                    }
                },
                lualine_x = {
                    {
                        'encoding',
                        icons_enabled = true,
                        icon = '',
                        padding = 2,
                    },
                    {
                        'fileformat',
                        padding = 2,
                    },
                    {
                        'filetype',
                        padding = 4,
                    },
                },
                lualine_y = {
                    {
                        'progress',
                        icons_enabled = true,
                        icon = '',
                        padding = 4,
                    },
                },
                lualine_z = {
                    {
                        'location',
                        icons_enabled = true,
                        icon = '',
                        padding = 3,
                    }
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {"nvim-tree", "toggleterm"},
        }
    end,
}
