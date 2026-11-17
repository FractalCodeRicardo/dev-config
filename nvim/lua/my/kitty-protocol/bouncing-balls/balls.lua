local api = vim.api
local async = vim.async
local shape = require("shape")
local kitty = require("kitty")

local size = 20
local play = true
local window_size = {
  h = 500,
  w = 500
}

kitty.hide_cursor()

vim.keymap.set("n", "<Leader>m", function()
  play = false
  kitty.show_cursor()
end, {})

local balls = {}

for i = 1, 100 do
  local pos = { x = math.random(window_size.w), y = math.random(window_size.h) }
  local dir = { x = math.random(3), y = math.random(3) }
  local bytes = shape.bytes(size)
  local id = kitty.create_image(bytes, size)
  balls[i] = {}
  balls[i].pos = pos
  balls[i].dir = dir
  balls[i].id = id
end
local function clamp(value, min, max)
  return math.max(min, math.min(value, max))
end
local function move_ball(ball)
  local pos = ball.pos
  local dir = ball.dir
  local id = ball.id

  kitty.move_cursor(pos.x, pos.y)
  kitty.place(id, pos.x, pos.y)

  local newpos = {
    x = pos.x + dir.x,
    y = pos.y + dir.y
  }

  local change = false
  if newpos.x <= 0 or newpos.x > window_size.w then
    dir.x = dir.x * -1
    change = true
  end

  if newpos.y <= 0 or newpos.y > window_size.h then
    dir.y = dir.y * -1
    change = true
  end

  if not change then
    ball.pos = newpos
  end

end

local function loop()
  for _, ball in ipairs(balls) do
    move_ball(ball)
  end
end


async.run(function()
  while true do
    if not play then
      break
    end

    loop()
    async.sleep(5)
  end
end)
