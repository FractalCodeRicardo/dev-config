vim.api.nvim_create_autocmd('User', {
  pattern = 'DirReadPost',
  callback = function(args)
    print("changing order")
    local names = vim.api.nvim_buf_get_lines(args.buf, 0, -1, true)
    table.sort(names, function(a, b)
      return a > b
    end)
    vim.api.nvim_buf_set_lines(args.buf, 0, -1, true, names)
  end,
})
