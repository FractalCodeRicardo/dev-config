local api = vim.api
local buf = api.nvim_create_buf(false, true)
local win = api.nvim_open_win(buf, true, {
  relative = "editor",
  col = 50, row = 0,
  width = 35, height = 20,
  border = "rounded",
  style = "minimal"
})

vim.bo[buf].filetype = "lua"

api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    local c_win = api.nvim_get_current_win()

    if not api.nvim_win_is_valid(c_win) then
      return
    end

    local c_buf = api.nvim_win_get_buf(c_win)
    local cursor = api.nvim_win_get_cursor(c_win)

    local line = api.nvim_buf_get_lines(c_buf, cursor[1] - 1, cursor[1], false)[1]
    local file = vim.split(line, " ")[4]

    if vim.fn.filereadable(file) == 1 then
      local content = vim.fn.readfile(file)
      api.nvim_buf_set_lines(buf, 0, -1, false, content)
    end
  end
})
