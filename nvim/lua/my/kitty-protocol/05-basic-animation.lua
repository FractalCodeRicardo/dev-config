local async = vim.async
local api = vim.api

local h = 50
local w = 50

local square = ""
for i = 1, h * w do
  square = square .. string.char(0, 255, 0, 255)
end

local square64 = vim.base64.encode(square)


local function draw_square()
  local command = string.format(
    "\027_Ga=T,s=%i,v=%i;%s\027\\",
    w,
    h,
    square64
  )
  api.nvim_ui_send(command)
end

local function clear()
  local commandClear = string.format(
    "\027_Ga=d\027\\"
  )

  vim.api.nvim_ui_send(commandClear)
end

local function move(r, c)
  local commandPos = string.format(
    "\027[%i;%iH",
    r,
    c
  )
  api.nvim_ui_send(commandPos)
end


async.run(function()
  for i = 1, 20 do
    clear()
    move(1, i)
    draw_square()
    async.sleep(500)
  end
end)
