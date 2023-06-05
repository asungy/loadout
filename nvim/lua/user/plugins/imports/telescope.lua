-- Fuzzy finder
return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
        require("telescope").setup {
            extensions = {
                fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",        -- options: "ignore_case", "respect_case", "smart_case"
                }
            },
            pickers = {
                buffers = {
                    show_all_buffers = true,
                    sort_lastused = true,
                    mappings = {
                        i = {
                            ["<C-d>"] = "delete_buffer",
                        }
                    },
                }
            }
        }
    end,
}
