return {
    {
        "williamboman/mason.nvim",
        config=function()
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

            -- see: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
            local opts = {capabilities = capabilities}
            lspconfig.clangd.setup(opts)
            lspconfig.gopls.setup(opts)
            lspconfig.zls.setup(opts)
            lspconfig.lua_ls.setup(opts)

            -- only enabled when npm is installed as this is a heavy
            -- dependency and these language servers are nice but not
            -- super important
            if vim.fn.executable('npm') == 1 then
                lspconfig.pyright.setup({})
                lspconfig.bashls.setup({})
            end
        end
    },
}
