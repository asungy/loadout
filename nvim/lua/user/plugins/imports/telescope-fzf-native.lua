-- FZF sorter for Telescope
-- Requires: gcc/clang and make
--
-- If a C compiler and make are installed and there's still an issue, run `:Lazy sync`.
return {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = false,
    build = "make",
    dependencies = {"nvim-telescope/telescope.nvim"},
    config = function()
        require("telescope").load_extension("fzf")
    end,
}
