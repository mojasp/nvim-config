local dap = require("dap")

dap.adapters.lldb = {
    type = "executable",
    command = "/usr/bin/lldb-vscode", -- adjust as needed
    name = "lldb",
    -- for future reference: arguments and configuration to the adapter https://marketplace.visualstudio.com/items?itemName=lanza.lldb-vscode
}

local sample_config = {
    name = "simple config",
    type = "lldb", -- matches the adapter
    request = "launch", -- could also attach to a currently running process
    program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
}

-- local lcmdbug = {
--     name = "lcmdbug_config",
--     type = "lldb", -- matches the adapter
--     request = "launch", -- could also attach to a currently running process
--     program = "/home/moritz/Documents/Studium/Praktikum/sketches/lcm_proof_of_concept/lcm/examples/cpp_security/demo_instance",
--     cwd = "${workspaceFolder}/examples/cpp_security",
--     stopOnEntry = false,
--     args = { "instances/alice.toml" },
--     env = { "LD_LIBRARY_PATH=${workspaceFolder}/build/lcm" },
--     runInTerminal = false,
-- }

dap.configurations.cpp = {
    --lcmdbug
    sample_config
}

-------------DAPUI CONFIGURATION----------------
require("dapui").setup({})
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
