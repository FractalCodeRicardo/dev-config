local selector = {};

selector.select = function(callback)
  local dir = vim.fn.getcwd()
  local files = vim.fn.glob(dir .. '/**/*.csproj', 0, 1)

  -- Show the options to the user
  vim.ui.select(
    files,
    {
      prompt = 'Seleccionar el proyecto:'
    },
    function(choice)
      callback(choice)
    end
  )
end

return selector;
