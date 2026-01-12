local function keymap_list()
  local keymaps = vim.api.nvim_exec2("map", { output = true }).output
  local lines = vim.split(keymaps, "\n")
  local buff = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_set_current_buf(buff)
  vim.api.nvim_buf_set_lines(buff, 0, -1, false, lines)
end

vim.keymap.set("n", "gk", keymap_list,{})
