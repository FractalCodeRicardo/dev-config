local api = vim.api
api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    local c_win = api.nvim_get_current_win()

    if not api.nvim_win_is_valid(c_win) then
      return
    end
    local line = api.nvim_get_current_line()
    local file = vim.split(line, " ")[4]

    if vim.fn.filereadable(file) == 1 then
      local content = vim.fn.readblob(file)
      vim.ui.img.set(content, {
        height = 15,
        width = 30,
        col = 25,
        row = 1
      })
    end
  end
})
