local api = vim.api
local h = 50
local w = 50

local square = ""
for i = 1, h*w do
  square = square .. string.char(0,255,0,255)
end

local square64 = vim.base64.encode(square)

local command = string.format(
  "\027_Ga=T,s=%i,v=%i;%s\027\\",
  w,
  h,
  square64
)

local commandPos = string.format(
  "\027[%i;%iH",
  10,
  15
)
-- ESC[row;columnH to change cursor position
api.nvim_ui_send(commandPos)
api.nvim_ui_send(command)
