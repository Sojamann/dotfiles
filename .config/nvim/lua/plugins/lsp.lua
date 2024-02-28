return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            -- ensures, that all servers mentioned in the config of
            -- 'neovim/nvim-lspconfig' are automaically installed
            automatic_installation = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        -- Make sure that nvim.lazy knows that these must be loaded first.
        -- These here are just referenced by name which expects that these
        -- plugins are setup somewhere else!
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require("lspconfig")

            -- ==================================
            --            General Config
            -- ==================================

            -- see: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
            local ls_opt = { capabilities = capabilities }
            lspconfig.clangd.setup(ls_opt)
            lspconfig.gopls.setup(ls_opt)
            lspconfig.zls.setup(ls_opt)
            lspconfig.lua_ls.setup(ls_opt)

            -- only enabled when npm is installed as this is a heavy
            -- dependency and these language servers are nice but not
            -- super important
            if vim.fn.executable('npm') == 1 then
                lspconfig.pyright.setup(ls_opt)
                lspconfig.bashls.setup(ls_opt)
            end


            -- ==================================
            --            Keymaps
            -- ==================================

            -- Formatting
            vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

                    -- formatting
                    vim.keymap.set('n', '<leader>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)

                    -- workspace
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)

                    -- vim.keymap.set('n', 'gd', t_builtin.lsp_definitions, { desc = '[G]oto [D]efinition' })
                    -- vim.keymap.set('n', 'gr', t_builtin.lsp_references, { desc = '[G]oto [R]eferences' })
                    -- vim.keymap.set('n', 'gI', t_builtin.lsp_implementations, { desc = '[G]oto [I]mplementation' })
                    -- vim.keymap.set('n', '<leader>D', t_builtin.lsp_type_definitions, { desc = 'Type [D]efinition' })
                    -- vim.keymap.set('n', '<leader>ds', t_builtin.lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
                    -- vim.keymap.set('n', '<leader>ws', t_builtin.lsp_dynamic_workspace_symbols,
                    --     { desc = '[W]orkspace [S]ymbols' })

                    -- telescope shizzle
                    -- TODO: set desc like above
                    local t_builtin = require("telescope.builtin")

                    vim.keymap.set('n', 'gd', t_builtin.lsp_definitions, opts)
                    vim.keymap.set('n', 'gr', t_builtin.lsp_references, opts)
                    vim.keymap.set('n', 'gI', t_builtin.lsp_implementations, opts)
                    vim.keymap.set('n', '<leader>D', t_builtin.lsp_type_definitions, opts)
                    vim.keymap.set('n', '<leader>ds', t_builtin.lsp_document_symbols, opts)
                    vim.keymap.set('n', '<leader>ws', t_builtin.lsp_dynamic_workspace_symbols, opts)
                end,
            })
        end
    },
}
