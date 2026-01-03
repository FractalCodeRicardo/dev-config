
local win = nil
local buf = nil

local function toggle_term()
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_hide(win)
    win = nil
    return
  end

  if not buf or not vim.api.nvim_buf_is_valid(buf) then
    vim.cmd("below split | terminal")
    buf = vim.api.nvim_get_current_buf()
    win = vim.api.nvim_get_current_win()
    vim.bo[buf].bufhidden = "hide"
  else
    vim.cmd("below split")
    win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf)
    vim.cmd("startinsert")
  end
end

vim.keymap.set("n", "<C-t>", toggle_term, {});
vim.keymap.set("t", "<C-t>", toggle_term, {});

