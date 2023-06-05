-- Completion plugin
return {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
        -- source for buffer words
        "hrsh7th/cmp-buffer",
        -- source for cmdline
        "hrsh7th/cmp-cmdline",
        -- source for LSP client
        "hrsh7th/cmp-nvim-lsp",
        -- source for paths
        "hrsh7th/cmp-path",
        -- source for luasnip
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        local has_words_before = function()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        -- Set up completions
        cmp.setup({
            -- Specify snippet engine
            snippet = {
                expand = function(args)
                    -- Use luasnip as snippet engine
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            -- Key mappings for completion
            mapping = {
                -- Scroll up on docs
                ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                -- Scroll down on docs
                ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                -- Open completion
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                -- Quit completion
                ["<C-e>"] = cmp.mapping.abort(),
                -- Select with Enter key
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                -- Super (forward) tab
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            -- When to enable completion
            enabled = function()
                -- Disable for prompts
                buftype = vim.api.nvim_buf_get_option(0, "buftype")
                if buftype == "prompt" then
                    return false
                end

                local context = require('cmp.config.context')
                -- keep command mode completion enabled
                if vim.api.nvim_get_mode().mode == "c" then
                    return true
                else
                    -- disable completion if in comments
                    return not context.in_treesitter_capture("comment")
                        and not context.in_syntax_group("Comment")
                end
            end,
            sources = cmp.config.sources({
                { name = "nvim_lsp"},
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            }),
            formatting = {
                fields = { 'abbr', 'kind', 'menu' },
                format = function(entry, vim_item)
                    -- The order of this table has to match the order of the 'sources'
                    vim_item.menu = ({
                        nvim_lsp = "",
                        luasnip = "",
                        buffer = "",
                        path = "",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            experimental = {
                ghost_text = false,
            },
        })

        -- Use buffer source for '/' (won't work with 'native_menu')
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {{ name = 'buffer' }}
        })

        -- Use cmdline and path source for ':' (won't work with 'native_menu')
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'cmdline' },
            })
        })
    end,
}
