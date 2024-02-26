-- Set leader
vim.g.mapleader = " "
vim.g.maplocalleader = ' '

-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Cosmetics
vim.opt.guicursor = ""
vim.opt.colorcolumn = "90"

-- Line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Text wrapping
vim.opt.wrap = false

-- Indenting
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

-- Case-insensitive searching UNLESS capital letter in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Scroll settings
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 500 -- time to wait for determining that a keymap seq is finished

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Allow color assuming that terminals these days support it
vim.o.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

