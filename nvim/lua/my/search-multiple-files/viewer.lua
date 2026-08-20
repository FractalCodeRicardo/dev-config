local M = {}

local buf = nil
local win = nil

function M.get_lines(file, row, col)
  local lines = vim.fn.readfile(file)
  local preview_lines = {}

  for i, line in pairs(lines) do
    if i >= row and i <= row + 10 then
      table.insert(preview_lines, line)
    end
  end

  return preview_lines
end

function M.open(file, row, col)
  buf = vim.api.nvim_create_buf(false, true)
  local lines = M.get_lines(file, row, col)
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, lines)

  if M.is_close() then
    win = vim.api.nvim_open_win(buf, false, {
      relative = "editor",
      row = 10,
      col = 50,
      height = 40,
      width = 40,
      style = "minimal",
      border = "rounded",
      zindex = 100
    })
  end
end

function M.is_close()
  return win == nil or vim.api.nvim_win_is_valid(win)
end

function M.close()
  if win == nil then
    return
  end

  vim.api.nvim_win_hide(win)
  win = nil
end

return M
