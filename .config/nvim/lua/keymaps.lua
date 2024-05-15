-- ==================================
--            GENERAL
-- ==================================

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set("n", "Q", "<nop>")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join the line below to this one leaving the cursor where it is
vim.keymap.set("n", "J", "mzJ`z")

-- When jumping a page keep the cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- When going through search results keep the cursor centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- When pasting keep the item in the clipboard buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Better window movements
-- TODO: there is probably a vim.api function for that
vim.keymap.set('n', '<M-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<M-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<M-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<M-l>', ':wincmd l<CR>')

-- Diagnostics
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

