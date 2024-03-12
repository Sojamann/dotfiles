return {

    -- "gcc" line comment in normal mode
    -- "gbc" block comment in normal mode
    -- "gc" line comment out/in in visual mode
    -- "gb" block comment out/in in visual mode
    { 'numToStr/Comment.nvim', opts = {} },
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help ibl`
        main = 'ibl',
        opts = {},
    },
    -- Detect tabstop and shiftwidth automatically
    { 'tpope/vim-sleuth' },
}
