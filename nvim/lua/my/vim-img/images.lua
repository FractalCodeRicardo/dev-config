local img = vim.ui.img

local content = vim.fn.readblob("cat.png")

vim.ui.img.del(math.huge)

local id = img.set(content, {
  height = 10,
  width = 30,
  row = 10,
  col = 10
})

local opts = img.get(id)
print(vim.inspect(opts))
