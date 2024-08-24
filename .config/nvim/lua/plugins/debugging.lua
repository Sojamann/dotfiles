-- see: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "leoluz/nvim-dap-go",
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap-python",
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        require("dapui").setup()

        -- they register adapater and configuration automatically
        require("dap-go").setup()
        require("dap-python").setup(vim.fn.exepath("python"))

        -- see: :help dap-api
        local dap = require("dap")

        -- set that dap-ui opens automatically when the debugging starts
        local dapui = require("dapui")
        dap.listeners.before.attach.dapui_config = dapui.open
        dap.listeners.before.launch.dapui_config = dapui.open
        -- dap.listeners.before.event_terminated.dapui_config = dapui.close
        -- dap.listeners.before.event_exited.dapui_config = dapui.close

        table.insert(dap.configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'Run DSKube',
            program = function()
                local cmd = vim.fn.input("Enter Command: ", "dp apply --dry-run --extrapolate-versions --no-validate-tls")

                local file = io.open("/tmp/debug.py", "w")

                local content = "\z
                import sys\n\z
                from dskubecli.entrypoint import main\n\z
                sys.stdin = open('/tmp/dskubedebugstdin')\n\z
                sys.argv = '%s'.split()\n\z
                main()\n\z
                "

                file:write(string.format(content, "dskubecli " .. cmd))
                file:close()

                return "/tmp/debug.py"
            end,
            -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
        })

        table.insert(dap.configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'Pytest: Current File',
            module= "pytest",
            args= { "${file}" },
        })

        table.insert(dap.configurations.python, {
            type = 'python',
            request = 'launch',
            name = 'Pytest',
            module= "pytest",
            args=function ()
                local what = vim.fn.input("What file[::method]: ")
                return { what }
            end
        })

        -- ==================================
        --            Keymaps
        -- ==================================
        vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
        vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
        vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
        vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
    end,
}
