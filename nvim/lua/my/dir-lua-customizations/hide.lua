vim.api.nvim_create_autocmd("User", {
  pattern = "DirReadPost",
  callback = function()
    vim.cmd([[silent keeppatterns g/^\./d _]])
  end,
})
