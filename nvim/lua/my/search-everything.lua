local timer = vim.uv.new_timer()
local buf = nil
local win = nil

local function search_content(text)
  if (#text == 0) then
    return {}
  end

  local shelltext = vim.fn.shellescape(text)
  local command = "rg --vimgrep --fixed-strings " .. shelltext
  local list = vim.fn.systemlist(command)
  local entries = {}

  for _, item in pairs(list) do
    local values = vim.split(item, ":")
    table.insert(entries, {
      filename = values[1],
      lnum = tonumber(values[2]),
      text = values[4]
    })
  end

  return entries

end

local function search_file(text)

  if (#text == 0) then
    return {}
  end

  local shelltext = vim.fn.shellescape(text)
  local command = "rg --files | rg --fixed-strings " .. shelltext
  print(command)
  local list = vim.fn.systemlist(command)
  local entries = {}

  for _, item in pairs(list) do
    table.insert(entries, {
      filename = item,
      lnum = 1,
      text = "file"
    })
  end

  return entries
end

local function search(text)
  vim.schedule(function ()
    local files = search_file(text)
    local content = search_content(text)
    local entries = {}

    vim.list_extend(entries, files)
    vim.list_extend(entries, content)

    local current = vim.api.nvim_get_current_win()
    vim.fn.setqflist(entries, "r");
    vim.cmd("copen")
    vim.api.nvim_set_current_win(current)
  end)
end

local function create_buffer()
 local buffer = vim.api.nvim_create_buf(false, true)

 vim.api.nvim_buf_attach(buffer, true, {
   on_lines = function ()
     local line = vim.api.nvim_get_current_line()

     timer:stop();

     timer:start(120, 0, function ()
      search(line)
     end)
   end
 })

 return buffer
end

local function create_window(buffer) 
  local window = vim.api.nvim_open_win(
    buffer,
    true, {
      relative='editor',
      row=0,
      col=0,
      width=30,
      height=1,
      style = "minimal",
      title = "Search:",
      border = "rounded"
    }
  )

  return window
end

local function open()
  if (buf == nil or win == nil) then
    buf = create_buffer()
  end

  win = create_window(buf)
  vim.api.nvim_set_current_win(win)
  vim.cmd("startinsert")
end

local function close()
  if (win ~= nil) then
    vim.api.nvim_win_hide(win)
  end
end

local function toggle()
  if (win == nil or not vim.api.nvim_win_is_valid(win)) then
    open()
  else
    close()
  end
end

vim.keymap.set("n", "ff", toggle, {})
