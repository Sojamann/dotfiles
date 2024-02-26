-- the point of null-ls / none-ls is to provide stuff like linting, formatting
-- etc. in case there is no lsp for it or it does not have the functionality.
-- This is done by being a language server which integrates the external tools.

return {
    -- fork of null-ls as this is not mainted anymore
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
            -- see https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
            --
            -- NOTE: that some of the 'sources' are not needed as their
            --          functionality is also available through their lsp.
            -- NOTE: some of the things one can use here like stylua must
            --          be either installed manually so that none-ls can
            --          wrap this tool or be installed using mason
			sources = {
                -- lua
                null_ls.builtins.completion.luasnip,

                -- python
                null_ls.builtins.diagnostics.pylint,

                -- go
                null_ls.builtins.code_actions.gomodifytags,
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.goimports,
			},
		})
	end
}
