vim.api.nvim_create_user_command("Dotnet", function()
  vim.cmd("compiler dotnet")
  vim.opt.makeprg = "dotnet build"
  vim.cmd("make")
  vim.cmd("copen")
end, {nargs=0})


vim.api.nvim_create_user_command("Rust", function()
  vim.cmd("compiler cargo")
  vim.opt.makeprg = "cargo build"
  vim.cmd("make")
  vim.cmd("copen")
end, {nargs=0})


vim.api.nvim_create_user_command("TypeScript", function()
  vim.cmd("compiler tsc")
  vim.opt.makeprg = "npx tsc"
  vim.cmd("make")
  vim.cmd("copen")
end, {nargs=0})
