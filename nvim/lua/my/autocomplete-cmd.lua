vim.opt.wildmode = "noselect"
vim.opt.wildoptions = "pum,fuzzy"
vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = "/",
  callback = function ()
    vim.fn.wildtrigger()
  end
})
