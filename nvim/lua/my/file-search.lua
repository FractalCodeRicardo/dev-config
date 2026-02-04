local function search(text)
  local files = vim.fn.glob("**/*" .. text .."*", false, true)

  local entries = {}
  for _, f in pairs(files) do
    table.insert(entries, {
      filename = f,
      lnum = 1,
      col = 1
    })
  end

  vim.fn.setqflist(entries, "r")
  vim.cmd("copen")
end

vim.api.nvim_create_user_command("FileSearch", function (opts)
  search(opts.args)
end,
{nargs = 1})
