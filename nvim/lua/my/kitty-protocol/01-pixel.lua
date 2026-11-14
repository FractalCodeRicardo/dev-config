-- Esc_Ga=T,s=1,v=1;payloadEsc\
-- a=T,s=1,v=1 display it and w=1 h=1 (f=32 by default RGBA)

local api = vim.api
local pixel = string.char(0,255,0,255)
local pixel64 = vim.base64.encode(pixel)

local command = string.format(
  "\027_Ga=T,s=1,v=1;%s\027\\",
  pixel64
)

api.nvim_ui_send(command)
