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
                },
                live_grep = {
                    additional_args = {
                        "--hidden",
                    }
                }
            },
            extensions = {
                -- ["ui-select"] = {
                --     require("telescope.themes").get_dropdown {}
                -- }
            }
        },
        config = function(_, opts)
            require('telescope').setup(opts)

            -- Enable telescope fzf native, if installed
            require('telescope').load_extension("ui-select")
            require('telescope').load_extension("fzf")

            local t_builtin = require("telescope.builtin")

            vim.keymap.set('n', '<leader>?', t_builtin.oldfiles, { desc = '[?] Find recently opened files' })
            vim.keymap.set('n', '<leader><space>', t_builtin.buffers, { desc = '[ ] Find existing buffers' })
            vim.keymap.set('n', '<leader>/', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                t_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>sf', t_builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sh', t_builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sw', t_builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', t_builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', t_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', t_builtin.resume, { desc = '[S]earch [R]esume' })

            vim.keymap.set('n', '<leader>sm', t_builtin.man_pages, { desc = '[S]earch [M]an Pages' })

            -- NOTE: more keymaps can be found in lsp.lua
        end
    },
}
