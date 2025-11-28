return {
  "seblyng/roslyn.nvim",
  enabled = true,
  ft = "cs",
  config = function()
    vim.lsp.config("roslyn", {
      on_attach = function()
        print("This will run when the server attaches!")
      end,
      settings = {
      },

    })
    local roslyn = require("roslyn");
    roslyn.setup();

    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
      pattern = "*",
      callback = function()
        local clients = vim.lsp.get_clients({ name = "roslyn" })
        if not clients or #clients == 0 then
          return
        end

        local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
        for _, buf in ipairs(buffers) do
          vim.lsp.util._refresh("textDocument/diagnostic", { bufnr = buf })
        end
        print("Client refresh ")
      end,
    })
  end


}
