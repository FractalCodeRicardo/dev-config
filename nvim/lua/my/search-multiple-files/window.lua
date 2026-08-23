local M = {}

local win = nil
local buf = nil

local line_search = 1
local line_replace = 2
local line_entries = 3

local perform_replace = nil
local perform_cursor_moved = nil
local perform_buffer_change = nil
local perform_close = nil

function M.on_replace(perform)
  perform_replace = perform
end

function M.on_cursor_moved(perform)
  perform_cursor_moved = perform
end

function M.on_buffer_change(perform)
  perform_buffer_change = perform
end

function M.on_perform_close(perform)
  perform_close = perform
end

function M.get_buffer_value(line, tag)
  if buf == nil then
    return ""
  end

  local search = vim.api.nvim_buf_get_lines(buf, line - 1, line, false)

  if #search < 1 then
    return ""
  end

  local split = vim.split(search[1], tag)
  return vim.trim(split[2])
end

function M.get_search_string()
  return M.get_buffer_value(line_search, "Search:")
end

function M.get_replace_string()
  return M.get_buffer_value(line_replace, "ReplaceMe:")
end

function M.create_buffer()
  local buffer = vim.api.nvim_create_buf(false, true)
  vim.bo[buffer].filetype = "lua"
  vim.bo[buffer].syntax = "lua"
  return buffer
end

function M.create_window(buffer)
  local current_window = vim.api.nvim_get_current_win()
  local width = vim.api.nvim_win_get_width(current_window)
  local height = vim.api.nvim_win_get_height(current_window)

  local window = vim.api.nvim_open_win(
    buffer,
    true, {
      relative = 'editor',
      row = 2,
      col = 2,
      width = width - 2,
      height = height - 2,
      style = "minimal",
      title = "Search / ReplaceMe",
      border = "rounded"
    }
  )

  vim.api.nvim_buf_set_lines(buffer, 0, -1, false, {
    "Search: ",
    "ReplaceMe: ",
  })

  vim.keymap.set("n", "<leader>R", function()
      if perform_replace ~= nil then
        perform_replace()
      end
    end,
    { buf = buf }
  )

  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = buf,
    callback = function(args)
      if perform_cursor_moved ~= nil and not M.is_close() then
        perform_cursor_moved()
      end
    end
  })

  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function(args)
      if buf == args.buf then
        if perform_buffer_change ~= nil then
          perform_buffer_change()
        end
      end
    end
  })

  return window
end

function M.close()
  if win == nil then
    return
  end

  vim.api.nvim_win_hide(win)

  if perform_close ~= nil then
    perform_close()
  end
end

function M.is_close()
  if win == nil then
    return true
  end

  return not vim.api.nvim_win_is_valid(win)
end

function M.toogle()
  if M.is_close() then
    M.open()
  else
    M.close()
  end
end

function M.open()
  if buf == nil or win == nil then
    buf = M.create_buffer()
  end

  win = M.create_window(buf)
  vim.api.nvim_set_current_win(win)
  vim.cmd("startinsert")
end

function M.append_entries(entries)
  if buf == nil then
    return
  end

  vim.api.nvim_buf_set_lines(
    buf,
    line_entries - 1,
    -1,
    false,
    entries
  )
end

function M.get_buf()
  return buf
end

function M.get_cursor_line()
  if win == nil then
    return nil
  end

  if M.is_close() then
    return nil
  end

  local cursor = vim.api.nvim_win_get_cursor(win)
  local line = cursor[1]

  return line
end

function M.mark_replaced(current_lines)
  if buf == nil then
    return
  end

  local new_lines = {}
  for _, line in pairs(current_lines) do
    table.insert(new_lines, line .. " ✅")
  end
  vim.api.nvim_buf_set_lines(buf, line_entries - 1, -1, false, new_lines)
end

return M
