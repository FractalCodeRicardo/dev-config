vim.opt.wildmode = "noselect"
vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = ":",
  callback = function ()
    vim.fn.wildtrigger()
  end
})

function _G.my_find(text, _)
  local files = vim.fn.glob("**/*", true, true)

  return vim.fn.matchfuzzy(files, text)
end

vim.opt.findfunc = "v:lua.my_find"
