return {
    "nvim-neotest/neotest",
    enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "Issafalcon/neotest-dotnet",
    },
    config = function()
        local neotest = require("neotest")

        neotest.setup({
            adapters = {
                require("neotest-dotnet")({
                    dap = { justMyCode = false }, -- Optional Debug Adapter Protocol (DAP) settings
                }),
            },

            icons = {
                running = "🔥", -- Change this to something larger
                passed = "✅", -- Passed test
                failed = "❌", -- Failed test
                skipped = "⚠️", -- Skipped test
                unknown = "❓", -- Unknown state
            },
        })

        require("neotest-dotnet")({
            runner = "dotnet", -- Forces dotnet test (faster)
        })

        local map = vim.keymap;

        map.set("n", "<leader>tt", function() neotest.run.run() end, { desc = "Run nearest test" })
        map.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end,
            { desc = "Run all tests in file" })
        map.set("n", "<leader>ts", function() neotest.run.run(vim.fn.getcwd()) end,
            { desc = "Run all tests in project" })
        map.set("n", "<leader>tv", function() neotest.output.open({ enter = true }) end,
            { desc = "Open test output" })
        map.set("n", "<leader>tl", function() neotest.run.run_last() end, { desc = "Run last test" })
        map.set("n", "<leader>td", function() neotest.run.run({ strategy = "dap" }) end,
            { desc = "Debug nearest test" })
    end
}
