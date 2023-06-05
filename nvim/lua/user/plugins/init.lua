-- Autocommand that reloads neovim whenever keymaps.lua is written to
vim.cmd([[
    if !exists("plugins_autocmd_loaded")
        let plugins_autocmd_loaded = 1
        autocmd BufWritePost plugins.lua source <afile> | Lazy sync
    endif
]])

-- Automatically bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
    print("Cannot find lazy. Try restarting.")
    return
end

lazy.setup({{import = "user.plugins.imports"}})
