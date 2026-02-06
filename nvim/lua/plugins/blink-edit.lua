return {
  dir = "/home/ricardo/dev/blink-edit.nvim",
  name = "blink-edit.nvim",
  enabled = false,
  config = function()
    require("blink-edit").setup({
      llm = {
        provider = "sweep",
        backend = "openai",
        url = "http://localhost:8000",
        model = "sweep",
        max_tokens= 64,
        temperature= 0,
        timeout_ms = 10000
      },
    })

    -- vim.g.blink_edit_debug = true   -- Summary logs
-- vim.g.blink_edit_debug = 2      -- Verbose (prompts + responses)
  end,
}
