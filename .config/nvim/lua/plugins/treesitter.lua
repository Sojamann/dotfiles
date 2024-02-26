return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        local treesitter_configs = require("nvim-treesitter.configs")
        treesitter_configs.setup({
            ensure_installed = {
                "bash",
                "c",
                "html",
                "gomod",
                "gitcommit",
                "gitignore",
                "json",
                "lua",
                "markdown",
                "make",
                "go",
                "python",
                "sql",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
                "zig",
            },
            highlight = {
                enabled = true,
                additional_vim_regex_highlighting = true,
            },
            indent = { enable = true },
            -- disable for large files
            disable = function(_, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<CR>',
                    scope_incremental = '<CR>',
                    node_incremental = '<TAB>',
                    node_decremental = '<S-TAB>',
                },
            },
        })
    end
}
