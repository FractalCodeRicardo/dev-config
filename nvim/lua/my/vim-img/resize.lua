local img = vim.ui.img

local content = vim.fn.readblob("cat.png")

vim.ui.img.del(math.huge)

local id = img.set(content, {
  height = 10,
  width = 30,
  row = 10,
  col = 10
})

local timer = vim.uv.new_timer()
local dh = 0.5
local dw = 0.5
timer:start(0, 50, function()
  vim.schedule(function()

    local opts = img.get(id)

    local h = opts.height + dh
    local w = opts.width + dw

    if h < 0 or h > 15 then
      dh = dh * -1
      return
    end

    if w < 0 or w > 35 then
      dw = dw * -1
      return
    end

    img.set(id, {
      height = h,
      width = w
    })
  end)
end)
