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
api.nvim_ui_send(command)

local commandClear = string.format(
  "\027_Ga=d\027\\"
)

vim.api.nvim_ui_send(commandClear)
--control data: a=d Esc_Ga=dEsc\
