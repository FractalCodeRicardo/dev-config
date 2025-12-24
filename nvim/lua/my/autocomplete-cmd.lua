vim.opt.wildmode = "noselect"
vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = ":",
  callback = function ()
    vim.fn.wildtrigger()
  end
})
