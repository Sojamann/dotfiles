-- see: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        require("dapui").setup()

        -- they register adapater and configuration automatically
        require("dap-go").setup()
        require("dap-python").setup()

        -- see: :help dap-api
        local dap = require("dap")

        -- set that dap-ui opens automatically when the debugging starts
        local dapui = require("dapui")
        dap.listeners.before.attach.dapui_config = dapui.open
        dap.listeners.before.launch.dapui_config = dapui.open
        dap.listeners.before.event_terminated.dapui_config = dapui.close
        dap.listeners.before.event_exited.dapui_config = dapui.close


        -- ==================================
        --            Keymaps
        -- ==================================
        vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
        vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
        vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
        vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
    end,
}
