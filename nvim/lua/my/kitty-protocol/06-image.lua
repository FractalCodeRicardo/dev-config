-- Esc_Ga=T,f=100;payloadEsc\
--
local content = vim.fn.readblob("pacman_1.png")
local content64 = vim.base64.encode(content)

local command = string.format(
  "\027_Ga=T,f=100;%s\027\\",
  content64
)

vim.api.nvim_ui_send(command)


