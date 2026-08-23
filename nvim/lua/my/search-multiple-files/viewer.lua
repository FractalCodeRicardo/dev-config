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
  if buf == nil then
    buf = vim.api.nvim_create_buf(false, true)
  end

  vim.bo[buf].filetype = "lua"
  vim.bo[buf].syntax = "lua"
  local lines = M.get_lines(file, row, col)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  if M.is_close() then
    local current_window = vim.api.nvim_get_current_win()
    local width = vim.api.nvim_win_get_width(current_window)
    local height = vim.api.nvim_win_get_height(current_window)
    win = vim.api.nvim_open_win(buf, false, {
      relative = "editor",
      row = 2,
      col = width - 52,
      height = height -2,
      width = 50,
      style = "minimal",
      border = "rounded",
      zindex = 100,
    })
  end

  vim.api.nvim_win_set_config(win, {
    title = file,
    title_pos = "center"
  })
end

function M.is_close()
  return win == nil or not vim.api.nvim_win_is_valid(win)
end

function M.close()
  if win == nil then
    return
  end

  vim.api.nvim_win_hide(win)
  win = nil
end

return M
