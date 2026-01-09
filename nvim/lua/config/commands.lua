
vim.api.nvim_create_user_command("SaveMacro", function (params)
  local name = params.args
  local dir = vim.fn.expand("~/.config/nvim/macros/")
  local file = dir .. name .. ".macro"
  local content = vim.fn.getreg("q")

  vim.fn.mkdir(dir, "p")

  vim.fn.writefile(
    {content},
    file,
    "a"
  )
end, {nargs = 1})


vim.api.nvim_create_user_command("LoadMacro", function (params)
  local name = params.args
  local dir = vim.fn.expand("~/.config/nvim/macros/")
  local file = dir .. name .. ".macro"

  local content = vim.fn.readfile(file)

 vim.fn.setreg("q", content)
end, {nargs = 1})

vim.api.nvim_create_user_command("Reload", function () 
  vim.cmd(":source $MYVIMRC")
end
,{})

--autosave
vim.api.nvim_create_autocmd("BufLeave", {
  callback = function ()
    if vim.bo.readonly then
      return
    end

    if not vim.bo.modifiable then
      return
    end

    if not vim.bo.modified then
      return
    end

    vim.cmd("write")
  end
})
