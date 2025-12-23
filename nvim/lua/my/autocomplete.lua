# built-in autocomplete

vim.opt.completeopt = { "menuone", "popup", "fuzzy", "noselect" }

vim.api.nvim_create_autocmd('InsertCharPre', {
  callback = function()
    if vim.fn.pumvisible() == 1 or vim.fn.state('m') == 'm' then
      return
    end

    local clients = vim.lsp.get_clients({ bufnr = 0 })

    if next(clients) ~= nil then
      vim.lsp.completion.get()
    else
      local key = vim.keycode('<C-x><C-n>')
      vim.api.nvim_feedkeys(key, 'm', false)
    end
  end
})

vim.keymap.set("i", "<tab>", function()
  local key = vim.keycode('<tab>')
  if vim.fn.pumvisible() == 1 then
    key = vim.keycode("<C-n>")
  end
  vim.api.nvim_feedkeys(key, 'n', false)
end, {})


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.lsp.completion.enable(true, args.data.client_id, args.buf, {
      autotrigger = false,
      convert = function(item)
        return { abbr = item.label }
      end,
    })
  end,
})
