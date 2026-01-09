--Put mark: m + letter
--go to mark: ' + letter

-- vim.api.nvim_get_mark()
-- vim.ui.select()
--
-- A S D F
local function select_mark()
  local marks = { 'A', 'S', 'D', 'F' }
  local descriptions = {}
  for i = 1, #marks do
    local mark = marks[i]
    local pos = vim.api.nvim_get_mark(mark, {})

    table.insert(descriptions, mark .. pos[4])
    -- print(vim.inspect(pos))
  end

  vim.ui.select(descriptions, { prompt = "Marks" }, function(_, index)
    if index ~= nil then
      local mark = marks[index]
      vim.cmd("normal! '" .. mark)
    end
  end)
end

vim.keymap.set("n", "gm",select_mark, {})

