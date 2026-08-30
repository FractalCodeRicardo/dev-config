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
local dx = 1
local dy = 1
timer:start(0, 50, function()
  vim.schedule(function()

    local opts = img.get(id)

    local col = opts.col + dx
    local row = opts.row + dy

    if col < 0 or col > 40 then
      dx = dx * -1
      return
    end

    if row < 0 or row > 30 then
      dy = dy * -1
      return
    end

    img.set(id, {
      col = col,
      row = row
    })
  end)
end)
