vim.api.nvim_create_user_command("TodoList", function ()
  vim.cmd("vimgrep /TODO/ **")
  vim.cmd("copen")
end,
{nargs = 0})
