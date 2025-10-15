return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        astro = { "prettier" },
        json = { "prettier" },
        css = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    })
  end,
}
