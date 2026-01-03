
local function append_lines(arr, str)
  local lines = vim.split(str, "\n", { plain = true })
  for _, line in ipairs(lines) do
    table.insert(arr, line)
  end
end

local function eval_buffer()
  -- get lines
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local chunk = table.concat(lines, "\n")

  -- crea buf if not exists
  local buf_name = "LuaOutput"
  local buf = vim.fn.bufnr(buf_name)
  if buf == -1 then
    buf = vim.api.nvim_create_buf(false, true) 
    vim.api.nvim_buf_set_name(buf, buf_name)
  end

  -- if exists
  local win = vim.fn.bufwinnr(buf)
  if win == -1 then
    vim.cmd("botright split")
    vim.api.nvim_win_set_buf(0, buf)
    vim.api.nvim_win_set_height(0, 10)
  end

  -- clear buf
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  local output = {}

  local old_print = print
  print = function(...)
    local args = {}
    for i = 1, select("#", ...) do
      table.insert(args, tostring(select(i, ...)))
    end
    local text = table.concat(args, "\t")
    append_lines(output, text)
  end

  -- Run Lua code
  local ok, result = pcall(load(chunk))

  -- Restore original print
  print = old_print

  -- result 
  if ok then
    if result ~= nil then
      table.insert(output, "Result: " .. vim.inspect(result))
    else
      table.insert(output, "✔ Buffer executed successfully")
    end
  else
    table.insert(output, "❌ Error: " .. result)
  end

  -- set lines in buf 
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
end


vim.keymap.set("n", "<leader>eb", eval_buffer)
