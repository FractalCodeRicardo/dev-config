local function ripgrep(search)
  local result = vim.fn.systemlist("rg --vimgrep " .. search)
  -- print(vim.inspect(result))

  vim.fn.setqflist({}, "r", {
    title = "Results",
    lines = result
  })

  vim.cmd("copen")
end

vim.api.nvim_create_user_command("Rg", function(args)
  ripgrep(args.args)
  end,
  { nargs = 1 })
