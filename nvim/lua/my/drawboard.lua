local M = {}
local api = vim.api;
local keymap = vim.keymap;
local symbol = "@";

local function get_position()
  local pos = vim.fn.getmousepos()
  return {
    row = pos.line - 1,
    col = pos.column
  }
end

local function valid_position(col, row)
  if row < 1 then
    return false
  end
  if col < 0 then
    return false
  end

  local line_count = api.nvim_buf_line_count(M.buffer)
  if row > line_count then
    return false
  end

  local line = api.nvim_buf_get_lines(M.buffer, row - 1, row, false)[1]
  if not line then
    return false
  end

  local line_len = #line
  if col >= line_len then
    return false
  end

  return true
end

local function draw_at(col, row)
  if M.buffer == nil then
    return
  end

  if not valid_position(col, row) then
    return
  end

  print("Draw at " .. col .. " " .. row)
  api.nvim_win_set_cursor(0, { row, col })
  api.nvim_buf_set_text(0, row, col, row, col + 1, { symbol })
end

local function create_event()
  keymap.set("", "<LeftDrag>", function()
    local pos = get_position()
    draw_at(pos.col, pos.row)
  end)
end

local function get_lines(width, height)
  local lines = {}
  local padding = 10
  print("lines " .. width .. " " .. height - padding)
  local line = string.rep(" ", width -padding)
  for _ = 1, height do
    table.insert(lines, line)
  end

  return lines
end

local function float_buffer(buffer, dimensions)
  vim.api.nvim_open_win(buffer, true, {
    relative = "editor",
    width = dimensions.width,
    height = dimensions.height,
    row = dimensions.row,
    col = dimensions.col,
    style = "minimal",
    border = "single",
  })
end

local function get_dimensions()
  local ui = vim.api.nvim_list_uis()[1]

  local width  = math.floor(ui.width  * 1.)
  local height = math.floor(ui.height * 1.)

  local col = 0 --math.floor((ui.width  - width)  / 2)
  local row = 0 --math.floor((ui.height - height) / 2)

  return {
    width = width,
    height = height,
    col = col,
    row = row
  }
  
end

local function create_space_buffer(dimensions)
  local buf = vim.api.nvim_create_buf(true, true)
  float_buffer(buf, dimensions)
  vim.api.nvim_set_current_buf(buf)
  local lines = get_lines(dimensions.width, dimensions.height)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  M.buffer = buf;
end


local function create_command()
  api.nvim_create_user_command("Draw", function()
    local dimensions = get_dimensions()
    create_space_buffer(dimensions)
  end, {})
end

M.init = function()
  create_event();
  create_command();
end


return M;
