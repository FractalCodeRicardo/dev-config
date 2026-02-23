local buff = vim.api.nvim_create_buf(false, true)

local function update_lines()
  local diagnostics = vim.diagnostic.get(0)

  local lines = {}
  for _, d in pairs(diagnostics) do
    local file_name = vim.api.nvim_buf_get_name(d.bufnr)
    local message = d.message
    local line = file_name .. " / " .. message

    table.insert(lines, line)
  end

  vim.api.nvim_buf_set_lines(buff, 0, -1, false, lines)
end

local is_open = false
local function open_window() 
  if is_open then
    return
  end

  vim.api.nvim_open_win(buff, false, {
    relative = "editor",
    col = 80,
    row = 100, 
    width = 60,
    height = 10
  })

  is_open = true
end


vim.api.nvim_create_autocmd('DiagnosticChanged', {
  callback = function()
    open_window()
    update_lines()
  end
}) 
