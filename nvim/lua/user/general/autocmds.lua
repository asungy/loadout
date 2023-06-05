-- Update buffer if changed outside of neovim session
vim.cmd[[
    autocmd FocusGained,BufEnter * :checktime
]]

-- Turn off line numbers in terminal
vim.cmd[[
    autocmd TermOpen * setlocal nonumber norelativenumber
]]

-- Set tab spacing for Dart files.
vim.cmd[[
    autocmd FileType dart setlocal tabstop=2 shiftwidth=2 expandtab
]]

-- Set tab spacing for TypeScript
vim.cmd[[
    autocmd FileType typescript setlocal tabstop=2 shiftwidth=2 expandtab
]]
vim.cmd[[
    autocmd FileType typescriptreact setlocal tabstop=2 shiftwidth=2 expandtab
]]

-- Set tab spacing for JavaScript
vim.cmd[[
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab
]]
vim.cmd[[
    autocmd FileType javascriptreact setlocal tabstop=2 shiftwidth=2 expandtab
]]

-- Set tab spacing for CSS
vim.cmd[[
    autocmd FileType css setlocal tabstop=2 shiftwidth=2 expandtab
]]

-- Set tab spacing for HTML
vim.cmd[[
    autocmd FileType html setlocal tabstop=2 shiftwidth=2 expandtab
]]

-- Set tab spacing for Terraform
vim.cmd[[
    autocmd FileType terraform setlocal tabstop=2 shiftwidth=2 expandtab
]]

-- Set tab spacing for Markdown files.
vim.cmd[[
    autocmd FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab
]]
