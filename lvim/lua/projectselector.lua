local M = {};

M.select = function()
  local dir = vim.fn.getcwd()
  local files = vim.fn.glob(dir .. '/**/*.csproj', 0, 1)

  --  vim.notify(files[1])
  local choice = vim.fn.inputlist(files)
  if choice < 1 or choice > #files then
    return nil -- User canceled or invalid choice
  end

  return files[choice]
end

return M;
