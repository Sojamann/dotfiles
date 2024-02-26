-- ==================================
--            GENERAL
-- ==================================

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set("n", "Q", "<nop>")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Open the file browser
vim.keymap.set("n", "<Tab><Tab>", vim.cmd.Ex)

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

-- Formatting
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Better window movements
-- TODO: there is probably a vim.api function for that
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Diagnostics
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- ==================================
--            TELESCOPE
-- ==================================

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

--
vim.keymap.set('n', '<leader>sf', t_builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', t_builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', t_builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', t_builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', t_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', t_builtin.resume, { desc = '[S]earch [R]esume' })

-- system releated
vim.keymap.set('n', '<leader>sm', t_builtin.man_pages, { desc = '[S]earch [M]an Pages' })

-- ==================================
--       LSP with Telescope
-- ==================================
vim.keymap.set('n', 'gd', t_builtin.lsp_definitions, { desc='[G]oto [D]efinition'})
vim.keymap.set('n', 'gr', t_builtin.lsp_references, { desc='[G]oto [R]eferences'})
vim.keymap.set('n', 'gI', t_builtin.lsp_implementations, { desc='[G]oto [I]mplementation'})
vim.keymap.set('n', '<leader>D', t_builtin.lsp_type_definitions, { desc='Type [D]efinition'})
vim.keymap.set('n', '<leader>ds', t_builtin.lsp_document_symbols, { desc='[D]ocument [S]ymbols'})
vim.keymap.set('n', '<leader>ws', t_builtin.lsp_dynamic_workspace_symbols, { desc='[W]orkspace [S]ymbols'})

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

        -- telescope shizzle
        vim.keymap.set('n', 'gd', t_builtin.lsp_definitions, opts)
        vim.keymap.set('n', 'gr', t_builtin.lsp_references, opts)
        vim.keymap.set('n', 'gI', t_builtin.lsp_implementations, opts)
        vim.keymap.set('n', '<leader>D', t_builtin.lsp_type_definitions, opts)
        vim.keymap.set('n', '<leader>ds', t_builtin.lsp_document_symbols, opts)
        vim.keymap.set('n', '<leader>ws', t_builtin.lsp_dynamic_workspace_symbols, opts)

    end,
})



-- ==================================
--            Debugging
-- ==================================
vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")

