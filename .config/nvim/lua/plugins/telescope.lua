return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
            "nvim-telescope/telescope-ui-select.nvim",
            {
                -- only load when make is installed
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true
                }
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown{}
                }
            }
        },
        config = function(_, opts)
            require('telescope').setup(opts)

            -- Enable telescope fzf native, if installed
            require('telescope').load_extension("ui-select")
            require('telescope').load_extension("fzf")
        end
    },
}
