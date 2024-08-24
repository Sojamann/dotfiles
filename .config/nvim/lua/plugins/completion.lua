return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            'L3MON4D3/LuaSnip', -- configured in luasnip.lua
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'zbirenbaum/copilot-cmp',
            'onsails/lspkind.nvim'
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require('lspkind')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = {
                    { name = "copilot", group_index = 2 },
                    { name = "nvim_lua" },
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "luasnip" },
                    { name = "buffer", keyword_length = 5 },
                },
                formatting = {
                    format = lspkind.cmp_format({
                      mode = "symbol",
                      max_width = 50,
                      symbol_map = { Copilot = "" }
                    })
                }
            })
        end,
    },
    {
        'zbirenbaum/copilot-cmp',
        config = function()
            require("copilot_cmp").setup({
                fix_pairs = true,
            })
        end
    }
}
